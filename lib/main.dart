import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

void main() {
  runApp(const KutubxonaApp());
}

class KutubxonaApp extends StatelessWidget {
  const KutubxonaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kutubxona',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      ),
      home: const AsosiySahifa(),
    );
  }
}

// 1. Kitob modelini yaratamiz
class Kitob {
  final String nomi;
  final String muallif;
  final IconData ikonka;
  final Color rang;

  const Kitob(this.nomi, this.muallif, this.ikonka, this.rang);
}

class AsosiySahifa extends StatelessWidget {
  const AsosiySahifa({super.key});

  // 2. Kitoblar ro'yxatini yaratamiz
  final List<Kitob> kitoblar = const [
    Kitob('Matematika darsligi', 'Muallif: A. Karimov', Icons.book, Colors.blue),
    Kitob('Fizika ilmiy qo\'llanma', 'Muallif: B. Toshmatov', Icons.science, Colors.orange),
    Kitob('Biologiya slaydlari', 'Taqdimot', Icons.slideshow, Colors.green),
    Kitob('Ingliz tili grammatikasi', 'Muallif: C. Smith', Icons.language, Colors.purple),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kutubxona', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: kitoblar.length + 1, // +1 sarlavha uchun
        itemBuilder: (context, index) {
          if (index == 0) {
            return const Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: Text('Yangi kelganlar', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            );
          }
          final kitob = kitoblar[index - 1];
          return _kitobKartasi(context, kitob);
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Asosiy'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Qidiruv'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }

  // 3. Kartochka yasash funksiyasi (endi Kitob obyektini qabul qiladi)
  Widget _kitobKartasi(BuildContext context, Kitob kitob) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: kitob.rang.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(kitob.ikonka, color: kitob.rang, size: 30),
        ),
        title: Text(kitob.nomi, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        subtitle: Text(kitob.muallif),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: () {
          // 4. Kitobni bosganda yangi sahifaga o'tish
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => KitobSahifasi(kitob: kitob),
            ),
          );
        },
      ),
    );
  }
}

// 5. Kitobning ichki sahifasi (KitobSahifasi)
class KitobSahifasi extends StatelessWidget {
  final Kitob kitob;
  const KitobSahifasi({super.key, required this.kitob});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(kitob.nomi)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(kitob.ikonka, size: 100, color: kitob.rang),
            const SizedBox(height: 20),
            Text(
              kitob.nomi,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              kitob.muallif,
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () async {
                final directory = await getApplicationDocumentsDirectory();
                final file = File('${directory.path}/kitob.pdf');

                if (!await file.exists()) {
                  final data = await DefaultAssetBundle.of(context).load('assets/kitob.pdf');
                  await file.writeAsBytes(data.buffer.asUint8List());
                }

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Scaffold(
                      appBar: AppBar(title: Text(kitob.nomi)),
                      body: PDFView(
                        filePath: file.path,
                        enableSwipe: true,
                        swipeHorizontal: false,
                        autoSpacing: false,
                        pageFling: false,
                      ),
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.download),
              label: const Text('Yuklab olish / O\'qish'),
            ),
          ],
        ),
      ),
    );
  }
}