import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:member_easy/ui/pages/home/widgets/home_drawer_header.dart';
import 'package:member_easy/ui/routes/route_name.dart';
import 'package:member_easy/ui/widgets/logout_alert_dialog.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            const HomeDrawerHeader(),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: const Icon(Icons.card_membership),
                    title: Text(
                      AppLocalizations.of(context)!.members,
                    ),
                    onTap: () {
                      context.push(RouteName.member);
                    },
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings_outlined),
              title: Text(
                AppLocalizations.of(context)!.configuration,
              ),
              onTap: () {
                context.push(RouteName.company);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout_outlined),
              title: Text(
                AppLocalizations.of(context)!.logout,
              ),
              onTap: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => const LogoutAlertDialog(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
