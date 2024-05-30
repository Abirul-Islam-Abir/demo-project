import 'dart:convert';

import 'package:demo/app/data/model/all_events_category_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/urls/urls.dart';

class AllEventsCategory extends StatefulWidget {
  const AllEventsCategory({super.key});

  @override
  State<AllEventsCategory> createState() => _AllEventsCategoryState();
}

class _AllEventsCategoryState extends State<AllEventsCategory> {
  List<AllEventsCategoryModel> allEventsCategory = [];

  bool _isLoading = true;

  bool get isLoading => _isLoading;

  Future<void> eventCategory() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    if (token != null && token.isNotEmpty) {
      print(token);
      _isLoading = true;
      setState(() {});
      var response = await http.get(
        Uri.parse(Urls.allEventCategoryUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      var responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        for (var json in responseData['data']['eventCategories']) {
          allEventsCategory.add(AllEventsCategoryModel.fromJson(json));
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
    eventCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Events Category'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: allEventsCategory.length,
              itemBuilder: (context, index) {
                final blog = allEventsCategory[index];
                return Card(
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(10),
                    title: Text(blog.title.toString()),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              EventsCategoryById(id: blog.id.toString())));
                    },
                  ),
                );
              },
            ),
    );
  }
}

class EventsCategoryById extends StatefulWidget {
  final String id;

  const EventsCategoryById({super.key, required this.id});

  @override
  State<EventsCategoryById> createState() => _EventsCategoryByIdState();
}

class _EventsCategoryByIdState extends State<EventsCategoryById> {
  Map data = {};

  bool _isLoading = true;

  bool get isLoading => _isLoading;
  TextEditingController title = TextEditingController();

  Future<void> eventById() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    if (token != null && token.isNotEmpty) {
      _isLoading = true;
      setState(() {});
      var response = await http.get(
        Uri.parse(Urls.eventCategoryById + widget.id),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      var responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        data = responseData['data']['event'];
        _isLoading = false;
        setState(() {});
      } else {
        _isLoading = false;
        setState(() {});
        // Handle error
      }
    }
  }

  Future<void> update() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    if (token != null && token.isNotEmpty) {
      _isLoading = true;
      setState(() {});
      var body = {"title": title.text};
      var response =
          await http.put(Uri.parse(Urls.eventCategoryUpdate + widget.id),
              headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer $token',
              },
              body: jsonEncode(body));
      if (response.statusCode == 200) {
        await eventById();
        title.clear();
      }
    }
  }

  @override
  void initState() {
    eventById();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Category by id'),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : data.isEmpty
              ? const Center(child: Text('There is no Data'))
              : ListTile(
                  title: Text(data['title']),
                  subtitle: Text(data['updatedAt']),
                  trailing: FittedBox(
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                  title: const Text('Update'),
                                  content: SizedBox(
                                    height: 300,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(18.0),
                                          child: TextFormField(
                                            decoration: const InputDecoration(
                                                hintText: 'title'),
                                            controller: title,
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            update();
                                          },
                                          child: const Text('Update Title'),
                                        ),
                                      ],
                                    ),
                                  )),
                            );
                          },
                          icon: const Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('There is no API available')));
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }
}
