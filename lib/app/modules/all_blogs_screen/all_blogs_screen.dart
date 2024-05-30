import 'dart:convert';

import 'package:demo/app/data/token_keeper.dart';
import 'package:demo/app/model/get_all_blogs_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../api_services/api_services.dart';
import '../../model/get_blogs_by_id_model.dart';

class GetAllBlogsScreen extends StatefulWidget {
  const GetAllBlogsScreen({super.key});

  @override
  State<GetAllBlogsScreen> createState() => _GetAllBlogsScreenState();
}

class _GetAllBlogsScreenState extends State<GetAllBlogsScreen> {
  List<GetAllBlogsModel> allBlogsData = [];

  bool _isLoading = true;

  bool get isLoading => _isLoading;

  Future<void> allBlogScreen() async {
    final String? token = TokenKeeper.accessToken;
    if (token != null && token.isNotEmpty) {
      print(token);
      _isLoading = true;
      setState(() {});
      var response = await http.get(
        Uri.parse(ApiServices.getAllBlogsUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      var responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        for (var json in responseData['data']['allBlogs']) {
          allBlogsData.add(GetAllBlogsModel.fromJson(json));
        }
        _isLoading = false;
        setState(() {});
      } else {
        _isLoading = false;
        setState(() {});
        // Handle error
      }
    }
  }

  @override
  void initState() {
    allBlogScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Blogs'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: allBlogsData.length,
              itemBuilder: (context, index) {
                final blog = allBlogsData[index];
                return Card(
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(10),
                    title: Text(blog.title.toString()),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              BlogsByIdScreen(id: blog.id.toString())));
                    },
                  ),
                );
              },
            ),
    );
  }
}

class BlogsByIdScreen extends StatefulWidget {
  final String id;

  const BlogsByIdScreen({super.key, required this.id});

  @override
  State<BlogsByIdScreen> createState() => _BlogsByIdScreenState();
}

class _BlogsByIdScreenState extends State<BlogsByIdScreen> {
  List<GetBlogsByIdModel> blogByIdData = [];

  bool _isLoading = true;

  bool get isLoading => _isLoading;

  Future<void> blogById() async {
    final String? token = TokenKeeper.accessToken;
    if (token != null && token.isNotEmpty) {
      _isLoading = true;
      setState(() {});
      var response = await http.get(
        Uri.parse(ApiServices.blogByIdUrl + widget.id),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      var responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        for (var json in responseData['data']['mediaLinks']) {
          blogByIdData.add(GetBlogsByIdModel.fromJson(json));
        }
        _isLoading = false;
        setState(() {});
      } else {
        _isLoading = false;
        setState(() {});
        // Handle error
      }
    }
  }

  @override
  void initState() {
    blogById();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Blogs By Id'),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : blogByIdData.isEmpty
              ? const Center(child: Text('There is no Data'))
              : ListView.builder(
                  itemCount: blogByIdData.length,
                  itemBuilder: (context, index) => ListTile(
                    title: Text(blogByIdData[index].link.toString()),
                    subtitle: Text(blogByIdData[index].type.toString()),
                  ),
                ),
    );
  }
}
