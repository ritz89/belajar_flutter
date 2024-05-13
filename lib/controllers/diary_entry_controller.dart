import 'package:get/get.dart';
import '../models/diary.dart';
import '../models/diary_entry.dart';

class DiaryEntryController extends GetxController {
  var _diary = Diary(id: 0, date: DateTime.now(), label: '').obs;

  Rx<Diary> get diary => _diary;

  Future<void> loadDiaryFromApi(int diaryId) async {
    final response = await GetConnect().get(
        'https://d05e-103-107-140-36.ngrok-free.app/diaries/api/v1/diaries/$diaryId');
    if (response.status.hasError) {
      print(response.statusText);
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
