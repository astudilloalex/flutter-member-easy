import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:member_easy/ui/pages/add_edit_member/bloc/add_edit_member_cubit.dart';

class AddEditMemberForm extends StatelessWidget {
  const AddEditMemberForm({super.key});

  @override
  Widget build(BuildContext context) {
    final AddEditMemberCubit cubit = context.read<AddEditMemberCubit>();
    return Form(
      key: cubit.formKey,
      child: SliverList.list(
        children: [
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              controller: cubit.userCodeController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.userCode,
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.qr_code_scanner_outlined),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              controller: cubit.idCardController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.idCard,
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              controller: cubit.firstNameController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.firstName,
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              controller: cubit.lastNameController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.lastName,
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              readOnly: true,
              controller: cubit.birthdateController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.birthdate,
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.calendar_month_outlined),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
