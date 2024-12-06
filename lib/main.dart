import 'package:flutter/material.dart';
import 'halaman_login.dart';
import 'halaman_kategori.dart';
import 'halaman_makanan.dart';
import 'halaman_detail_makanan.dart';

void main() {
  runApp(AplikasiMakanan());
}

class AplikasiMakanan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Makanan',
      initialRoute: '/',
      routes: {
        '/': (context) => HalamanLogin(),
        '/kategori': (context) => HalamanKategori(),
        '/makanan': (context) => HalamanMakanan(
              kategori: ModalRoute.of(context)!.settings.arguments as String,
            ),
        '/detailMakanan': (context) => HalamanDetailMakanan(
              idMakanan: ModalRoute.of(context)!.settings.arguments as String,
            ),
      },
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
