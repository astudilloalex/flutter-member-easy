import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:member_easy/src/member/domain/member.dart';
import 'package:member_easy/ui/pages/member/bloc/member_cubit.dart';
import 'package:member_easy/ui/pages/member/bloc/member_state.dart';
import 'package:member_easy/ui/routes/route_name.dart';

class MemberList extends StatelessWidget {
  const MemberList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MemberCubit, MemberState>(
      builder: (context, state) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final Member member = state.members[index];
            return Slidable(
              startActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (_) async {
                      final Member? savedMember = await context.push<Member?>(
                        '${RouteName.addEditMember}?code=${member.code}',
                      );
                      if (savedMember == null || !context.mounted) return;
                      context.read<MemberCubit>().addEditMember(savedMember);
                    },
                    icon: Icons.edit_outlined,
                    label: AppLocalizations.of(context)!.edit,
                  ),
                ],
              ),
              child: ListTile(
                title: Text(
                  member.fullName,
                ),
                subtitle: Text(member.idCard),
                //onTap: () {},
              ),
            );
          },
          itemCount: state.members.length,
        );
      },
    );
  }
}
