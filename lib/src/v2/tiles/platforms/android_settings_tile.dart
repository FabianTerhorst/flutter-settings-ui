import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui_v2.dart';
import 'package:settings_ui/src/v2/utils/settings_theme.dart';

class AndroidSettingsTile extends StatelessWidget {
  const AndroidSettingsTile({
    required this.tileType,
    required this.leading,
    required this.title,
    required this.description,
    required this.onPressed,
    required this.onToggle,
    required this.value,
    required this.initialValue,
    required this.activeSwitchColor,
    Key? key,
  }) : super(key: key);

  final SettingsTileType tileType;
  final Widget? leading;
  final Widget? title;
  final Widget? description;
  final Function(BuildContext context)? onPressed;
  final Function(bool value)? onToggle;
  final Widget? value;
  final bool initialValue;
  final Color? activeSwitchColor;

  @override
  Widget build(BuildContext context) {
    final theme = SettingsTheme.of(context);
    final scaleFactor = MediaQuery.of(context).textScaleFactor;

    final cantShowAnimation = tileType == SettingsTileType.switchTile
        ? onToggle == null && onPressed == null
        : onPressed == null;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: cantShowAnimation
            ? null
            : () {
                if (tileType == SettingsTileType.switchTile) {
                  onToggle?.call(!initialValue);
                } else {
                  onPressed?.call(context);
                }
              },
        highlightColor: theme.themeData.tileHighlightColor,
        child: Container(
          child: Row(
            children: [
              if (leading != null)
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 24),
                  child: IconTheme(
                    data: IconTheme.of(context).copyWith(
                      color: theme.themeData.leadingIconsColor,
                    ),
                    child: leading!,
                  ),
                ),
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.only(
                    start: 24,
                    end: 24,
                    bottom: 19 * scaleFactor,
                    top: 19 * scaleFactor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DefaultTextStyle(
                        style: TextStyle(
                          color: theme.themeData.settingsTileTextColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                        child: title ?? Container(),
                      ),
                      if (value != null)
                        Padding(
                          padding: EdgeInsets.only(top: 4.0),
                          child: DefaultTextStyle(
                            style: TextStyle(
                              color: theme.themeData.tileDescriptionTextColor,
                            ),
                            child: value!,
                          ),
                        )
                      else if (description != null)
                        Padding(
                          padding: EdgeInsets.only(top: 4.0),
                          child: DefaultTextStyle(
                            style: TextStyle(
                              color: theme.themeData.tileDescriptionTextColor,
                            ),
                            child: description!,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              // if (tileType == SettingsTileType.switchTile)
              //   SizedBox(
              //     height: 30,
              //     child: VerticalDivider(),
              //   ),
              if (tileType == SettingsTileType.switchTile)
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 16, end: 8),
                  child: Switch.adaptive(
                    value: initialValue,
                    onChanged: onToggle,
                    activeColor: activeSwitchColor,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
