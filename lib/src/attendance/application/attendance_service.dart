import 'package:fpdart/fpdart.dart';
import 'package:member_easy/app/core/app_session_data.dart';
import 'package:member_easy/app/errors/failure.dart';
import 'package:member_easy/src/attendance/domain/I_attendance_repository.dart';
import 'package:member_easy/src/attendance/domain/attendance.dart';

class AttendanceService {
  const AttendanceService(this._repository);

  final IAttendanceRepository _repository;

  Future<Either<Failure, List<Attendance>>> byMemberCodeAndDates(
    String memberCode, {
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      // Validate company
      if (AppSessionData.company == null) {
        return const Left(
          ServiceFailure(
            failureEnum: FailureEnum.thereIsNoCompanySelected,
          ),
        );
      }
      return _repository.findByMemberCodeAndDates(
        AppSessionData.company!.code,
        memberCode: memberCode,
        startDate: startDate,
        endDate: endDate,
      );
    } catch (e) {
      return Left(
        ServiceFailure(
          message: e.toString(),
        ),
      );
    }
  }

  Future<Either<Failure, Attendance>> createOrUpdate(
    String memberCode, {
    required Attendance attendance,
  }) async {
    try {
      if (AppSessionData.company == null) {
        return const Left(
          ServiceFailure(
            failureEnum: FailureEnum.thereIsNoCompanySelected,
          ),
        );
      }
      return _repository.saveOrUpdate(
        AppSessionData.company!.code,
        memberCode: memberCode,
        attendance: attendance,
      );
    } catch (e) {
      return Left(
        ServiceFailure(message: e.toString()),
      );
    }
  }
}
