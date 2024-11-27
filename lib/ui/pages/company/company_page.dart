import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:member_easy/ui/pages/company/widgets/company_app_bar_bottom.dart';
import 'package:member_easy/ui/pages/company/widgets/company_form.dart';
import 'package:url_launcher/url_launcher.dart';

class CompanyPage extends StatelessWidget {
  const CompanyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.companies),
        bottom: const CompanyAppBarBottom(),
      ),
      body: const CompanyForm(),
      bottomNavigationBar: BottomAppBar(
        height: 95.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppLocalizations.of(context)!.doYouHaveACompany,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () async {
                    if (await canLaunchUrl(
                      Uri.parse(
                        'https://wa.me/593987980568?text=${Uri.encodeComponent('Member Easy: I need a company')}',
                      ),
                    )) {
                      launchUrl(
                        Uri.parse(
                          'https://wa.me/593987980568?text=${Uri.encodeComponent('Member Easy: I need a company')}',
                        ),
                      );
                    } else {
                      launchUrl(
                        Uri.parse(
                          'tel:+593987980568',
                        ),
                      );
                    }
                  },
                  icon: const Icon(FontAwesomeIcons.whatsapp),
                ),
                IconButton(
                  onPressed: () {
                    launchUrl(
                      Uri.parse(
                        'https://www.instagram.com/alexastudillooficial/',
                      ),
                    );
                  },
                  icon: const Icon(FontAwesomeIcons.instagram),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
