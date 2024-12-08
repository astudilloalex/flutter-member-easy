import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:member_easy/src/attendance/domain/attendance.dart';

class AttendanceMapper {
  const AttendanceMapper._();

  static Attendance fromFirestore(
    QueryDocumentSnapshot<Map<String, dynamic>> document,
  ) {
    final Map<String, dynamic> json = document.data();
    return Attendance(
      date: DateTime.parse(
        json['date'].toString(),
      ),
    );
  }

  static Map<String, dynamic> toJson(Attendance attendance) {
    return {
      'date': attendance.date
          .copyWith(
            hour: 0,
            microsecond: 0,
            minute: 0,
            millisecond: 0,
            second: 0,
          )
          .toIso8601String(),
    };
  }
}
