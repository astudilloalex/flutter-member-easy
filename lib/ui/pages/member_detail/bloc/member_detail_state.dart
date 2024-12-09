import 'package:equatable/equatable.dart';
import 'package:member_easy/src/attendance/domain/attendance.dart';

class MemberDetailState extends Equatable {
  const MemberDetailState({
    this.attendances = const <Attendance>[],
    required this.endDate,
    required this.startDate,
  });

  final List<Attendance> attendances;
  final DateTime endDate;
  final DateTime startDate;

  @override
  List<Object?> get props {
    return [
      attendances,
      endDate,
      startDate,
    ];
  }

  MemberDetailState copyWith({
    List<Attendance>? attendances,
    DateTime? endDate,
    DateTime? startDate,
  }) {
    return MemberDetailState(
      attendances: attendances ?? this.attendances,
      endDate: endDate ?? this.endDate,
      startDate: startDate ?? this.startDate,
    );
  }
}
