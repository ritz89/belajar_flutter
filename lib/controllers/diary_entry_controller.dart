import 'package:get/get.dart';
import '../models/diary.dart';
import '../models/diary_entry.dart';

class DiaryEntryController extends GetxController {
  var _diary = Diary(id: 0, date: DateTime.now(), label: '').obs;

  Rx<Diary> get diary => _diary;

  int getTotalCalories() {
    int total = 0;
    for (int i = 0; i < _diary.value.entries.length; i++) {
      total += _diary.value.entries[i].calorie;
    }
    return total;
  }

  int getEatenCalories() {
    int total = 0;
    for (int i = 0; i < _diary.value.entries.length; i++) {
      if (_diary.value.entries[i].calorie > 0) {
        total += _diary.value.entries[i].calorie;
      }
    }
    return total;
  }

  int getBurnedCalories() {
    int total = 0;
    for (int i = 0; i < _diary.value.entries.length; i++) {
      if (_diary.value.entries[i].calorie < 0) {
        total += _diary.value.entries[i].calorie;
      }
    }
    return total;
  }

  Future<void> loadDiaryFromApi(int diaryId) async {
    final response = await GetConnect().get(
        'https://30d0-103-107-140-36.ngrok-free.app/diaries/api/v1/diaries/$diaryId');
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      var responseBody = response.body;
      if (responseBody != null) {
        _diary.value = Diary.fromJson({
          'id': diaryId,
          'date': responseBody['date'],
          'label': responseBody['label']
        });

        List<DiaryEntry> entries = [];
        if (responseBody['diaryentry_set'] != null) {
          entries = (responseBody['diaryentry_set'] as List)
              .map((e) => DiaryEntry.fromJson(e))
              .toList();
        }
        _diary.value.entries = entries;
        update(); // Update the UI
      }
    }
  }
}
