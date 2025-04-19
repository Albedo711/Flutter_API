import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'post_model.dart';

class PostDetail extends StatefulWidget {
  final Alquran post;
  PostDetail({required this.post});

  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  Map<String, dynamic>? detailSurah;

  @override
  void initState() {
    super.initState();
    fetchDetailSurah();
  }

  Future<void> fetchDetailSurah() async {
    final res = await http.get(Uri.parse(
        'https://quran-api.santrikoding.com/api/surah/${widget.post.nomor}'));
    if (res.statusCode == 200) {
      setState(() {
        detailSurah = json.decode(res.body);
      });
    }
  }

  // Fungsi untuk menghapus tag HTML dari teks
  String removeHtmlTags(String htmlText) {
    final exp = RegExp(r'<[^>]*>', multiLine: true, caseSensitive: false);
    return htmlText.replaceAll(exp, '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post.namaLatin ?? 'Detail Surat'),
      ),
      body: detailSurah == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Surat ${detailSurah!['nama_latin']} (${detailSurah!['nama']})",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          SizedBox(height: 8),
                          Text("Nomor: ${detailSurah!['nomor']}"),
                          Text("Jumlah Ayat: ${detailSurah!['jumlah_ayat']}"),
                          Text("Arti: ${detailSurah!['arti']}"),
                          Text("Tempat Turun: ${detailSurah!['tempat_turun']}"),
                          SizedBox(height: 10),
                          Text("Deskripsi:", style: TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(height: 4),
                          Text(removeHtmlTags(detailSurah!['deskripsi'])),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Daftar Ayat:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  ...List.generate(detailSurah!['ayat'].length, (index) {
                    final ayat = detailSurah!['ayat'][index];
                    return Card(
                      child: ListTile(
                        title: Text(
                          ayat['ar'],
                          textAlign: TextAlign.right,
                          style: TextStyle(fontSize: 22),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 4),
                            Text(
                              removeHtmlTags(ayat['tr']),
                              style: TextStyle(color: Colors.grey),
                            ),
                            SizedBox(height: 4),
                            Text(ayat['idn']),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
    );
  }
}
