import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class GlobalWidgets {
  static Widget appTitle(
      {bool isInAppBar = false, bool isDark = true, double size = 30}) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'Nature',
          style: GoogleFonts.montserrat(
              fontSize: isInAppBar ? 20 : size,
              fontWeight: FontWeight.w700,
              color: Colors.green),
          children: [
            TextSpan(
              text: 'Save',
              style: TextStyle(
                  color: isDark ? Colors.black : Colors.white,
                  fontSize: isInAppBar ? 20 : size),
            ),
          ]),
    );
  }

  static Widget customPlatformDialog(
      {String title, String content, List<Widget> actions}) {
    return PlatformAlertDialog(
      title: Center(
        child: Text(
          title,
          style:
              GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
      content: Text(
        content,
        style: GoogleFonts.montserrat(fontSize: 12),
        textAlign: TextAlign.center,
      ),
      actions: actions,
      material: (context, platform) => MaterialAlertDialogData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      cupertino: (context, platform) => CupertinoAlertDialogData(),
    );
  }

  static Widget defaultButton(
      {Function() onTap,
      Widget content,
      Color color,
      BorderRadius borderRadius}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: color,
          borderRadius: borderRadius ?? BorderRadius.circular(15),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: content,
          ),
        ),
      ),
    );
  }
}
