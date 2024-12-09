import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:member_easy/ui/pages/member_detail/bloc/member_detail_cubit.dart';
import 'package:member_easy/ui/pages/member_detail/bloc/member_detail_state.dart';

class MemberDetailPage extends StatelessWidget {
  const MemberDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.memberDetail),
      ),
      body: SafeArea(
        child: BlocBuilder<MemberDetailCubit, MemberDetailState>(
          builder: (context, state) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    DateFormat('dd/MM/yyyy').format(
                      state.attendances[index].date,
                    ),
                  ),
                );
              },
              itemCount: state.attendances.length,
            );
          },
        ),
      ),
    );
  }
}
