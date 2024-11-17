import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:member_easy/app/bloc/app_cubit.dart';
import 'package:member_easy/app/bloc/app_state.dart';
import 'package:member_easy/src/user/domain/user.dart';

class HomeDrawerHeader extends StatelessWidget {
  const HomeDrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AppCubit, AppState, User?>(
      selector: (state) {
        return state.currentUser;
      },
      builder: (context, user) {
        return DrawerHeader(
          child: Column(
            children: [
              CircleAvatar(
                radius: 40.0,
                backgroundImage:
                    user?.photoURL == null || user!.photoURL!.isEmpty
                        ? null
                        : NetworkImage(
                            user.photoURL!,
                          ),
              ),
              const SizedBox(height: 8.0),
              Text(user?.email ?? ''),
            ],
          ),
        );
      },
    );
  }
}
