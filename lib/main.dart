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

// --- BO'LIM MODELI ---
class Bolim {
  final String nomi;
  final IconData ikonka;
  final Color rang;
  final List<Kitob> kitoblar;

  const Bolim(this.nomi, this.ikonka, this.rang, this.kitoblar);
}

// --- BO'LIMLAR VA ULAR ICHIDAGI KITOBLAR ---
const List<Bolim> hammaBolimlar = [
  Bolim(
    'Odam anatomiyasi',
    Icons.accessibility_new,
    Colors.blue,
    [
      Kitob(
        'Odam anatomiyasi (1-jild) - Ahmedov',
        'https://github.com/kenshi007f/kutubxona_app/raw/main/Ahmedov_2018_1_jild.pdf'
      ),
      Kitob(
        'Odam anatomiyasi (2-jild) - Ahmedov',
        'https://github.com/kenshi007f/kutubxona_app/raw/main/Ahmedov_2018_2_jild.pdf'
      ),
      Kitob(
        'Odam anatomiyasi - Gadayev, Mirsharapov',
        'https://github.com/kenshi007f/kutubxona_app/releases/download/v1.0/Gadayev_Mirsharapov_Odam_anatomiyasi.pdf'
      ),
      Kitob(
        'Odam anatomiyasi - F. Bahodirov',
        'https://github.com/kenshi007f/kutubxona_app/raw/main/Odam_anatomiyasi_Bahodirov.pdf'
      ),
      Kitob(
        'Anatomiya - Xudoyberdiyev',
        'https://github.com/kenshi007f/kutubxona_app/raw/main/Anatomiya_Xudoyberdiyev.pdf'
      ),
    ],
  ),
];

// --- ASOSIY SAHIFA (BO'LIMLAR RO'YXATI) ---
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
        itemCount: hammaBolimlar.length,
        itemBuilder: (context, index) {
          final bolim = hammaBolimlar[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              leading: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: bolim.rang.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(bolim.ikonka, color: bolim.rang, size: 36),
              ),
              title: Text(bolim.nomi, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              subtitle: Text('${bolim.kitoblar.length} ta kitob mavjud'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BolimSahifasi(bolim: bolim)),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// --- BO'LIM ICHIDAGI SAHIFA (KITOBLAR RO'YXATI) ---
class BolimSahifasi extends StatelessWidget {
  final Bolim bolim;
  const BolimSahifasi({super.key, required this.bolim});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(bolim.nomi),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: bolim.kitoblar.length,
        itemBuilder: (context, index) {
          final kitob = bolim.kitoblar[index];
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

  Future<void> _faylniTekshirish() async {
    final directory = await getApplicationDocumentsDirectory();
    final faylNomi = widget.kitob.nomi.replaceAll(' ', '_').replaceAll("'", "") + '.pdf';
    final file = File('${directory.path}/$faylNomi');

    if (await file.exists()) {
      setState(() { _pdfFayl = file; });
    }
  }

  Future<void> _yuklash() async {
    setState(() { _yuklanmoqda = true; });
    try {
      final directory = await getApplicationDocumentsDirectory();
      final faylNomi = widget.kitob.nomi.replaceAll(' ', '_').replaceAll("'", "") + '.pdf';
      final file = File('${directory.path}/$faylNomi');

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