import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_easy/ui/pages/member/bloc/member_cubit.dart';
import 'package:member_easy/ui/pages/member/bloc/member_state.dart';
import 'package:member_easy/ui/pages/member/widgets/member_tile.dart';

class MemberList extends StatelessWidget {
  const MemberList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MemberCubit, MemberState>(
      builder: (context, state) {
        return ListView.builder(
          itemBuilder: (context, index) {
            return MemberTile(
              member: state.members[index],
            );
          },
          itemCount: state.members.length,
        );
      },
    );
  }
}
