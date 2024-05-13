import 'package:flutter/material.dart';
import 'widget_demo/demo_stateless.dart';
import 'widget_demo/list_diary.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyDiaryScreen(
                            id: 0,
                          )),
                );
              },
              child: const Text('diary demo using stateless widged'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ListDiaries()),
                );
              },
              child: const Text('List Diary: demo statefull widged dan api'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigation logic or function call
              },
              child: const Text('Button 3'),
            ),
          ],
        ),
      ),
    );
  }
}
