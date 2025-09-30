import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:tekrar_proje/models/kategori_model.dart';
import 'package:tekrar_proje/models/urun_model.dart';

class home_screen extends StatefulWidget {
  const home_screen({super.key});

  @override
  State<home_screen> createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {
  List<Urun> _urunler = [];
  List<Kategori> _kategoriler = [];

  void _loadData() async {
    final dataString = await rootBundle.loadString('assets/files/data.json');
    final dataJson = jsonDecode(dataString);

    _urunler = dataJson['urunler']
        .map<Urun>((json) => Urun.fromJson(json))
        .toList();

    _kategoriler = dataJson['kategoriler']
        .map<Kategori>((json) => Kategori.fromJson(json))
        .toList();
    setState(() {});
  }

  void _filterData(int id) {
    _urunler = _urunler
        .where((verilerEleman) => verilerEleman.kategori == id)
        .toList();
    setState(() {});
  }

  Future<void> _getDataFromAPI() async {
    var response = await http.get(Uri.parse('https://reqres.in/api'));

    if(response.statusCode == 200) {
      print('Başarılı');

      var jsonDecodeApi = jsonDecode(response.body);
      print(jsonDecodeApi['version']);

    } else {
      print('Başarısız');
    }

  }

  @override
  void initState() {
    _loadData();
    _getDataFromAPI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _urunler.isEmpty && _kategoriler.isEmpty
            ? Text('Yükleniyor')
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [_kategorilerView(), _urunlerView()],
              ),
      ),
    );
  }

  ListView _urunlerView() {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: _urunler.length,
      itemBuilder: (context, index) {
        final Urun urun = _urunler[index];
        return ListTile(
          leading: Image.network(
            urun.resim,
            width: 50,
            height: 100,
            fit: BoxFit.cover,
          ),
          title: Text(urun.isim),
        );
      },
      separatorBuilder: (context, index) => const Divider(height: 10),
    );
  }

  Row _kategorilerView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
      _kategoriler.length,
        (index) => GestureDetector(
          onTap: () => _filterData(_kategoriler[index].id),
          child: Container(
            padding: EdgeInsets.all(8),
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(_kategoriler[index].isim),
          ),
        ),
      ),
    );
  }
}
