import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/diary.dart';

class ListDiaries extends StatefulWidget {
  const ListDiaries({super.key});

  @override
  _ListDiariesState createState() => _ListDiariesState();
}

class _ListDiariesState extends State<ListDiaries> {
  final String apiUrl =
      'https://5093-103-107-140-36.ngrok-free.app/diaries/api/v1/diaries/';
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
          _diaries = diaryJson.map((json) => Diary.fromJson(json)).toList();
          _isLoading = false;
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
                  return Card(
                    child: ListTile(
                      title: Text(diary.label),
                      subtitle: Text('${diary.date.toLocal()}'),
                      onTap: () {
                        // Navigate to diary details page
                      },
                    ),
                  );
                },
              ),
            ),
    );
  }
}
