import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HalamanMakanan extends StatelessWidget {
  final String kategori;

  HalamanMakanan({required this.kategori});

  Future<List> _ambilMakanan() async {
    final response = await http.get(Uri.parse('https://www.themealdb.com/api/json/v1/1/filter.php?c=$kategori'));
    final data = json.decode(response.body);
    return data['meals'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Makanan: $kategori')),
      body: FutureBuilder(
        future: _ambilMakanan(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final makanan = snapshot.data as List;
          return ListView.builder(
            itemCount: makanan.length,
            itemBuilder: (context, index) {
              final item = makanan[index];
              return ListTile(
                leading: Image.network(item['strMealThumb']),
                title: Text(item['strMeal']),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/detailMakanan',
                    arguments: item['idMeal'],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
