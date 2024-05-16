import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/diary_entry_controller.dart';

class MyDiaryScreen extends StatelessWidget {
  MyDiaryScreen({super.key, required this.id}) {
    controller.loadDiaryFromApi(id);
  }
  final int id;
  final DiaryEntryController controller = Get.find<DiaryEntryController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Diary'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Obx(() {
        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: _buildSummaryCard(controller),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final entry = controller.diary.value.entries[index];
                  return _buildMealCard(
                      entry.name, entry.createdAt.toString(), entry.calorie);
                },
                childCount: controller.diary.value.entries.length,
              ),
            ),
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Container()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildSummaryCard(DiaryEntryController controller) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Obx(() {
              return Text(controller.diary.value.label,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold));
            }),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNutrientStatus(
                    'Eaten', controller.getTotalCalories().toString()),
                _buildNutrientStatus(
                    'Burned', controller.getBurnedCalories().toString()),
                _buildNutrientStatus(
                    'Left', controller.getTotalCalories().toString()),
              ],
            ),
            // Add circular progress indicator or similar widget
            // const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }

  Widget _buildNutrientStatus(String label, String value) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(fontSize: 16)),
      ],
    );
  }

  Widget _buildMealCard(String mealType, String details, int calories) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ListTile(
        leading: const Icon(Icons.fastfood, color: Colors.pink),
        title: Text(mealType),
        subtitle: Text(details),
        trailing: Text('$calories kcal'),
      ),
    );
  }
}
