import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HalamanKategori extends StatefulWidget {
  @override
  _HalamanKategoriState createState() => _HalamanKategoriState();
}

class _HalamanKategoriState extends State<HalamanKategori> {
  List kategori = [];
  String username = '';

  @override
  void initState() {
    super.initState();
    _ambilKategori();
    _ambilUsername();
  }

  void _ambilUsername() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? 'Pengguna';
    });
  }

  void _ambilKategori() async {
    final response = await http.get(Uri.parse('https://www.themealdb.com/api/json/v1/1/categories.php'));
    final data = json.decode(response.body);
    setState(() {
      kategori = data['categories'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Halo, $username')),
      body: ListView.builder(
        itemCount: kategori.length,
        itemBuilder: (context, index) {
          final item = kategori[index];
          return ListTile(
            leading: Image.network(item['strCategoryThumb']),
            title: Text(item['strCategory']),
            subtitle: Text(item['strCategoryDescription']),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/makanan',
                arguments: item['strCategory'],
              );
            },
          );
        },
      ),
    );
  }
}
