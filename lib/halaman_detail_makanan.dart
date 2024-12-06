import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HalamanDetailMakanan extends StatelessWidget {
  final String idMakanan;

  HalamanDetailMakanan({required this.idMakanan});

  Future<Map> _ambilDetailMakanan() async {
    final response = await http.get(Uri.parse('https://www.themealdb.com/api/json/v1/1/lookup.php?i=$idMakanan'));
    final data = json.decode(response.body);
    return data['meals'][0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail Makanan')),
      body: FutureBuilder(
        future: _ambilDetailMakanan(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final makanan = snapshot.data as Map;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.network(makanan['strMealThumb']),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    makanan['strMeal'],
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(makanan['strInstructions']),
                ),
                ElevatedButton(
                  onPressed: () {
                   
                  },
                  child: Text('Tonton Tutorial Masak'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
