import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:member_easy/ui/pages/company/bloc/company_cubit.dart';
import 'package:member_easy/ui/pages/company/bloc/company_state.dart';
import 'package:member_easy/ui/widgets/loading_indicator.dart';

class CompanyForm extends StatelessWidget {
  const CompanyForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<CompanyCubit, CompanyState>(
        builder: (context, state) {
          if (state.isLoading) {
            return LoadingIndicator(
              child: ListView(),
            );
          }
          if (state.companies.isEmpty) {
            return Column(
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
                  AppLocalizations.of(context)!.pleaseRequestToCreateOneBelow,
                  textAlign: TextAlign.center,
                ),
              ],
            );
          }
          return ListView();
        },
      ),
    );
  }
}
