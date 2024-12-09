import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:member_easy/src/member/domain/member.dart';
import 'package:member_easy/ui/pages/member/bloc/member_cubit.dart';
import 'package:member_easy/ui/routes/route_name.dart';

class MemberTile extends StatelessWidget {
  const MemberTile({
    super.key,
    required this.member,
  });

  final Member member;

  @override
  Widget build(BuildContext context) {
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
        onTap: () {
          context.push('${RouteName.memberDetail}/${member.code}');
        },
        subtitle: Text(member.idCard),
        trailing: IconButton(
          onPressed: () {
            context.read<MemberCubit>().markAttendance(member);
          },
          icon: const Icon(FontAwesomeIcons.clipboardUser),
        ),
      ),
    );
  }
}
