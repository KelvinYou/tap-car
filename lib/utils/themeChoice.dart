import 'package:flutter/material.dart';
import 'package:tap_car/utils/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tap_car/utils/themeModeNotifier.dart';

class ThemeChoice extends StatefulWidget {
  ThemeChoice() : super();
  @override
  ThemeChoiceState createState() => ThemeChoiceState();
}

class ThemeChoiceState extends State<ThemeChoice> {
  late ThemeMode _selectedThemeMode;

  List _options = [
    {"title": 'System', "value": ThemeMode.system},
    {"title": 'Light', "value": ThemeMode.light},
    {"title": 'Dark', "value": ThemeMode.dark}
  ];

  @override
  void initState() {
    super.initState();
  }

  List<Widget> _createOptions(ThemeModeNotifier themeModeNotifier) {
    List<Widget> widgets = [];
    for (Map option in _options) {
      widgets.add(
        RadioListTile(
          value: option['value'],
          groupValue: _selectedThemeMode,
          title: Text(option['title']),
          onChanged: (mode) {
            _setSelectedThemeMode(mode, themeModeNotifier);
          },
          selected: _selectedThemeMode == option['value'],
          activeColor: AppTheme.primary,
        ),
      );
    }
    return widgets;
  }

  void _setSelectedThemeMode(
      ThemeMode mode, ThemeModeNotifier themeModeNotifier) async {
    themeModeNotifier.setThemeMode(mode);
    var prefs = await SharedPreferences.getInstance();
    prefs.setInt('themeMode', mode.index);
    setState(() {
      _selectedThemeMode = mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    // init radios with current themeMode
    final themeModeNotifier = Provider.of<ThemeModeNotifier>(context);
    setState(() {
      _selectedThemeMode = themeModeNotifier.getThemeMode();
    });
    // build the Widget
    return Container(
      height: double.infinity,
      decoration:
          BoxDecoration(color: Theme.of(context).colorScheme.background),
      child: Column(
        children: <Widget>[
          Column(
            children: _createOptions(themeModeNotifier),
          ),
          SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }
}
