import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/diary.dart';
import '../widget_demo/demo_stateless.dart';

class ListDiaries extends StatefulWidget {
  const ListDiaries({super.key});

  @override
  _ListDiariesState createState() => _ListDiariesState();
}

class _ListDiariesState extends State<ListDiaries> {
  final String apiUrl =
      'https://30d0-103-107-140-36.ngrok-free.app/diaries/api/v1/diaries/';
  List<Diary> _diaries = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchDiaries();
  }

  Future<void> _fetchDiaries() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final List<dynamic> diaryJson = json.decode(response.body);
        setState(() {
          print('set state');
          _diaries = diaryJson.map((json) => Diary.fromJson(json)).toList();
          _isLoading = false;
          print(_diaries);
        });
      } else {
        throw Exception('Failed to load diaries');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diaries'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Navigate to create diary page
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _fetchDiaries,
              child: ListView.builder(
                itemCount: _diaries.length,
                itemBuilder: (context, index) {
                  final diary = _diaries[index];
                  return Hero(
                    tag: 'diaryEntry-$index',
                    child: Card(
                      child: ListTile(
                        title: Text('${diary.id}-${diary.label}'),
                        subtitle: Text('${diary.date.toLocal()}'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MyDiaryScreen(id: diary.id)),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
