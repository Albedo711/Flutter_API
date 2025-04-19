import 'package:flutter/material.dart';
import 'http_service.dart';
import 'post_model.dart';
import 'post_detail.dart';

class PostsPage extends StatelessWidget {
  final HttpService httpService = HttpService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Al-quran"),
      ),
      body: FutureBuilder(
        future: httpService.getPosts(),
        builder: (BuildContext context, AsyncSnapshot<List<Alquran>> snapshot) {
          if (snapshot.hasData) {
            List<Alquran> posts = snapshot.data!;
            return ListView(
              children: posts.map((Alquran post) {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => PostDetail(post: post),
                            ),
                          ),
                          leading: CircleAvatar(
                            child: Text(
                              post.nomor.toString(),
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                          title: Text(
                            "${post.namaLatin}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Arti: ${post.arti}"),
                              Text("Jumlah Ayat: ${post.jumlahAyat}"),
                              Text("Tempat Turun: ${post.tempatTurun}"),
                            ],
                          ),
                         
                        ),
                       
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
