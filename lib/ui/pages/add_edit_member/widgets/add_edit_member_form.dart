import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:member_easy/app/enum/loading_type_enum.dart';
import 'package:member_easy/ui/pages/add_edit_member/bloc/add_edit_member_cubit.dart';
import 'package:member_easy/ui/pages/add_edit_member/bloc/add_edit_member_state.dart';
import 'package:member_easy/ui/widgets/loading_indicator.dart';
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
            child: BlocSelector<AddEditMemberCubit, AddEditMemberState, bool>(
              selector: (state) => state.loading,
              builder: (context, isLoading) {
                return LoadingIndicator(
                  isLoading: isLoading,
                  loadingType: LoadingTypeEnum.textField,
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: cubit.userCodeController,
                    readOnly: cubit.memberCode != null,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.userCode,
                      suffixIcon: cubit.memberCode != null
                          ? null
                          : IconButton(
                              onPressed: () {
                                showDialog<String?>(
                                  context: context,
                                  builder: (context) {
                                    return const QRScannerDialog();
                                  },
                                ).then(
                                  (value) {
                                    if (value == null || !context.mounted) {
                                      return;
                                    }
                                    cubit.updateUserCode(value);
                                  },
                                );
                              },
                              icon: const Icon(Icons.qr_code_scanner_outlined),
                            ),
                    ),
                    validator: cubit.validateUserCode,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: BlocSelector<AddEditMemberCubit, AddEditMemberState, bool>(
              selector: (state) => state.loading,
              builder: (context, isLoading) {
                return LoadingIndicator(
                  isLoading: isLoading,
                  loadingType: LoadingTypeEnum.textField,
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: cubit.idCardController,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.idCard,
                    ),
                    keyboardType: TextInputType.number,
                    validator: cubit.validateIdCard,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: BlocSelector<AddEditMemberCubit, AddEditMemberState, bool>(
              selector: (state) => state.loading,
              builder: (context, isLoading) {
                return LoadingIndicator(
                  isLoading: isLoading,
                  loadingType: LoadingTypeEnum.textField,
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: cubit.firstNameController,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.firstName,
                    ),
                    keyboardType: TextInputType.name,
                    validator: cubit.validateFirstName,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: BlocSelector<AddEditMemberCubit, AddEditMemberState, bool>(
              selector: (state) => state.loading,
              builder: (context, isLoading) {
                return LoadingIndicator(
                  isLoading: isLoading,
                  loadingType: LoadingTypeEnum.textField,
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: cubit.lastNameController,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.lastName,
                    ),
                    keyboardType: TextInputType.name,
                    validator: cubit.validateLastName,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: BlocSelector<AddEditMemberCubit, AddEditMemberState, bool>(
              selector: (state) => state.loading,
              builder: (context, isLoading) {
                return LoadingIndicator(
                  isLoading: isLoading,
                  loadingType: LoadingTypeEnum.textField,
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
