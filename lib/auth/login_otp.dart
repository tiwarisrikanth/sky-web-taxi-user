import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:taxiuser/auth/register.dart';
import 'package:taxiuser/constants/colors/colors.dart';

class MobileNumberLoginOTP extends StatefulWidget {
  String numberl;
  MobileNumberLoginOTP({super.key, required this.numberl});

  @override
  State<MobileNumberLoginOTP> createState() => _MobileNumberLoginOTPState();
}

class _MobileNumberLoginOTPState extends State<MobileNumberLoginOTP> {
// final focusedPinTheme = defaultPinTheme.copyDecorationWith(
//   border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
//   borderRadius: BorderRadius.circular(8),
// );

// final submittedPinTheme = defaultPinTheme.copyWith(
//   decoration: defaultPinTheme.decoration.copyWith(
//     color: Color.fromRGBO(234, 239, 243, 1),
//   ),
// );
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(183, 220, 250, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    return Scaffold(
      backgroundColor: secondaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Transform.scale(
              scale: 1.1,
              child: Image.asset(
                'assets/images/illus.png',
              ),
            ),
            Container(
              height: 500,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(25),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Gap(10),
                    Text(
                      "OTP Verification",
                      style: GoogleFonts.poppins(
                        fontSize: 19,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Gap(20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Enter verification code",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Sent to ${widget.numberl}",
                        style: GoogleFonts.poppins(
                          color: black.withOpacity(0.4),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Gap(20),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Pinput(
                          length: 6,
                          defaultPinTheme: defaultPinTheme,
                          focusedPinTheme: focusedPinTheme,
                          submittedPinTheme: submittedPinTheme,
                          validator: (s) {
                            return s == '222222' ? null : 'Pin is incorrect';
                          },
                          pinputAutovalidateMode:
                              PinputAutovalidateMode.onSubmit,
                          showCursor: true,
                          onCompleted: (pin) => print(pin),
                        )),
                    Gap(20),
                    // RichText(
                    //   text: TextSpan(
                    //     text: 'By continuing, you agree to the ',
                    //     style: GoogleFonts.poppins(
                    //       fontSize: 13,
                    //       color: grey,
                    //     ),
                    //     children: <TextSpan>[
                    //       TextSpan(
                    //           text: 'T&C',
                    //           style: GoogleFonts.poppins(
                    //               decoration: TextDecoration.underline,
                    //               color: black)),
                    //       TextSpan(
                    //           text: " and ",
                    //           style: GoogleFonts.poppins(
                    //             fontSize: 13,
                    //             color: grey,
                    //           )),
                    //       TextSpan(
                    //           text: 'Privacy Policy',
                    //           style: GoogleFonts.poppins(
                    //               decoration: TextDecoration.underline,
                    //               color: black)),
                    //     ],
                    //   ),
                    // ),
                    // Gap(20),
                    Bounce(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterScreen()));
                      },
                      child: Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: thirdColor,
                        ),
                        child: Center(
                          child: Text(
                            "Proceed",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
