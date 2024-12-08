import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:member_easy/ui/pages/add_edit_member/bloc/add_edit_member_cubit.dart';
import 'package:member_easy/ui/pages/add_edit_member/bloc/add_edit_member_state.dart';
import 'package:member_easy/ui/pages/add_edit_member/widgets/add_edit_member_form.dart';
import 'package:member_easy/ui/utils/banner_util.dart';
import 'package:member_easy/ui/widgets/loading_indicator.dart';

class AddEditMemberPage extends StatelessWidget {
  const AddEditMemberPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AddEditMemberCubit cubit = context.read<AddEditMemberCubit>();
    return Scaffold(
      appBar: AppBar(
        title: BlocListener<AddEditMemberCubit, AddEditMemberState>(
          listener: (context, state) {
            if (state.error.isNotEmpty) {
              BannerUtil.showErrorMaterialBanner(
                message: state.error,
                context: context,
              );
              return;
            }
            if (state.member != null) {
              context.pop(state.member);
              return;
            }
          },
          child: Text(
            cubit.memberCode == null
                ? AppLocalizations.of(context)!.addMember
                : AppLocalizations.of(context)!.editMember,
          ),
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
                    child: BlocSelector<AddEditMemberCubit, AddEditMemberState,
                        bool>(
                      selector: (state) => state.loading,
                      builder: (context, isLoading) {
                        return LoadingIndicator(
                          isLoading: isLoading,
                          child: ElevatedButton.icon(
                            icon: Icon(
                              cubit.memberCode == null
                                  ? Icons.save_outlined
                                  : Icons.update_outlined,
                            ),
                            onPressed: isLoading
                                ? () {}
                                : () {
                                    context
                                        .read<AddEditMemberCubit>()
                                        .saveMember();
                                  },
                            label: Text(
                              cubit.memberCode == null
                                  ? AppLocalizations.of(context)!.save
                                  : AppLocalizations.of(context)!.update,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16.0),
                ],
              ),
      ),
    );
  }
}
