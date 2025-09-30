class Kategori {
  final int id;
  final String isim;

  Kategori(this.id, this.isim);

  Kategori.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      isim = json['isim'];
}
