import 'package:flutter/foundation.dart';

class Post {
  final int userid;
  final int id;
  final String title;
  final String body;
 

  Post({
    required this.userid,
    required this.id,
    required this.title,
    required this.body,
  });
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userid: json['userid'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }
}
