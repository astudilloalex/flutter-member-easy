import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:go_router/go_router.dart';
import 'package:member_easy/ui/routes/route_name.dart';

class HomeSpeedDial extends StatelessWidget {
  const HomeSpeedDial({super.key});

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      activeIcon: Icons.close_outlined,
      icon: Icons.add_outlined,
      children: [
        SpeedDialChild(
          child: const Icon(Icons.person_outline_outlined),
          label: AppLocalizations.of(context)!.addMember,
          onTap: () {
            context.push(RouteName.addEditMember);
          },
        ),
      ],
    );
  }
}
