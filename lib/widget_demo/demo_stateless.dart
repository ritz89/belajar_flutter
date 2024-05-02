import 'package:flutter/material.dart';

class MyDiaryScreen extends StatelessWidget {
  const MyDiaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Diary'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildSummaryCard(),
            _buildMealCard('Breakfast', 'Bread, Peanut butter, Apple', 525),
            _buildMealCard('Lunch', 'Salmon, Vegetables, Avocado', 602),
            _buildMealCard('Snack', 'Watermelon', 300),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MyDiaryScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Mediterranean diet',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNutrientStatus('Eaten', '1127 kcal'),
                _buildNutrientStatus('Burned', '102 kcal'),
                _buildNutrientStatus('Left', '1503 kcal'),
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
