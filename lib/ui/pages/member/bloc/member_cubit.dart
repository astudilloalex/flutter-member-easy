import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_easy/ui/pages/member/bloc/member_state.dart';

class MemberCubit extends Cubit<MemberState> {
  MemberCubit() : super(const MemberState()) {
    log('MemberCubit created', name: 'Cubit');
  }

  @override
  Future<void> close() {
    log('MemberCubit closed', name: 'Cubit');
    return super.close();
  }
}
