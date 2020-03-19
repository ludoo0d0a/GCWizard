import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/theme/colors.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/main_menu/about.dart';
import 'package:gc_wizard/widgets/main_menu/call_for_contribution.dart';
import 'package:gc_wizard/widgets/main_menu/changelog.dart';
import 'package:gc_wizard/widgets/main_menu/general_settings.dart';
import 'package:gc_wizard/widgets/main_menu/settings_coordinates.dart';
import 'package:gc_wizard/widgets/registry.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';
import 'package:gc_wizard/widgets/utils/no_animation_material_page_route.dart';

buildMainMenu(BuildContext context) {
  var header = SizedBox(
    height: 120.0,
    child: DrawerHeader(
      child: Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(2.5),
            child: Image.asset(
              'assets/logo/circle_border_128.png',
            ),
            width: 50.0,
            height: 50.0,
            decoration: BoxDecoration(
              color: ThemeColors.darkgrey,
              shape: BoxShape.circle,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 20
            ),
            child: Text(
              i18n(context, 'app_title'),
              style: TextStyle(
                color: ThemeColors.darkgrey,
                fontSize: 22.0
              ),
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
        color: ThemeColors.accent,
      ),
    ),
  );

  var menuEntries = <Widget>[];
  menuEntries.add(_buildSettingsItem(context));

  final otherMenuItems = [
    {'tool': Registry.toolList.firstWhere((tool) => className(tool.tool) == className(Changelog())), 'icon': Icons.show_chart},
    {'tool': Registry.toolList.firstWhere((tool) => className(tool.tool) == className(About())), 'icon': Icons.info},
  ];

  menuEntries.addAll(
    otherMenuItems.map((item) {
      return _buildMenuItem(context, item);
    }).toList()
  );

  var footer = Column(
    children: <Widget>[
      InkWell(
        child: Container(
          color: ThemeColors.gray,
          width: double.infinity,
          height: 50,
          child: Row(
            children: <Widget>[
              Container(
                child: Icon(Icons.group),
                padding: EdgeInsets.only(
                    left: 15,
                    right: 15
                ),
              ),
              Text(
                i18n(context, 'mainmenu_callforcontribution_title'),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ThemeColors.darkgrey,
                    fontSize: defaultFontSize()
                ),
              ),
            ],
          )
        ),
        onTap: () {
          Navigator.pop(context); //close Drawer
          Navigator.of(context).push(NoAnimationMaterialPageRoute(
            builder: (context) => Registry.toolList.firstWhere((tool) => className(tool.tool) == className(CallForContribution())))
          );
        }
      )
    ],
  );

  return Drawer(
    child: Column(
      children: <Widget>[
        header,
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero, // Remove any padding from the ListView.
            children: menuEntries
          )
        ),
        footer,
      ],
    )
  );
}

_buildSettingsItem(BuildContext context) {
  final settingsItems = [
    {'tool': Registry.toolList.firstWhere((tool) => className(tool.tool) == className(GeneralSettings())), 'icon': Icons.settings},
    {'tool': Registry.toolList.firstWhere((tool) => className(tool.tool) == className(CoordinatesSettings())), 'icon': Icons.language},
  ];

  return ExpansionTile(
    title: Text(
      i18n(context, 'mainmenu_settings_title'),
      style: _menuItemStyle()
    ),
    leading: Icon(
      Icons.settings,
      color: ThemeColors.gray,
    ),
    children: settingsItems.map((item) {
      return Padding(
        padding: EdgeInsets.only(
          left: 25
        ),
        child: _buildMenuItem(context, item)
      );
    }).toList()
  );
}

ListTile _buildMenuItem(BuildContext context, item) {
  return ListTile(
    leading: Icon(
      item['icon'],
      color: ThemeColors.gray,
    ),
    title: Text(
      (item['tool'] as GCWToolWidget).toolName,
      style: _menuItemStyle()
    ),
    onTap: () {
      Navigator.pop(context); //close Drawer
      Navigator.of(context).push(NoAnimationMaterialPageRoute(builder: (context) => item['tool']));
    }
  );
}

_menuItemStyle() {
  return TextStyle(
    color: ThemeColors.gray,
    fontSize: defaultFontSize(),
    fontWeight: FontWeight.normal
  );
}