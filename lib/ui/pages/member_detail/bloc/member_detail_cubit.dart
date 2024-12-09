import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:member_easy/app/errors/failure.dart';
import 'package:member_easy/src/attendance/application/attendance_service.dart';
import 'package:member_easy/src/attendance/domain/attendance.dart';
import 'package:member_easy/src/member/application/member_service.dart';
import 'package:member_easy/ui/pages/member_detail/bloc/member_detail_state.dart';

class MemberDetailCubit extends Cubit<MemberDetailState> {
  MemberDetailCubit({
    required this.attendanceService,
    required this.memberCode,
    required this.memberService,
  }) : super(
          MemberDetailState(
            endDate: DateTime.now(),
            startDate: DateTime(DateTime.now().year, DateTime.now().month),
          ),
        ) {
    log('MemberDetailCubit Created', name: 'Cubit');
    init();
  }

  final AttendanceService attendanceService;
  final String memberCode;
  final MemberService memberService;

  @override
  Future<void> close() {
    log('MemberDetailCubit Closed', name: 'Cubit');
    return super.close();
  }

  Future<void> init() async {
    try {
      final Either<Failure, List<Attendance>> result =
          await attendanceService.byMemberCodeAndDates(
        memberCode,
        startDate: state.startDate,
        endDate: state.endDate,
      );
      result.fold(
        (failure) {},
        (data) {
          emit(state.copyWith(attendances: data));
        },
      );
    } finally {}
  }
}
