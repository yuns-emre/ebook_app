import 'package:ebook_app/theme/theme.dart';
import 'package:ebook_app/theme/theme_provide.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LightDarkSwitch extends StatefulWidget {
  const LightDarkSwitch({super.key});

  @override
  State<LightDarkSwitch> createState() => _LightDarkSwitchState();
}

class _LightDarkSwitchState extends State<LightDarkSwitch> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
      alignment: Alignment.centerRight,
      child: Switch(
        value: themeProvider.themeData == darkMode ? true : false,
        onChanged: (isOn) {
          themeProvider.tooggleThese();
        },
        activeColor: Theme.of(context).colorScheme.primary,
        activeTrackColor: Theme.of(context).colorScheme.secondary,
        inactiveThumbColor: Theme.of(context).colorScheme.primary,
        inactiveTrackColor: Theme.of(context).colorScheme.secondary,
        thumbIcon: MaterialStatePropertyAll(
          Icon(themeProvider.themeData == darkMode
              ? Icons.dark_mode_rounded
              : Icons.light_mode_sharp),
        ),
      ),
    );
  }
}
