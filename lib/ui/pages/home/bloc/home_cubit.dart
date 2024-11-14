import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_easy/src/member/domain/member.dart';
import 'package:member_easy/ui/pages/home/bloc/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState()) {
    log('HomeCubit created', name: 'Cubit');
    init();
  }

  Future<void> init() async {
    emit(
      state.copyWith(
        members: [
          Member(
            firstName: 'Andrea',
            idCard: '0150561531',
            lastName: 'Astudillo',
          ),
          Member(
            firstName: 'Juan',
            idCard: '0150561531',
            lastName: 'Valdez',
          ),
          Member(
            firstName: 'Maria Rosa',
            idCard: '0150561531',
            lastName: 'Argudo',
          ),
        ],
      ),
    );
  }

  @override
  Future<void> close() {
    log('HomeCubit closed', name: 'Cubit');
    return super.close();
  }
}
