import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_easy/app/bloc/app_cubit.dart';
import 'package:member_easy/ui/pages/home/bloc/home_cubit.dart';
import 'package:member_easy/ui/pages/home/bloc/home_state.dart';
import 'package:member_easy/ui/pages/home/widgets/home_app_bar.dart';
import 'package:member_easy/ui/pages/home/widgets/home_drawer.dart';
import 'package:member_easy/ui/pages/home/widgets/home_speed_dial.dart';
import 'package:member_easy/ui/pages/home/widgets/home_summary_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
      listenWhen: (previous, current) =>
          previous.companies != current.companies,
      listener: (context, state) {
        if (state.companies.isEmpty) return;
        context.read<AppCubit>().changeCurrentCompany(state.companies.first);
      },
      child: const Scaffold(
        appBar: HomeAppBar(),
        body: HomeSummaryList(),
        drawer: HomeDrawer(),
        floatingActionButton: HomeSpeedDial(),
      ),
    );
  }
}
