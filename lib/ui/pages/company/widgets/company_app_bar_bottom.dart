import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_easy/src/company/domain/company.dart';
import 'package:member_easy/ui/pages/company/bloc/company_cubit.dart';
import 'package:member_easy/ui/pages/company/bloc/company_state.dart';

class CompanyAppBarBottom extends StatelessWidget
    implements PreferredSizeWidget {
  const CompanyAppBarBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: BlocBuilder<CompanyCubit, CompanyState>(
          builder: (context, state) {
            return ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(width: 8.0),
              scrollDirection: Axis.horizontal,
              itemCount: state.companies.length,
              itemBuilder: (context, index) {
                final Company company = state.companies[index];
                return ChoiceChip(
                  label: Text(company.tradename),
                  selected: company == state.selectedCompany,
                );
              },
            );
          },
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(50.0);
}
