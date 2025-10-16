import 'package:basepack/basepack.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void showSnackBarWidget({required BuildContext context, required String message}) {
  
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      // behavior: SnackBarBehavior.floating,
      backgroundColor: context.theme.colorScheme.primary,
      shape: const RoundedSuperellipseBorder(
        borderRadius: BorderRadius.vertical(top:  Radius.circular(30)),
      ),
      content: Text(
        message,
        style: GoogleFonts.inter(
          textStyle: context.textTheme.labelLarge,
          color: context.theme.colorScheme.onPrimary,
        ),
      ),
      // showCloseIcon: true,
      padding: const EdgeInsets.only(top: 16, left: 25, right: 20, bottom: 16),
      // closeIconColor: context.theme.colorScheme.onSurface,
      duration: const Duration(seconds: 2),
    ),
  );
}

