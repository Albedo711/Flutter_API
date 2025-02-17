import 'package:flutter/foundation.dart';

class Post {
  final int nomor;
  final String nama;
  final String nama_latin;
  final String jumlah_ayat;
  final String tempat_turun;
  final String arti;
  final String deskripsi;

  Post({
    required this.nomor,
    required this.nama,
    required this.nama_latin,
    required this.jumlah_ayat,
    required this.tempat_turun,
    required this.arti,
    required this.deskripsi
  });
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      nomor: json['nomor'] as int,
      nama: json['nama'] as String,
      nama_latin: json['nama_latin'] as String,
      jumlah_ayat: json['jumlah_ayat'] as String,
      tempat_turun: json['tempat_turun'] as String,
      arti: json['arti'] as String,
      deskripsi: json['deskripsi'] as String
    );
  }
}
