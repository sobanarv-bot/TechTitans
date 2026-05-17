import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Column(
      children: const [
        Text(
          'PENNYWISE',
          style: TextStyle(
            fontSize: 32,
            fontWeight:
                FontWeight.w900,
            letterSpacing: 1.5,
            color: Color(
              0xFFB71C1C,
            ),
          ),
        ),

        Text(
          'by TechTitans',
          style: TextStyle(
            fontSize: 12,
            fontWeight:
                FontWeight.w500,
            fontStyle:
                FontStyle.italic,
            color:
                Colors.black38,
          ),
        ),
      ],
    );
  }
}