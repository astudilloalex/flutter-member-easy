import 'package:fpdart/fpdart.dart';
import 'package:member_easy/app/errors/failure.dart';
import 'package:member_easy/src/attendance/domain/attendance.dart';

abstract class IAttendanceRepository {
  const IAttendanceRepository();

  Future<Either<Failure, Attendance>> saveOrUpdate(
    String companyCode, {
    required String memberCode,
    required Attendance attendance,
  });

  Future<Either<Failure, List<Attendance>>> findByMemberCodeAndDates(
    String companyCode, {
    required String memberCode,
    required DateTime startDate,
    required DateTime endDate,
  });
}
