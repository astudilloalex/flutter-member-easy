import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:intl/intl.dart';
import 'package:member_easy/app/errors/failure.dart';
import 'package:member_easy/app/models/optional.dart';
import 'package:member_easy/src/company/domain/company.dart';
import 'package:member_easy/src/member/application/member_service.dart';
import 'package:member_easy/src/member/domain/member.dart';
import 'package:member_easy/src/user/application/user_service.dart';
import 'package:member_easy/src/user/domain/user.dart';
import 'package:member_easy/ui/pages/add_edit_member/bloc/add_edit_member_state.dart';

class AddEditMemberCubit extends Cubit<AddEditMemberState> {
  AddEditMemberCubit({
    required this.memberService,
    required this.userService,
    this.company,
    this.memberCode,
  }) : super(const AddEditMemberState()) {
    log('AddEditMemberCubit created', name: 'Cubit');
    init();
  }

  final MemberService memberService;
  final UserService userService;
  final Company? company;
  final String? memberCode;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController userCodeController = TextEditingController();
  final TextEditingController idCardController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController birthdateController = TextEditingController();

  @override
  Future<void> close() {
    userCodeController.dispose();
    idCardController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    birthdateController.dispose();
    log('AddEditMemberCubit closed', name: 'Cubit');
    return super.close();
  }

  Future<void> init() async {
    if (isClosed) return;
    if (memberCode == null) return;
    Member? member;
    try {
      emit(state.copyWith(loading: true, member: Optional.empty()));
      final Either<Failure, Member> result = await memberService.byCode(
        memberCode!,
      );
      result.fold(
        (failure) {},
        (data) {
          member = data;
        },
      );
      if (member == null || isClosed) return;
      userCodeController.text = member!.user?.code ?? '';
      idCardController.text = member!.idCard;
      firstNameController.text = member!.firstName;
      lastNameController.text = member!.lastName;
      birthdateController.text = member!.birthdate == null
          ? ''
          : DateFormat('dd/MM/yyyy').format(
              member!.birthdate!,
            );
    } finally {
      if (!isClosed) {
        emit(state.copyWith(loading: false));
      }
    }
  }

  void updateBirthdate(DateTime? dateTime) {
    if (dateTime == null) {
      birthdateController.text = '';
      return;
    }
    birthdateController.text = DateFormat('dd/MM/yyyy').format(dateTime);
  }

  void updateUserCode(String userCode) {
    if (userCode.trim().length < 20) return;
    userCodeController.text = userCode;
  }

  Future<void> saveMember() async {
    if (isClosed) return;
    if (!formKey.currentState!.validate()) return;
    String error = '';
    User? user;
    Member? member;
    try {
      emit(
        state.copyWith(
          loading: true,
          error: error,
        ),
      );
      // Check if exists user.
      final Either<Failure, User> userResult = await userService.getByCode(
        userCodeController.text,
      );
      userResult.fold(
        (failure) {
          error = failure.code;
        },
        (data) {
          user = data;
        },
      );
      if (user == null) return;
      // Save the member on the database
      final Either<Failure, Member> result = memberCode == null
          ? await memberService.create(
              Member(
                code: user!.code,
                birthdate: birthdateController.text.isEmpty
                    ? null
                    : DateFormat('dd/MM/yyyy').parse(
                        birthdateController.text.trim(),
                      ),
                isActive: true,
                user: user,
                firstName: firstNameController.text.trim(),
                idCard: idCardController.text.trim(),
                joinedAt: DateTime.now(),
                lastName: lastNameController.text.trim(),
              ),
            )
          : await memberService.update(
              Member(
                code: user!.code,
                birthdate: birthdateController.text.isEmpty
                    ? null
                    : DateFormat('dd/MM/yyyy').parse(
                        birthdateController.text.trim(),
                      ),
                isActive: true,
                user: user,
                firstName: firstNameController.text.trim(),
                idCard: idCardController.text.trim(),
                joinedAt: DateTime.now(),
                lastName: lastNameController.text.trim(),
              ),
            );
      result.fold(
        (failure) {
          error = failure.code;
        },
        (data) {
          member = data;
        },
      );
    } finally {
      emit(
        state.copyWith(
          loading: false,
          error: error,
          member: Optional.of(member),
        ),
      );
    }
    // memberService.create(
    //   Member(
    //     firstName: firstNameController.text,
    //     idCard: idCardController.text,
    //     lastName: lastNameController.text,
    //   ),
    // );
  }

  String? validateUserCode(String? value) {
    if (value == null || value.trim().length < 20) return 'invalid-user-code';
    return null;
  }

  String? validateIdCard(String? value) {
    if (value == null || value.trim().length != 10) return 'invalid-id-card';
    return null;
  }

  String? validateFirstName(String? value) {
    if (value == null || value.trim().length < 2) return 'invalid-first-name';
    return null;
  }

  String? validateLastName(String? value) {
    if (value == null || value.trim().length < 2) return 'invalid-last-name';
    return null;
  }
}
