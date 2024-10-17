import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:group_button/group_button.dart';
import 'package:pinput/pinput.dart';
import 'package:taxiuser/constants/colors/colors.dart';
import 'package:taxiuser/views/home/home.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
                height: 300,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
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
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "One last step",
                            style: GoogleFonts.poppins(
                              fontSize: 19,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Container(
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(90),
                            border: Border.all(color: Colors.black45),
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Icon(Icons.call),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Help",
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: black,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    Gap(20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Your Official Name",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    Gap(10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Used for insurance claims",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),

                    Gap(10),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border:
                              Border.all(color: Colors.grey.withOpacity(0.6))),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Row(
                          children: [
                            Icon(Icons.person_outline),
                            Expanded(
                              child: TextFormField(
                                // controller: mobileCont,
                                keyboardType: TextInputType.number,
                                maxLength: 10,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                  hintText: "Enter your mobile number",
                                  hintStyle: GoogleFonts.poppins(
                                    fontSize: 13,
                                    color: grey.withOpacity(0.8),
                                  ),
                                  border: InputBorder.none,
                                  counterText: "",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Gap(20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Gender",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    Gap(10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GroupButton(
                        isRadio:
                            true, // Set to false if you want multi-selection
                        onSelected: (index, isSelected, _) {
                          print('Button $index isSelected: $isSelected');
                        },
                        buttons: ["Male", "Female", "Others"],
                        options: GroupButtonOptions(
                          selectedColor: primaryColor,
                          unselectedColor: white,
                          selectedTextStyle: TextStyle(color: Colors.white),
                          unselectedTextStyle: TextStyle(color: Colors.black),
                          unselectedBorderColor: Colors.black54,
                          selectedBorderColor: primaryColor,
                          borderRadius: BorderRadius.circular(10),
                          spacing: 10,
                        ),
                      ),
                    ),
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
                            builder: (context) => HomeScreen(),
                          ),
                        );
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
                            "Next",
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
