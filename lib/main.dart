import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

void main() {
  runApp(const MedKutubxonaApp());
}

class MedKutubxonaApp extends StatelessWidget {
  const MedKutubxonaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MedKutubxona',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.grey[50],
      ),
      home: const AsosiySahifa(),
    );
  }
}

// --- KITOB MODELI ---
class Kitob {
  final String nomi;
  final String havola;
  const Kitob(this.nomi, this.havola);
}

// --- FAN MODELI ---
class Fan {
  final String nomi;
  final List<Kitob> kitoblar;
  const Fan(this.nomi, this.kitoblar);
}

// --- KURS (DARAJALI) MODELI ---
class Kurs {
  final String nomi;
  final IconData ikonka;
  final Color rang;
  final List<Fan> fanlar;

  const Kurs(this.nomi, this.ikonka, this.rang, this.fanlar);
}

// --- BARCHA MA'LUMOTLAR ---
const List<Kurs> hammaKurslar = [
  Kurs(
    '1-darajali fanlar',
    Icons.looks_one,
    Colors.teal,
    [
      Fan(
        'Anatomiya',
        [
          Kitob(
            'Odam anatomiyasi - F. Bahodirov',
            'https://t.me/Med_kutubxona_1/2/10?single'
          ),
          Kitob(
            'Odam anatomiyasi - Xudoyberdiyev (1993)',
            'https://t.me/Med_kutubxona_1/2/11?single'
          ),
          Kitob(
            'Odam anatomiyasi - Gadayev, Mirsharapov',
            'https://t.me/Med_kutubxona_1/2/12?single'
          ),
          Kitob(
            'Anatomiya 1-jild - A. Ahmedov',
            'https://t.me/Med_kutubxona_1/2/13?single'
          ),
          Kitob(
            'Anatomiya 2-jild - A. Ahmedov',
            'https://t.me/Med_kutubxona_1/2/15?single'
          ),
        ],
      ),
      // Keyingi fanlarni shu yerga qo'shasiz (Fiziologiya, va h.k.)
    ],
  ),
  // Keyingi kurslarni shu yerga qo'shasiz (2-darajali, 3-darajali...)
];

// --- ASOSIY SAHIFA (KURSLAR RO'YXATI) ---
class AsosiySahifa extends StatelessWidget {
  const AsosiySahifa({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MedKutubxona', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: hammaKurslar.length,
        itemBuilder: (context, index) {
          final kurs = hammaKurslar[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              leading: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: kurs.rang.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(kurs.ikonka, color: kurs.rang, size: 36),
              ),
              title: Text(kurs.nomi, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              subtitle: Text('${kurs.fanlar.length} ta fan mavjud'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => KursSahifasi(kurs: kurs)),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// --- KURS ICHIDAGI SAHIFA (FANLAR RO'YXATI) ---
class KursSahifasi extends StatelessWidget {
  final Kurs kurs;
  const KursSahifasi({super.key, required this.kurs});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(kurs.nomi),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: kurs.fanlar.length,
        itemBuilder: (context, index) {
          final fan = kurs.fanlar[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              leading: const Icon(Icons.book, color: Colors.indigo, size: 30),
              title: Text(fan.nomi, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              subtitle: Text('${fan.kitoblar.length} ta kitob'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FanSahifasi(fan: fan)),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// --- FAN ICHIDAGI SAHIFA (KITOBLAR RO'YXATI) ---
class FanSahifasi extends StatelessWidget {
  final Fan fan;
  const FanSahifasi({super.key, required this.fan});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(fan.nomi),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: fan.kitoblar.length,
        itemBuilder: (context, index) {
          final kitob = fan.kitoblar[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              leading: const Icon(Icons.picture_as_pdf, color: Colors.red, size: 30),
              title: Text(kitob.nomi, style: const TextStyle(fontWeight: FontWeight.w600)),
              subtitle: const Text('PDF formatda'),
              trailing: const Icon(Icons.download_for_offline, color: Colors.indigo),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => KitobOchishSahifasi(kitob: kitob)),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// --- KITOB OCHISH VA YUKLASH SAHIFASI ---
class KitobOchishSahifasi extends StatefulWidget {
  final Kitob kitob;
  const KitobOchishSahifasi({super.key, required this.kitob});

  @override
  State<KitobOchishSahifasi> createState() => _KitobOchishSahifasiState();
}

class _KitobOchishSahifasiState extends State<KitobOchishSahifasi> {
  bool _yuklanmoqda = false;
  File? _pdfFayl;

  @override
  void initState() {
    super.initState();
    _faylniTekshirish();
  }

  // 1. Fayl telefonda bormi, yo'qmi tekshiramiz
  Future<void> _faylniTekshirish() async {
    final directory = await getApplicationDocumentsDirectory();
    final faylNomi = widget.kitob.nomi.replaceAll(' ', '_').replaceAll("'", "").replaceAll("/", "_") + '.pdf';
    final file = File('${directory.path}/$faylNomi');

    if (await file.exists()) {
      setState(() { _pdfFayl = file; });
    }
  }

  // 2. Internetdan yuklash funksiyasi
  Future<void> _yuklash() async {
    setState(() { _yuklanmoqda = true; });
    try {
      final directory = await getApplicationDocumentsDirectory();
      final faylNomi = widget.kitob.nomi.replaceAll(' ', '_').replaceAll("'", "").replaceAll("/", "_") + '.pdf';
      final file = File('${directory.path}/$faylNomi');

      // Internetdan yuklab olish (Telegram havolasidan)
      final response = await http.get(Uri.parse(widget.kitob.havola));

      if (response.statusCode == 200) {
        await file.writeAsBytes(response.bodyBytes);
        setState(() {
          _pdfFayl = file;
          _yuklanmoqda = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Kitob muvaffaqiyatli yuklandi!')),
        );
      } else {
        throw Exception('Yuklashda xatolik');
      }
    } catch (e) {
      setState(() { _yuklanmoqda = false; });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Xatolik! Internet aloqasini tekshiring.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.kitob.nomi, style: const TextStyle(fontSize: 16)),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: _yuklanmoqda
            ? const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text('Yuklanmoqda... Iltimos kuting'),
                ],
              )
            : _pdfFayl != null
                ? PDFView(
                    filePath: _pdfFayl!.path,
                    enableSwipe: true,
                    swipeHorizontal: false,
                    autoSpacing: false,
                    pageFling: false,
                  )
                : Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.cloud_download, size: 100, color: Colors.indigo),
                        const SizedBox(height: 20),
                        Text(
                          'Bu kitob hali yuklanmagan.\nInternetdan yuklab oling.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton.icon(
                          onPressed: _yuklash,
                          icon: const Icon(Icons.download),
                          label: const Text('Yuklab olish'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                            backgroundColor: Colors.indigo,
                            foregroundColor: Colors.white,
                            textStyle: const TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}