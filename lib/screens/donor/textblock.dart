
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextBlock extends StatelessWidget {
  const TextBlock({
    Key? key,
    required this.title,
    required this.icons,
  }) : super(key: key);

  final String title;
  final IconData icons;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icons, color: Colors.red),
        const SizedBox(width: 8.0),
        Expanded(
          child: Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.lexend(
              fontWeight: FontWeight.w500,
              fontSize: 12.0,
              color: const Color(0xFF868484),
            ),
          ),
        ),
      ],
    );
  }
}
