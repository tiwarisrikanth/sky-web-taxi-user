import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxiuser/auth/login_otp.dart';
import 'package:taxiuser/constants/colors/colors.dart';
// import 'package:skydrive_driver/auth/login_otp.dart';
// import 'package:skydrive_driver/constants/colors/colors.dart';
import 'package:toastification/toastification.dart';

class MobileNumberLogin extends StatefulWidget {
  const MobileNumberLogin({super.key});

  @override
  State<MobileNumberLogin> createState() => _MobileNumberLoginState();
}

class _MobileNumberLoginState extends State<MobileNumberLogin> {
  TextEditingController mobileCont = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                      "Login",
                      style: GoogleFonts.poppins(
                        fontSize: 19,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Gap(20),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border:
                              Border.all(color: Colors.grey.withOpacity(0.6))),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: TextFormField(
                          controller: mobileCont,
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
                    ),
                    Gap(20),
                    RichText(
                      text: TextSpan(
                        text: 'By continuing, you agree to the ',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: grey,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'T&C',
                              style: GoogleFonts.poppins(
                                  decoration: TextDecoration.underline,
                                  color: black)),
                          TextSpan(
                              text: " and ",
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                color: grey,
                              )),
                          TextSpan(
                              text: 'Privacy Policy',
                              style: GoogleFonts.poppins(
                                  decoration: TextDecoration.underline,
                                  color: black)),
                        ],
                      ),
                    ),
                    Gap(20),
                    Bounce(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MobileNumberLoginOTP(
                                    numberl: mobileCont.text)));
                        // if (mobileCont.text == "") {
                        //   toastification.show(
                        //     context:
                        //         context, // optional if you use ToastificationWrapper
                        //     type: ToastificationType.error,
                        //     style: ToastificationStyle.flatColored,
                        //     autoCloseDuration: const Duration(seconds: 5),
                        //     title: Text("Form Error"),
                        //     // you can also use RichText widget for title and description parameters
                        //     description:
                        //         Text("Please enter mobile number first"),
                        //     alignment: Alignment.topRight,
                        //     direction: TextDirection.ltr,
                        //     animationDuration:
                        //         const Duration(milliseconds: 300),

                        //     icon: const Icon(Icons.check),
                        //     // primaryColor: Colors.green,

                        //     foregroundColor: Colors.black,
                        //     padding: const EdgeInsets.symmetric(
                        //         horizontal: 12, vertical: 16),
                        //     margin: const EdgeInsets.symmetric(
                        //         horizontal: 12, vertical: 8),
                        //     borderRadius: BorderRadius.circular(12),

                        //     showProgressBar: true,
                        //     closeButtonShowType: CloseButtonShowType.onHover,
                        //     closeOnClick: false,
                        //     pauseOnHover: true,
                        //     dragToClose: true,
                        //   );
                        // } else if (mobileCont.text.length < 10) {
                        //   toastification.show(
                        //     context:
                        //         context, // optional if you use ToastificationWrapper
                        //     type: ToastificationType.error,
                        //     style: ToastificationStyle.flatColored,
                        //     autoCloseDuration: const Duration(seconds: 5),
                        //     title: Text("Form Error"),
                        //     // you can also use RichText widget for title and description parameters
                        //     description: Text(
                        //         "Please enter valid mobile number\nIt should be 10 digits"),
                        //     alignment: Alignment.topRight,
                        //     direction: TextDirection.ltr,
                        //     animationDuration:
                        //         const Duration(milliseconds: 300),

                        //     icon: const Icon(Icons.check),
                        //     // primaryColor: Colors.green,

                        //     foregroundColor: Colors.black,
                        //     padding: const EdgeInsets.symmetric(
                        //         horizontal: 12, vertical: 16),
                        //     margin: const EdgeInsets.symmetric(
                        //         horizontal: 12, vertical: 8),
                        //     borderRadius: BorderRadius.circular(12),

                        //     showProgressBar: true,
                        //     closeButtonShowType: CloseButtonShowType.onHover,
                        //     closeOnClick: false,
                        //     pauseOnHover: true,
                        //     dragToClose: true,
                        //   );
                        // } else {
                        //   toastification.show(
                        //     context:
                        //         context, // optional if you use ToastificationWrapper
                        //     type: ToastificationType.success,
                        //     style: ToastificationStyle.flatColored,
                        //     autoCloseDuration: const Duration(seconds: 5),
                        //     title: Text("OTP Sent"),
                        //     // you can also use RichText widget for title and description parameters
                        //     description: Text(
                        //         "Please check your messages you might have git a message from us containing OTP for login or registration"),
                        //     alignment: Alignment.topRight,
                        //     direction: TextDirection.ltr,
                        //     animationDuration:
                        //         const Duration(milliseconds: 300),

                        //     icon: const Icon(Icons.check),
                        //     // primaryColor: Colors.green,

                        //     foregroundColor: Colors.black,
                        //     padding: const EdgeInsets.symmetric(
                        //         horizontal: 12, vertical: 16),
                        //     margin: const EdgeInsets.symmetric(
                        //         horizontal: 12, vertical: 8),
                        //     borderRadius: BorderRadius.circular(12),

                        //     showProgressBar: true,
                        //     closeButtonShowType: CloseButtonShowType.onHover,
                        //     closeOnClick: false,
                        //     pauseOnHover: true,
                        //     dragToClose: true,
                        //   );
                        //   Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) => MobileNumberLoginOTP(
                        //               numberl: mobileCont.text)));
                        // }
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
                            "Send OTP",
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
