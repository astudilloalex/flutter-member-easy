import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_easy/app/asset/icon_asset.dart';
import 'package:member_easy/app/bloc/app_cubit.dart';
import 'package:member_easy/app/bloc/app_state.dart';
import 'package:member_easy/src/company/domain/company.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: BlocSelector<AppCubit, AppState, Company?>(
        selector: (state) {
          return state.currentCompany;
        },
        builder: (context, company) {
          return Text(company?.tradename ?? 'Member Easy');
        },
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Image.asset(IconAsset.loading.name, height: 30.0),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
