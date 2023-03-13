import 'dart:convert';

import 'package:pagination_flutter_cubit/post_model.dart';
import 'package:http/http.dart' as http;
class PostRepository{
  Future<List<Post>> fetchPosts(int page) async {

    await Future.delayed(Duration(seconds: 3));
    List<Post> list = [];
    list.add(Post(id: 0, title: "title", body: "body1"));
    list.add(Post(id: 0, title: "title", body: "body2"));
    list.add(Post(id: 0, title: "title", body: "body3"));
    list.add(Post(id: 0, title: "title", body: "body4"));
    list.add(Post(id: 0, title: "title", body: "body5"));
    list.add(Post(id: 0, title: "title", body: "body6"));
    list.add(Post(id: 0, title: "title", body: "body7"));
    list.add(Post(id: 0, title: "title", body: "body8"));


    return list;


    // final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts?_page=$page'));
    //
    // if (response.statusCode == 200) {
    //   final List<dynamic> data = jsonDecode(response.body);
    //   final List<Post> posts = data.map((e) => Post(
    //     id: e['id'],
    //     title: e['title'],
    //     body: e['body'],
    //   )).toList();
    //
    //   return posts;
    // } else {
    //   throw Exception('Failed to fetch posts');
    // }
  }
}