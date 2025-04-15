import 'package:flutter_bloc/flutter_bloc.dart';
import 'tasbeeh_state.dart'; // تأكد من أن تستورد ملف الـState

class TasbeehCubit extends Cubit<TasbeehState> {
  TasbeehCubit() : super(TasbeehState.initial());

  // لتحديث عدد التكرارات
  void changeRepeatCount(int newRepeatCount) {
    final updatedCounts = List.generate(state.azkar.length, (index) => 0);
    final updatedRounds = List.generate(state.azkar.length, (index) => 0); // لتتبع الجولات
    emit(state.copyWith(repeatCount: newRepeatCount, counts: updatedCounts, rounds: updatedRounds));
  }

  // لزيادة عدد التكرارات في الصفحة الحالية
  void incrementCount() {
    final updatedCounts = List<int>.from(state.counts);
    final updatedRounds = List<int>.from(state.rounds);

    if (updatedCounts[state.currentIndex] < state.repeatCount) {
      updatedCounts[state.currentIndex]++;
    } else {
      // إذا وصل للعدد الأقصى، أعد التكرار من البداية
      updatedCounts[state.currentIndex] = 0;
      updatedRounds[state.currentIndex]++; // زيادة الجولة
    }

    emit(state.copyWith(counts: updatedCounts, rounds: updatedRounds));
  }

  // لتغيير الصفحة الحالية
  void setCurrentIndex(int index) {
    emit(state.copyWith(currentIndex: index));
  }

  // لإعادة ضبط التسبيح
  void resetTasbeeh() {
    final updatedCounts = List.generate(state.azkar.length, (index) => 0);
    final updatedRounds = List.generate(state.azkar.length, (index) => 0); // إعادة الجولات
    emit(state.copyWith(counts: updatedCounts, rounds: updatedRounds));
  }
}
