import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tekrar_proje/models/urunler_model.dart';

class home_screen extends StatefulWidget {
  const home_screen({super.key});

  @override
  State<home_screen> createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {
  UrunlerModel? _veriler;
  List<Urun> _urunler = [];

  void _loadData() async {
    final dataString = await rootBundle.loadString('assets/files/data.json');
    final dataJson = jsonDecode(dataString);

    _veriler = UrunlerModel.fromJson(dataJson);
    _urunler = _veriler!.urunler;
    setState(() {});
  }

  void _filterData(int id) {
    _urunler = _veriler!.urunler
        .where((verilerEleman) => verilerEleman.kategori == id)
        .toList();
    setState(() {});
  }

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _veriler == null
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
        _veriler!.kategoriler.length,
        (index) => GestureDetector(
          onTap: () => _filterData(_veriler!.kategoriler[index].id),
          child: Container(
            padding: EdgeInsets.all(8),
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(_veriler!.kategoriler[index].isim),
          ),
        ),
      ),
    );
  }
}
