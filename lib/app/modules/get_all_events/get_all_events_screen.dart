import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../api_services/api_services.dart';
import '../../model/all_events_model.dart';
import '../../model/event_by_id_model.dart';
import '../../model/get_all_blogs_model.dart';
import '../../model/get_blogs_by_id_model.dart';

class GetAllEventsScreen extends StatefulWidget {
  const GetAllEventsScreen({super.key});

  @override
  State<GetAllEventsScreen> createState() => _GetAllEventsScreenState();
}

class _GetAllEventsScreenState extends State<GetAllEventsScreen> {
  List<AllEventModel> allEventsData = [];

  bool _isLoading = true;

  bool get isLoading => _isLoading;

  Future<void> allEvents() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    if (token != null && token.isNotEmpty) {
      _isLoading = true;
      setState(() {});
      var response = await http.get(
        Uri.parse(ApiServices.getAllEventsUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      var responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        for (var json in responseData['data']['events']) {
          allEventsData.add(AllEventModel.fromJson(json));
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
    allEvents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Events'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: allEventsData.length,
              itemBuilder: (context, index) {
                final blog = allEventsData[index];
                return Card(
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(10),
                    title: Text(blog.title.toString()),
                    subtitle: Text(blog.description.toString()),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              EventById(id: blog.id.toString())));
                    },
                  ),
                );
              },
            ),
    );
  }
}

class EventById extends StatefulWidget {
  final String id;

  const EventById({super.key, required this.id});

  @override
  State<EventById> createState() => _EventByIdState();
}

class _EventByIdState extends State<EventById> {
  TextEditingController title = TextEditingController();
  TextEditingController desc = TextEditingController();
  Map eventByIdData = {};

  bool _isLoading = true;

  bool get isLoading => _isLoading;

  Future<void> eventById() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    if (token != null && token.isNotEmpty) {
      _isLoading = true;
      setState(() {});
      var response = await http.get(
        Uri.parse(ApiServices.eventByIdUrl + widget.id),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      var responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        eventByIdData = responseData['data']['event'];
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
      var body = {
        "title": title.text,
        "description": desc.text,
        "eventCategoryId": "7dc7cd92-36a8-4c8a-80c2-613fe758dd70",
        "image_url":
            "http://res.cloudinary.com/doz2bhhqv/image/upload/v1705300939/1705300934_event_image.png",
        "min_age": 12,
        "max_age": 40,
        "Guest_limit": 24,
        "escrow_price": 100,
        "cash_price": 0,
        "payment_type": "escrow_paypal",
        "start_time": "2024-01-14T23:59:59Z",
        "end_time": "2024-01-15T00:00:00Z"
      };
      var response =
          await http.put(Uri.parse(ApiServices.eventUpdateUrl + widget.id),
              headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer $token',
              },
              body: jsonEncode(body));
      var responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        eventByIdData = responseData['data']['updatedEvent'];
        await eventById();
        title.clear();
      }
    }
  }

  Future<void> delete() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    if (token != null && token.isNotEmpty) {
      _isLoading = true;
      setState(() {});
      var response = await http.delete(
        Uri.parse(ApiServices.eventDeleteUrl + widget.id),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      var responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        eventByIdData = responseData['data']['updatedEvent'];
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Deleted Sucess')));
      } else {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Server error')));
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
        title: Text('Event By Id with Update'),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : eventByIdData.isEmpty
              ? const Center(child: Text('There is no Data'))
              : Column(
                  children: [
                    ListTile(
                      leading: Image.network(
                        eventByIdData['image_url'],
                        height: 50,
                        width: 50,
                      ),
                      title: Text(eventByIdData['title'].toString()),
                      subtitle: Text(eventByIdData['description'].toString()),
                      trailing: FittedBox(
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                      title: Text('Update'),
                                      content: SizedBox(
                                        height: 300,
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(18.0),
                                              child: TextFormField(
                                                decoration: InputDecoration(
                                                    hintText: 'title'),
                                                controller: title,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(18.0),
                                              child: TextFormField(
                                                decoration: InputDecoration(
                                                    hintText: 'description'),
                                                controller: desc,
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                update();
                                              },
                                              child: Text('Update Title'),
                                            ),
                                          ],
                                        ),
                                      )),
                                );
                              },
                              icon: Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: delete,
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }
}
