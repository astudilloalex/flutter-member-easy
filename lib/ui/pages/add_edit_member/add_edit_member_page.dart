import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:member_easy/ui/pages/add_edit_member/bloc/add_edit_member_cubit.dart';
import 'package:member_easy/ui/pages/add_edit_member/widgets/add_edit_member_form.dart';

class AddEditMemberPage extends StatelessWidget {
  const AddEditMemberPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AddEditMemberCubit cubit = context.read<AddEditMemberCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          cubit.memberCode == null
              ? AppLocalizations.of(context)!.addMember
              : AppLocalizations.of(context)!.editMember,
        ),
      ),
      body: SafeArea(
        child: cubit.company == null
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.youDontHaveAnyBusinesses,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0,
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context)!.pleaseGoToSettings,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              )
            : Column(
                children: [
                  const Expanded(
                    child: CustomScrollView(
                      slivers: [
                        AddEditMemberForm(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ElevatedButton.icon(
                      icon: Icon(
                        cubit.memberCode == null
                            ? Icons.save_outlined
                            : Icons.update_outlined,
                      ),
                      onPressed: () {},
                      label: Text(
                        cubit.memberCode == null
                            ? AppLocalizations.of(context)!.save
                            : AppLocalizations.of(context)!.update,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                ],
              ),
      ),
    );
  }
}
