import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/common/base/gcw_divider.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/main_menu/gcw_mainmenuentry_stub.dart';
import 'package:gc_wizard/widgets/main_menu/licenses.dart';
import 'package:gc_wizard/widgets/registry.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';
import 'package:gc_wizard/widgets/utils/no_animation_material_page_route.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

final ABOUT_MAINTAINER = 'Mark \'S-Man42\' Lorenz';

class About extends StatefulWidget {
  @override
  AboutState createState() => AboutState();
}

class AboutState extends State<About> {

  var packageInfo = PackageInfo();

  var boldTextStyle = gcwTextStyle().copyWith(fontWeight: FontWeight.bold);

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      packageInfo = info;
    });
  }

  _buildUrl(String key) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: GCWText(
              text: i18n(context, 'about_${key}')
            ),
            flex: 2
          ),
          Expanded(
            child: InkWell(
              child: Text(
                i18n(context, 'about_${key}_url_text'),
                style: gcwHyperlinkTextStyle(),
              ),
              onTap: () {
                launch(i18n(context, 'about_${key}_url'));
              },
            ),
            flex: 3
          )
        ]
      ),
      padding: EdgeInsets.only(
        top: 15,
        bottom: 10
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    var content = Column(
      children: <Widget>[
        Text(
          'GC Wizard - Geocache Wizard',
          style: gcwTextStyle().copyWith(fontWeight: FontWeight.bold)
        ),
        GCWDivider(),
        Container(
          child: Row(
            children: <Widget>[
              Expanded(
                child: GCWText(
                  text: i18n(context, 'about_version')
                ),
                flex: 2
              ),
              Expanded(
                child: GCWText(
                  text: '${packageInfo.version} (Build: ${packageInfo.buildNumber})'
                ),
                flex: 3
              )
            ]
          ),
          padding: EdgeInsets.only(
            top: 15
          )
        ),
        Container(
          child: Row(
            children: <Widget>[
              Expanded(
                child: GCWText(
                  text: i18n(context, 'about_maintainer')
                ),
                flex: 2
              ),
              Expanded(
                child: GCWText(
                  text: ABOUT_MAINTAINER
                ),
                flex: 3
              )
            ]
          ),
          padding: EdgeInsets.only(
            top: 15,
            bottom: 10
          )
        ),
        GCWDivider(),
        _buildUrl('contact_email'),
        _buildUrl('faq'),
        _buildUrl('blog'),
        _buildUrl('twitter'),
        _buildUrl('facebook'),
        _buildUrl('webversion'),
        GCWDivider(),
        _buildUrl('license'),
        _buildUrl('github'),
        GCWDivider(),
        _buildUrl('privacypolicy'),
        GCWDivider(),
        InkWell(
          child: Container(
            child: Align(
              child: Text(
                i18n(context, 'about_thirdparty'),
                style: gcwHyperlinkTextStyle(),
                textAlign: TextAlign.center,
              ),
              alignment: Alignment.center,
            ),
            padding: EdgeInsets.only(
              top: 15,
              bottom: 10
            ),
          ),
          onTap: () {
            Navigator.of(context).push(NoAnimationMaterialPageRoute(
              builder: (context) => Registry.toolList.firstWhere((tool) => className(tool.tool) == className(Licenses())))
            );
          },
        ),
        GCWDivider(),
        Container(
          child: Column(
            children: <Widget>[
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: i18n(context, 'about_team') + '\n',
                      style: boldTextStyle
                    ),
                    TextSpan(
                      text: [
                        'Andy \'Puma66\' (Special Support)',
                        'Andreas \'TeamBirdy2404\' (Symbol Tables)',
                        'Mike B. (Code & Symbol Tables)',
                        'Thomas \'TMZ\' Z. (Code & Symbol Tables)',
                      ].join('\n') + '\n'
                    )
                  ],
                  style: gcwTextStyle()
                ),
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: i18n(context, 'about_specialthanks') + '\n',
                      style: boldTextStyle
                    ),
                    TextSpan(
                        text: 'Daniel \'Eisbehr\' K. (Maintainer GCC)'
                            + '\n'
                    )
                  ],
                  style: gcwTextStyle()
                ),
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: i18n(context, 'about_contributors') + '\n',
                      style: boldTextStyle
                    ),
                    TextSpan(
                      text:
                        [
                          '\'\xc4ggsb\xe4rde\' (Symbol Tables)',
                          '\'capoaira\' (Code)',
                          'Dennis \'dennistreysa\' (Code)',
                          'Frank \'Wizardland\' (podKst.de) (Hardware)',
                          '\'Geo-Link\' (Hardware & Symbol Tables)',
                          'Karl B. (Coords Algorithms)',
                          'Michael D. (Symbol Tables)',
                          '\'moenk\' (GK Coords)',
                          '\'Schnatt\' (Symbol Tables)',
                          'Udo J. (Code)',
                          '\'wollpirat\' (Food, Tea & more)'
                        ].join('\n') + '\n'
                    )
                  ],
                  style: gcwTextStyle()
                ),
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: i18n(context, 'about_testers') + '\n',
                      style: boldTextStyle
                    ),
                    TextSpan(
                      text:
                        [
                          '\'4-Everus\'',
                          'Andreas E.',
                          '\'Don Rodolphos\'',
                          '\'Headbanger-Berlin\'',
                          'Felix Z.',
                          '\'Filu - Aye, Käppn! - 43\' & \'Stormi - Aaarrh - 2061\'',
                          'Franz K.',
                          '\'Freakyfinder\'',
                          'Johannes C.',
                          'Jonas M.',
                          '\'Klumpenkukuk\'',
                          '\'LupiMus\'',
                          '\'mahoplus\'',
                          'Martin Sch.',
                          '\'mgo\'',
                          '\'MrDosinger\'',
                          'Niki R.',
                          'Palk \'geogedoens.de\'',
                          '\'Pamakaru\'',
                          'Paweł B.',
                          '\'radioscout\'',
                          '\'radlerandi\'',
                          '\'Sechsfüssler\'',
                          'Stefan J.',
                          '\'tebarius\'',
                          '\'tomcat06\'',
                          '\'Vyrembi\''
                        ].join(', ')
                    )
                  ],
                  style: gcwTextStyle()
                ),
              ),
            ],
          ),
          padding: EdgeInsets.only(
            top: 15,
            bottom: 10
          ),
        ),
        GCWDivider(),
        Container(
          child: GCWText(
            align: Alignment.center,
            textAlign: TextAlign.center,
            text: i18n(context, 'about_notfornazis')
          ),
          padding: EdgeInsets.only(
            top: 15,
            bottom: 10
          ),
        )

      ],
    );

    return GCWMainMenuEntryStub(
      content: content
    );
  }
}