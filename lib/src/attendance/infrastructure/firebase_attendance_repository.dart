import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:member_easy/app/errors/failure.dart';
import 'package:member_easy/src/attendance/domain/I_attendance_repository.dart';
import 'package:member_easy/src/attendance/domain/attendance.dart';
import 'package:member_easy/src/attendance/infrastructure/attendance_mapper.dart';

class FirebaseAttendanceRepository implements IAttendanceRepository {
  const FirebaseAttendanceRepository(this._firestore);

  final FirebaseFirestore _firestore;

  @override
  Future<Either<Failure, List<Attendance>>> findByMemberCodeAndDates(
    String companyCode, {
    required String memberCode,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final QuerySnapshot<Map<String, dynamic>> query = await _firestore
        .collection('companies')
        .doc(companyCode)
        .collection('members')
        .doc(memberCode)
        .collection('attendances')
        .orderBy('date', descending: true)
        .where(
          Filter.and(
            Filter(
              'date',
              isGreaterThanOrEqualTo: startDate
                  .copyWith(
                    hour: 0,
                    minute: 0,
                    second: 0,
                    millisecond: 0,
                    microsecond: 0,
                  )
                  .toIso8601String(),
            ),
            Filter(
              'date',
              isLessThanOrEqualTo: endDate
                  .copyWith(
                    hour: 23,
                    minute: 59,
                    second: 59,
                  )
                  .toIso8601String(),
            ),
          ),
        )
        .get();
    return Right(
      query.docs.map(
        (querySnapshot) {
          return AttendanceMapper.fromFirestore(querySnapshot);
        },
      ).toList(),
    );
  }

  @override
  Future<Either<Failure, Attendance>> saveOrUpdate(
    String companyCode, {
    required String memberCode,
    required Attendance attendance,
  }) async {
    final QuerySnapshot<Map<String, dynamic>> query = await _firestore
        .collection('companies')
        .doc(companyCode)
        .collection('members')
        .doc(memberCode)
        .collection('attendances')
        .where(
          'date',
          isEqualTo: attendance.date
              .copyWith(
                hour: 0,
                microsecond: 0,
                millisecond: 0,
                minute: 0,
                second: 0,
              )
              .toIso8601String(),
        )
        .get();
    if (query.docs.isNotEmpty) {
      return const Left(
        FirebaseFailure(
          failureEnum: FailureEnum.attendanceAlreadyRegistered,
        ),
      );
    }
    await _firestore
        .collection('companies')
        .doc(companyCode)
        .collection('members')
        .doc(memberCode)
        .collection('attendances')
        .add(AttendanceMapper.toJson(attendance));
    return Right(attendance);
  }
}
