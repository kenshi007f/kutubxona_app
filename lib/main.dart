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

// --- MODELLAR ---
class Kitob {
  final String nomi;
  final String havola;
  const Kitob(this.nomi, this.havola);
}

class Fan {
  final String nomi;
  final List<Kitob> kitoblar;
  const Fan(this.nomi, this.kitoblar);
}

class Kurs {
  final String nomi;
  final IconData ikonka;
  final Color rang;
  final List<Fan> fanlar;

  const Kurs(this.nomi, this.ikonka, this.rang, this.fanlar);
}

// --- BARCHA MA'LUMOTLAR (1-DARAJALI FANLAR) ---
const List<Kurs> hammaKurslar = [
  Kurs(
    '1-darajali fanlar',
    Icons.looks_one,
    Colors.teal,
    [
      // 1. ANATOMIYA
      Fan(
        'Anatomiya',
        [
          Kitob('Odam anatomiyasi - F. Bahodirov', 'https://github.com/kenshi007f/kutubxona_app/releases/download/Anatomiyа/Odam_anatomiyasi_Bahodirov.pdf'),
          Kitob('Odam anatomiyasi - F. Bahodirov (2005)', 'https://github.com/kenshi007f/kutubxona_app/releases/download/Anatomiyа/Odam_anatomiyasi_Bahodirov_2005.pdf'),
          Kitob('Odam anatomiyasi - Gadayev, Mirsharapov', 'https://github.com/kenshi007f/kutubxona_app/releases/download/Anatomiyа/Gadayev_Mirsharapov_Odam_anatomiyasi.pdf'),
          Kitob('Odam anatomiyasi - Xudoyberdiyev', 'https://github.com/kenshi007f/kutubxona_app/releases/download/Anatomiyа/Anatomiya_Xudoyberdiyev.pdf'),
          Kitob('Anatomiya 1-jild - A. Ahmedov', 'https://github.com/kenshi007f/kutubxona_app/releases/download/Anatomiyа/Anatomiya.1-jild.A.Ahmedov.2018.pdf'),
          Kitob('Anatomiya 2-jild - A. Ahmedov', 'https://github.com/kenshi007f/kutubxona_app/releases/download/Anatomiyа/Ahmedov_2018_2_jild.pdf'),
        ],
      ),

      // 2. ANATOMIYA ATLASLARI
      Fan(
        'Anatomiya (Atlaslar)',
        [
          Kitob('Atlas 1-tom - Sinelnikov', 'https://github.com/kenshi007f/kutubxona_app/releases/download/Anatomiyа_atlas/ATLAS_ANATOMIYA_1_TOM_SINELNIKOV.pdf'),
          Kitob('Atlas 2-tom - Teshaev', 'https://github.com/kenshi007f/kutubxona_app/releases/download/Anatomiyа_atlas/Anatomiya.Atlas_2_tom_Teshaev.pdf'),
          Kitob('Atlas 1-tom - Teshaev', 'https://github.com/kenshi007f/kutubxona_app/releases/download/Anatomiyа_atlas/Anatomiya_Atlas_1_tom_Teshaev.pdf'),
          Kitob('Atlas 1-jild - Ahmedov', 'https://github.com/kenshi007f/kutubxona_app/releases/download/Anatomiyа_atlas/Anatomiya_Atlas_1_jild_Ahmedov.pdf'),
          Kitob('Atlas 2-jild - Ahmedov', 'https://github.com/kenshi007f/kutubxona_app/releases/download/Anatomiyа_atlas/Anatomiya_Atlas_2_jild_Ahmedov.pdf'),
          Kitob('Atlas 2-jild - Ahmedov (2013)', 'https://github.com/kenshi007f/kutubxona_app/releases/download/Anatomiyа_atlas/Odam.anatomiyasi.Atlas-2-jild.N.K.Ahmedov.-T.2013.y.pdf'),
        ],
      ),

      // 3. NORMAL FIZIOLOGIYA
      Fan(
        'Normal fiziologiya',
        [
          Kitob('Normal fiziologiya - Qodirov', 'https://github.com/kenshi007f/kutubxona_app/releases/download/Normal_fiziologiya/Normal.Fiziologiya.Qodirov.pdf'),
          Kitob('Normal fiziologiya - Alaviya (2006)', 'https://github.com/kenshi007f/kutubxona_app/releases/download/Normal_fiziologiya/Normal.fiziologiya.Alaviya.O.T.2006.y.pdf'),
          Kitob('Normal fiziologiya - Alaviya', 'https://github.com/kenshi007f/kutubxona_app/releases/download/Normal_fiziologiya/Normal.fiziologiya_Alaviya.pdf'),
          Kitob('Normal fiziologiya - Alaviya (2007)', 'https://github.com/kenshi007f/kutubxona_app/releases/download/Normal_fiziologiya/Alaviya_Normal_fiziologiya.2007.pdf'),
          Kitob('Normal fiziologiya - Alaviya (2018)', 'https://github.com/kenshi007f/kutubxona_app/releases/download/Normal_fiziologiya/Alaviya_Normal_fiziologiya.2018.pdf'),
          Kitob('Odam fiziologiyasi - Babskiy', 'https://github.com/kenshi007f/kutubxona_app/releases/download/Normal_fiziologiya/Babskiy-ODAM.FIZIOLOGIYASI.pdf'),
          Kitob('Fiziologiya', 'https://github.com/kenshi007f/kutubxona_app/releases/download/Normal_fiziologiya/fiziologiya.pdf'),
          Kitob('Fiziologiyadan ma\'ruzalar', 'https://github.com/kenshi007f/kutubxona_app/releases/download/Normal_fiziologiya/FIZIOLOGIYADAN.MA.RUZALAR.pdf'),
        ],
      ),

      // 4. MIKROBIOLOGIYA
      Fan(
        'Mikrobiologiya',
        [
          Kitob('Mikrobiologiya lab. mashg\'ulotlari - Aliyev', 'https://github.com/kenshi007f/kutubxona_app/releases/download/Mikrobiologiya/Aliyev-Mikrobiologiya.Laboratoriya.Mashg.ulotlari.pdf'),
          Kitob('Mikrobiologiya, virusol., immunolog. - Muhamedov', 'https://github.com/kenshi007f/kutubxona_app/releases/download/Mikrobiologiya/I.M.Muhamedov.va.boshq.Mikrobiol.virusol.immunolog.2019.pdf'),
          Kitob('Mikrob., virusolog. va immunol.', 'https://github.com/kenshi007f/kutubxona_app/releases/download/Mikrobiologiya/Mikrob.virusolog.va.immunol-ya.pdf'),
          Kitob('Mikrobiologiya va immunologiya', 'https://github.com/kenshi007f/kutubxona_app/releases/download/Mikrobiologiya/Mikrobiologiya.va.immunologiya.pdf'),
          Kitob('Mikrobiologiya, immunologiya, virusologiya', 'https://github.com/kenshi007f/kutubxona_app/releases/download/Mikrobiologiya/MIKROBIOLOGIYA.IMMUNOLOGIYA.VIRUSOLOGIYAI.PDF'),
          Kitob('Mikrobiologik tekshirish usullari', 'https://github.com/kenshi007f/kutubxona_app/releases/download/Mikrobiologiya/mikrobiologiya_va_mikrobiologik_tekshirish_usullari.pdf'),
          Kitob('Klinik mikrobiologiya - Z. Nuruzova', 'https://github.com/kenshi007f/kutubxona_app/releases/download/Mikrobiologiya/Z.Nuruzova.Klin.Mikrob-ya.pdf'),
          Kitob('Mikrobiologiya (2019)', 'https://github.com/kenshi007f/kutubxona_app/releases/download/Mikrobiologiya/Muxamedov_mikrobiologiya.2019.pdf'),
        ],
      ),

      // 5. GISTOLOGIYA
      Fan(
        'Gistologiya',
        [
          Kitob('Gistologiya darslik - To\'xtayev', 'https://github.com/kenshi007f/kutubxona_app/releases/download/Gistologiya/1.2.Gistologiya.darslik.To.xtayev.kengroq.pdf'),
          Kitob('Gistologiya preparatlar bo\'yicha qo\'llanma', 'https://github.com/kenshi007f/kutubxona_app/releases/download/Gistologiya/1_3_Gistologiya_preparatlar_bo.yicha_qo.llanma_2019.pdf'),
          Kitob('Darslik gistologiya (lotincha)', 'https://github.com/kenshi007f/kutubxona_app/releases/download/Gistologiya/darslik_gistologiya_lotinda.pdf'),
          Kitob('Gistologiya (1-qism)', 'https://github.com/kenshi007f/kutubxona_app/releases/download/Gistologiya/Gistologiya.I.qism.pdf'),
          Kitob('Gistologiya (2-qism)', 'https://github.com/kenshi007f/kutubxona_app/releases/download/Gistologiya/Gistologiya.II.qism.pdf'),
          Kitob('Gistologiya - Zufarov', 'https://github.com/kenshi007f/kutubxona_app/releases/download/Gistologiya/Gistologiya.Zufarov.K.2005.pdf'),
          Kitob('Gistologiya sitologiyasi', 'https://github.com/kenshi007f/kutubxona_app/releases/download/Gistologiya/Q_R_To.xtayev_Gistologiya.sitologiya.docx'),
          Kitob('To\'xtayev (Gistologiya)', 'https://github.com/kenshi007f/kutubxona_app/releases/download/Gistologiya/To.xtayev.pdf'),
        ],
      ),

      // 6. GISTOLOGIYA ATLASLARI
      Fan(
        'Gistologiya (Atlaslar)',
        [
          Kitob('Gistologiya atlas - Abzalova', 'https://github.com/kenshi007f/kutubxona_app/releases/download/Gistologiya_atlas/1.4.Gistologiya.atlas.Abzalova-2013.pdf'),
          Kitob('Atlas Gistologiya', 'https://github.com/kenshi007f/kutubxona_app/releases/download/Gistologiya_atlas/Atlas.Gistologiya.pdf'),
          Kitob('Gistologiya atlasi (2010)', 'https://github.com/kenshi007f/kutubxona_app/releases/download/Gistologiya_atlas/2010.doc'),
          Kitob('Junqueira (Gistologiya)', 'https://github.com/kenshi007f/kutubxona_app/releases/download/Gistologiya_atlas/Junkeyra.pdf'),
        ],
      ),

      // 7. PATOLOGIYA
      Fan(
        'Patologiya',
        [
          Kitob('Patologik anatomiya (1-qism)', 'https://github.com/kenshi007f/kutubxona_app/releases/download/Patologiya/Patologik.anatomiya.1-qism.M.Abdullaxo.jayeva.pdf'),
          Kitob('Patologik anatomiya (2-qism)', 'https://github.com/kenshi007f/kutubxona_app/releases/download/Patologiya/Patologik.anatomiya.2-qism.M.Abdullaxo.jayeva.pdf'),
          Kitob('Patologik fiziologiya - Abdullayev', 'https://github.com/kenshi007f/kutubxona_app/releases/download/Patologiya/Patologik.Fiziologiya.Abdullayev.N.H.-.T.2008.y.pdf'),
          Kitob('Patofiziologiya - Azimov', 'https://github.com/kenshi007f/kutubxona_app/releases/download/Patologiya/Patofiziologiya.Azimov.R.Q.2010.y.doc'),
          Kitob('Patologik fiziologiya - Haqberdiyev', 'https://github.com/kenshi007f/kutubxona_app/releases/download/Patologiya/Haqberdiyev.Patologik.fiziologiya.pdf'),
          Kitob('Strukov (Patologiya)', 'https://github.com/kenshi007f/kutubxona_app/releases/download/Patologiya/Strukov.uzb.pdf'),
          Kitob('Odam patologiyasi (1998)', 'https://github.com/kenshi007f/kutubxona_app/releases/download/Patologiya/Odam_patologiyasi_asoslari.1-qism.Abdullaxojayeva.1998.pdf'),
          Kitob('Odam patologiyasi (1999)', 'https://github.com/kenshi007f/kutubxona_app/releases/download/Patologiya/Odam_patologiyasi_asoslari.1-qism.Abdullaxojayeva.1999.pdf'),
          Kitob('Patofiz. Lapasova', 'https://github.com/kenshi007f/kutubxona_app/releases/download/Patologiya/Patofiz_Lapasova.pdf'),
          Kitob('Magrupov_seksion_kurs.2014', 'https://github.com/kenshi007f/kutubxona_app/releases/download/Patologiya/Magrupov_seksion_kurs.2014.pdf'),
          Kitob('Magrupov_seksion_kurs.2016', 'https://github.com/kenshi007f/kutubxona_app/releases/download/Patologiya/Magrupov_seksion_kurs.2016.pdf'),
          Kitob('Ziyamutdinova-Anatomiya.Fiziologiya.va.Patologiya', 'https://github.com/kenshi007f/kutubxona_app/releases/download/Patologiya/Ziyamutdinova-Anatomiya.Fiziologiya.va.Patologiya.pdf'),
        ],
      ),

      // 8. FARMAKOLOGIYA
      Fan(
        'Farmakologiya',
        [
          Kitob('Klinik farmakologiya', 'https://github.com/kenshi007f/kutubxona_app/releases/download/Farmakologiya/1.37.Klinik.farmakologiya.pdf'),
          Kitob('Farmakologiya asoslari - Odilov', 'https://github.com/kenshi007f/kutubxona_app/releases/download/Farmakologiya/Farmakologiya.asoslari.M.Odilov.N.Musayeva.pdf'),
          Kitob('Farmakologiya - Azizova', 'https://github.com/kenshi007f/kutubxona_app/releases/download/Farmakologiya/Farmakologiya._Azizova_S.S._-_T._2006_y.pdf'),
          Kitob('Fundamental farmakologiya (2020)', 'https://github.com/kenshi007f/kutubxona_app/releases/download/Farmakologiya/Fundamental.Farmakologiya.2020y.Mayskiy.tarjima.pdf'),
          Kitob('Klinik farmakologiya - Mavlyanov', 'https://github.com/kenshi007f/kutubxona_app/releases/download/Farmakologiya/Klinik.farmakologiya.I.Mavlyanov.R.Mahkamova.P.Kats.pdf'),
          Kitob('Klinik farmakologiya - Mamadov', 'https://github.com/kenshi007f/kutubxona_app/releases/download/Farmakologiya/Klinik.Farmakologiya.Mamadov.Yu.M.-.T.2010.y.pdf'),
          Kitob('Mamadov klinik farmakologiya', 'https://github.com/kenshi007f/kutubxona_app/releases/download/Farmakologiya/Mamadov_klinik_farmakologiya.pdf'),
          Kitob('Retseptura - Xarkevich', 'https://github.com/kenshi007f/kutubxona_app/releases/download/Farmakologiya/Retseptura.+Xarkevich.o.zbekchasi.doc'),
          Kitob('Umumiy farmakologiya va retseptura', 'https://github.com/kenshi007f/kutubxona_app/releases/download/Farmakologiya/umumiy_farmakologiya_va_retseptura.pdf'),
          Kitob('Xarkevich (O\'zbekcha)', 'https://github.com/kenshi007f/kutubxona_app/releases/download/Farmakologiya/Xarkevich_o.zbekcha.pdf'),
          Kitob('Xususiy farmakologiya - Xarkevich', 'https://github.com/kenshi007f/kutubxona_app/releases/download/Farmakologiya/Xususiy.farmakologiya.Xarkevich.pdf'),
        ],
      ),

      // 9. BIOKIMYO
      Fan(
        'Biokimyo',
        [
          Kitob('Biologik kimyo - Sobirova', 'https://github.com/kenshi007f/kutubxona_app/releases/download/Biokimyo/Biologik.kimyo.Sobirova.R.A.-.2006.pdf'),
          Kitob('Biokimya - Nikolayev', 'https://github.com/kenshi007f/kutubxona_app/releases/download/Biokimyo/bioximiya.Nikolayev.pdf'),
          Kitob('Biokimyo 1-qism - Sobirova', 'https://github.com/kenshi007f/kutubxona_app/releases/download/Biokimyo/R.A.Sobirova.Biokimyo.1.q.pdf'),
          Kitob('Biokimyo 2-qism - Sobirova', 'https://github.com/kenshi007f/kutubxona_app/releases/download/Biokimyo/sabirova.r.a.yuldashev.n.m.biokimyo.2qism.pdf'),
          Kitob('Severin 1-qism', 'https://github.com/kenshi007f/kutubxona_app/releases/download/Biokimyo/Severin.1-qism.docx'),
          Kitob('Severin 2-qism', 'https://github.com/kenshi007f/kutubxona_app/releases/download/Biokimyo/Severin.2-qism.docx'),
        ],
      ),

      // 10. IKP VA BKP
      Fan(
        'IKP va BKP',
        [
          Kitob('BKP - Arizqulov', 'https://github.com/kenshi007f/kutubxona_app/releases/download/IKP_va_BKP/BKPArizqulov.pdf'),
          Kitob('BKP', 'https://github.com/kenshi007f/kutubxona_app/releases/download/IKP_va_BKP/BKP.doc'),
          Kitob('BKP - Qoraxojayev', 'https://github.com/kenshi007f/kutubxona_app/releases/download/IKP_va_BKP/BKPQoraxojayev.pdf'),
          Kitob('Bolalar kasalliklari - Daminov', 'https://github.com/kenshi007f/kutubxona_app/releases/download/IKP_va_BKP/Daminov-Bolalar.kasalliklari.pdf'),
          Kitob('Darslik Daminov', 'https://github.com/kenshi007f/kutubxona_app/releases/download/IKP_va_BKP/darslik_Daminov.doc'),
          Kitob('Geppe darslik', 'https://github.com/kenshi007f/kutubxona_app/releases/download/IKP_va_BKP/Geppe_darslik.docx'),
          Kitob('Ichki kasalliklar propedevtikasi - A. Gadayev', 'https://github.com/kenshi007f/kutubxona_app/releases/download/IKP_va_BKP/Ichki.kasalliklar.propedevtikasi.A.Gadayev.pdf'),
          Kitob('IKP - Gadoyev (original)', 'https://github.com/kenshi007f/kutubxona_app/releases/download/IKP_va_BKP/IKP-Gadoyev.original.pdf'),
          Kitob('Ichki kasalliklar - Kamolov', 'https://github.com/kenshi007f/kutubxona_app/releases/download/IKP_va_BKP/Kamolov-Ichki.Kasalliklar.pdf'),
          Kitob('Ichki kasalliklar propedevtikasi - Qosimov', 'https://github.com/kenshi007f/kutubxona_app/releases/download/IKP_va_BKP/Qosimov-Ichki.kasalliklar.propedevtikasi.pdf'),
        ],
      ),
    ],
  ),
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

  Future<void> _faylniTekshirish() async {
    final directory = await getApplicationDocumentsDirectory();
    final faylNomi = widget.kitob.nomi.replaceAll(' ', '_').replaceAll("'", "").replaceAll("/", "_") + '.pdf';
    final file = File('${directory.path}/$faylNomi');

    if (await file.exists()) {
      setState(() { _pdfFayl = file; });
    }
  }

  Future<void> _yuklash() async {
    setState(() { _yuklanmoqda = true; });
    try {
      final directory = await getApplicationDocumentsDirectory();
      final faylNomi = widget.kitob.nomi.replaceAll(' ', '_').replaceAll("'", "").replaceAll("/", "_") + '.pdf';
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