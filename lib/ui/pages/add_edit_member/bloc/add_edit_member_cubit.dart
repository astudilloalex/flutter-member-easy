import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:member_easy/src/company/domain/company.dart';
import 'package:member_easy/ui/pages/add_edit_member/bloc/add_edit_member_state.dart';

class AddEditMemberCubit extends Cubit<AddEditMemberState> {
  AddEditMemberCubit({
    this.company,
    this.memberCode,
  }) : super(const AddEditMemberState()) {
    log('AddEditMemberCubit created', name: 'Cubit');
  }

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
}
