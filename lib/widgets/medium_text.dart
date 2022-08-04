import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class MediumText extends StatelessWidget {
  final Color? color;
  final String text;
  double size;
  TextOverflow overFlow;
  TextAlign? textAlign;

  MediumText({Key? key, this.color,
    this.textAlign,
    required this.text,
    this.size = 24,
    this.overFlow = TextOverflow.ellipsis,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overFlow,
      textAlign: textAlign,
      style: GoogleFonts.poppins(
        color: color,
        fontSize: size,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
