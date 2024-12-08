import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:member_easy/src/member/domain/member.dart';
import 'package:member_easy/ui/pages/member/bloc/member_cubit.dart';
import 'package:member_easy/ui/pages/member/widgets/member_list.dart';
import 'package:member_easy/ui/routes/route_name.dart';

class MemberPage extends StatelessWidget {
  const MemberPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.members),
      ),
      body: const SafeArea(
        child: MemberList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final Member? member = await context.push<Member?>(
            RouteName.addEditMember,
          );
          if (member == null || !context.mounted) return;
          context.read<MemberCubit>().addEditMember(member);
        },
        child: const Icon(Icons.add_outlined),
      ),
    );
  }
}
