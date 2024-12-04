import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:member_easy/ui/pages/add_edit_member/bloc/add_edit_member_cubit.dart';
import 'package:member_easy/ui/widgets/qr_scanner_dialog.dart';

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
                  onPressed: () {
                    showDialog<String?>(
                      context: context,
                      builder: (context) {
                        return const QRScannerDialog();
                      },
                    ).then(
                      (value) {
                        if (value == null || !context.mounted) return;
                        cubit.updateUserCode(value);
                      },
                    );
                  },
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
              keyboardType: TextInputType.name,
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
              keyboardType: TextInputType.name,
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
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      firstDate: DateTime(1950),
                      lastDate: DateTime.now(),
                      initialDate: cubit.birthdateController.text.isEmpty
                          ? null
                          : DateFormat('dd/MM/yyyy').parse(
                              cubit.birthdateController.text,
                            ),
                    ).then(
                      (value) {
                        if (!context.mounted) return;
                        cubit.updateBirthdate(value);
                      },
                    );
                  },
                  icon: const Icon(Icons.calendar_month_outlined),
                ),
              ),
              keyboardType: TextInputType.datetime,
              onTap: () {
                showDatePicker(
                  context: context,
                  firstDate: DateTime(1950),
                  lastDate: DateTime.now(),
                  initialDate: cubit.birthdateController.text.isEmpty
                      ? null
                      : DateFormat('dd/MM/yyyy').parse(
                          cubit.birthdateController.text,
                        ),
                ).then(
                  (value) {
                    if (!context.mounted) return;
                    cubit.updateBirthdate(value);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
