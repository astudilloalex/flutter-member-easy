import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:member_easy/app/errors/failure.dart';
import 'package:member_easy/src/member/application/member_service.dart';
import 'package:member_easy/src/member/domain/member.dart';
import 'package:member_easy/ui/pages/member/bloc/member_state.dart';

class MemberCubit extends Cubit<MemberState> {
  MemberCubit({
    required this.memberService,
  }) : super(const MemberState()) {
    log('MemberCubit created', name: 'Cubit');
    init();
  }

  final MemberService memberService;

  @override
  Future<void> close() {
    log('MemberCubit closed', name: 'Cubit');
    return super.close();
  }

  Future<void> init() async {
    final Either<Failure, List<Member>> result = await memberService.all();
    result.fold(
      (failure) {},
      (data) {
        emit(state.copyWith(members: data));
      },
    );
  }

  void addEditMember(Member member) {
    final List<Member> members = [...state.members];
    final int index = members.indexWhere(
      (element) => element.code == member.code,
    );
    if (index < 0) {
      members.add(member);
    } else {
      members[index] = member;
    }
    members.sort(
      (a, b) => a.fullName.compareTo(b.fullName),
    );
    emit(state.copyWith(members: members));
  }
}
