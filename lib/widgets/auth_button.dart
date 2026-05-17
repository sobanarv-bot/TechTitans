import 'package:flutter/material.dart';

class AuthButton
    extends StatelessWidget {
  final String text;
  final VoidCallback?
      onPressed;

  final bool isLoading;

  const AuthButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return SizedBox(
      width: double.infinity,
      height: 50,

      child: ElevatedButton(
        onPressed:
            isLoading
                ? null
                : onPressed,

        style:
            ElevatedButton.styleFrom(
          backgroundColor:
              const Color(
            0xFFB71C1C,
          ),

          foregroundColor:
              Colors.white,

          shape:
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(
              25,
            ),
          ),
        ),

        child:
            isLoading
                ? const CircularProgressIndicator(
                    color:
                        Colors
                            .white,
                  )
                : Text(
                    text,
                    style:
                        const TextStyle(
                      fontSize:
                          16,
                      fontWeight:
                          FontWeight
                              .bold,
                    ),
                  ),
      ),
    );
  }
}