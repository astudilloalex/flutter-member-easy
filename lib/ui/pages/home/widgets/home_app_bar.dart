import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_easy/app/asset/icon_asset.dart';
import 'package:member_easy/app/bloc/app_cubit.dart';
import 'package:member_easy/app/bloc/app_state.dart';
import 'package:member_easy/src/company/domain/company.dart';
import 'package:member_easy/ui/widgets/my_user_qr_code_dialog.dart';

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
        IconButton(
          icon: Image.asset(
            IconAsset.loading.name,
            width: 24.0,
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return const MyUserQRCodeDialog();
              },
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
