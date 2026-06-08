import 'package:ecommerce_openfashion/UI/HomeScreen.dart';
import 'package:ecommerce_openfashion/UI/LoginScreen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() =>
      _SignupScreenState();
}

class _SignupScreenState
    extends State<SignupScreen> {

  bool obscurePassword = true;

  bool isLoading = false;

  final nameController =
      TextEditingController();

  final emailController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  ////////////////////////////////////////////////////////////
  /// CREATE ACCOUNT
  ////////////////////////////////////////////////////////////

  Future<void> createAccount() async {

    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(
          content:
          Text("Please fill all fields"),
        ),
      );

      return;
    }

    try {

      setState(() {
        isLoading = true;
      });

      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(

        email:
        emailController.text.trim(),

        password:
        passwordController.text.trim(),
      );

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(
          content:
          Text("Account Created Successfully"),
        ),
      );

      Navigator.pushReplacement(

        context,

        MaterialPageRoute(
          builder: (context) =>
          const MainNavigationScreen(),
        ),
      );

    } on FirebaseAuthException catch (e) {

      String message = "Signup Failed";

      if (e.code == 'weak-password') {

        message = "Password is too weak";
      }

      else if (e.code ==
          'email-already-in-use') {

        message =
        "Email already exists";
      }

      else if (e.code ==
          'invalid-email') {

        message = "Invalid email";
      }

      ScaffoldMessenger.of(context)
          .showSnackBar(

        SnackBar(
          content: Text(message),
        ),
      );

    } finally {

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
      const Color(0xffF4F1EC),

      body: SafeArea(

        child: SingleChildScrollView(

          child: Padding(

            padding:
            EdgeInsets.symmetric(
              horizontal: 28.w,
            ),

            child: Column(

              children: [

                SizedBox(height: 40.h),

                //////////////////////////////////////////////////////
                /// LOGO
                //////////////////////////////////////////////////////

                Text(
                  "MAISON LUXE",

                  style: GoogleFonts
                      .cormorantGaramond(

                    fontSize: 38.sp,
                    letterSpacing: 8,
                    fontWeight:
                    FontWeight.w500,

                    color: Colors.black,
                  ),
                ),

                SizedBox(height: 12.h),

                //////////////////////////////////////////////////////
                /// SUBTITLE
                //////////////////////////////////////////////////////

                Text(
                  "THE NEW FRONTIER OF LUXURY",

                  style:
                  GoogleFonts.montserrat(

                    fontSize: 11.sp,
                    letterSpacing: 4,
                    fontWeight:
                    FontWeight.w500,

                    color: Colors.black87,
                  ),
                ),

                SizedBox(height: 70.h),

                //////////////////////////////////////////////////////
                /// TITLE
                //////////////////////////////////////////////////////

                Text(
                  "Create Your Account",

                  style: GoogleFonts
                      .cormorantGaramond(

                    fontSize: 34.sp,
                    fontWeight:
                    FontWeight.w600,

                    color: Colors.black,
                  ),
                ),

                SizedBox(height: 20.h),

                //////////////////////////////////////////////////////
                /// DESCRIPTION
                //////////////////////////////////////////////////////

                Text(
                  "Join our exclusive community and\n"
                      "discover the latest in editorial fashion.",

                  textAlign:
                  TextAlign.center,

                  style:
                  GoogleFonts.montserrat(

                    fontSize: 14.sp,
                    height: 1.8,

                    color: Colors.black54,
                  ),
                ),

                SizedBox(height: 55.h),

                //////////////////////////////////////////////////////
                /// FULL NAME
                //////////////////////////////////////////////////////

                Align(

                  alignment:
                  Alignment.centerLeft,

                  child: Text(
                    "FULL NAME",

                    style:
                    GoogleFonts.montserrat(

                      fontSize: 13.sp,
                      letterSpacing: 3,
                      fontWeight:
                      FontWeight.w600,

                      color: Colors.black87,
                    ),
                  ),
                ),

                SizedBox(height: 15.h),

                TextField(

                  controller:
                  nameController,

                  style:
                  GoogleFonts.montserrat(
                    letterSpacing: 1,
                  ),

                  decoration:
                  InputDecoration(

                    hintText:
                    "E.G. JULIAN MORGAN",

                    hintStyle:
                    GoogleFonts.montserrat(

                      color:
                      Colors.grey.shade400,

                      letterSpacing: 1,
                      fontSize: 13.sp,
                    ),

                    filled: true,
                    fillColor:
                    Colors.transparent,

                    contentPadding:
                    EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 22.h,
                    ),

                    enabledBorder:
                    OutlineInputBorder(

                      borderRadius:
                      BorderRadius.circular(0),

                      borderSide:
                      BorderSide(
                        color: Colors
                            .grey.shade400,
                      ),
                    ),

                    focusedBorder:
                    const OutlineInputBorder(

                      borderRadius:
                      BorderRadius.zero,

                      borderSide:
                      BorderSide(
                        color:
                        Colors.black,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 35.h),

                //////////////////////////////////////////////////////
                /// EMAIL
                //////////////////////////////////////////////////////

                Align(

                  alignment:
                  Alignment.centerLeft,

                  child: Text(
                    "EMAIL ADDRESS",

                    style:
                    GoogleFonts.montserrat(

                      fontSize: 13.sp,
                      letterSpacing: 3,
                      fontWeight:
                      FontWeight.w600,

                      color: Colors.black87,
                    ),
                  ),
                ),

                SizedBox(height: 15.h),

                TextField(

                  controller:
                  emailController,

                  style:
                  GoogleFonts.montserrat(
                    letterSpacing: 1,
                  ),

                  decoration:
                  InputDecoration(

                    hintText:
                    "EMAIL@MAISONLUXE.COM",

                    hintStyle:
                    GoogleFonts.montserrat(

                      color:
                      Colors.grey.shade400,

                      letterSpacing: 1,
                      fontSize: 13.sp,
                    ),

                    filled: true,
                    fillColor:
                    Colors.transparent,

                    contentPadding:
                    EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 22.h,
                    ),

                    enabledBorder:
                    OutlineInputBorder(

                      borderRadius:
                      BorderRadius.circular(0),

                      borderSide:
                      BorderSide(
                        color: Colors
                            .grey.shade400,
                      ),
                    ),

                    focusedBorder:
                    const OutlineInputBorder(

                      borderRadius:
                      BorderRadius.zero,

                      borderSide:
                      BorderSide(
                        color:
                        Colors.black,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 35.h),

                //////////////////////////////////////////////////////
                /// PASSWORD
                //////////////////////////////////////////////////////

                Align(

                  alignment:
                  Alignment.centerLeft,

                  child: Text(
                    "CREATE PASSWORD",

                    style:
                    GoogleFonts.montserrat(

                      fontSize: 13.sp,
                      letterSpacing: 3,
                      fontWeight:
                      FontWeight.w600,

                      color: Colors.black87,
                    ),
                  ),
                ),

                SizedBox(height: 15.h),

                TextField(

                  controller:
                  passwordController,

                  obscureText:
                  obscurePassword,

                  style:
                  GoogleFonts.montserrat(),

                  decoration:
                  InputDecoration(

                    hintText:
                    "••••••••",

                    hintStyle:
                    GoogleFonts.montserrat(
                      color:
                      Colors.grey.shade400,
                    ),

                    filled: true,
                    fillColor:
                    Colors.transparent,

                    contentPadding:
                    EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 22.h,
                    ),

                    suffixIcon:
                    IconButton(

                      onPressed: () {

                        setState(() {

                          obscurePassword =
                          !obscurePassword;
                        });
                      },

                      icon: Icon(

                        obscurePassword

                            ? Icons
                            .visibility_off_outlined

                            : Icons
                            .visibility_outlined,

                        color: Colors.grey,
                      ),
                    ),

                    enabledBorder:
                    OutlineInputBorder(

                      borderRadius:
                      BorderRadius.circular(0),

                      borderSide:
                      BorderSide(
                        color: Colors
                            .grey.shade400,
                      ),
                    ),

                    focusedBorder:
                    const OutlineInputBorder(

                      borderRadius:
                      BorderRadius.zero,

                      borderSide:
                      BorderSide(
                        color:
                        Colors.black,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 45.h),

                //////////////////////////////////////////////////////
                /// CREATE ACCOUNT BUTTON
                //////////////////////////////////////////////////////

                SizedBox(

                  width: double.infinity,
                  height: 60.h,

                  child: ElevatedButton(

                    style:
                    ElevatedButton.styleFrom(

                      backgroundColor:
                      Colors.black,

                      elevation: 0,

                      shape:
                      RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(0),
                      ),
                    ),

                    onPressed:
                    isLoading
                        ? null
                        : createAccount,

                    child: isLoading

                        ? const CircularProgressIndicator(
                      color: Colors.white,
                    )

                        : Text(
                      "CREATE ACCOUNT",

                      style:
                      GoogleFonts.montserrat(

                        fontSize: 14.sp,
                        letterSpacing: 3,
                        fontWeight:
                        FontWeight.w600,

                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 70.h),

                //////////////////////////////////////////////////////
                /// TERMS
                //////////////////////////////////////////////////////

                Text(
                  "By signing up, you agree to our\n"
                      "Terms & Privacy Policy.",

                  textAlign:
                  TextAlign.center,

                  style:
                  GoogleFonts.montserrat(

                    fontSize: 13.sp,
                    height: 1.8,

                    color: Colors.black54,
                  ),
                ),

                SizedBox(height: 30.h),

                Container(
                  width: 80.w,
                  height: 1.h,
                  color: Colors.grey.shade400,
                ),

                SizedBox(height: 30.h),

                //////////////////////////////////////////////////////
                /// LOGIN TEXT
                //////////////////////////////////////////////////////

                Row(

                  mainAxisAlignment:
                  MainAxisAlignment.center,

                  children: [

                    Text(
                      "Already a member?",

                      style:
                      GoogleFonts.montserrat(

                        fontSize: 14.sp,
                        color: Colors.black87,
                      ),
                    ),

                    SizedBox(width: 10.w),

                    GestureDetector(

                      onTap: () {

                        Navigator.push(

                          context,

                          MaterialPageRoute(
                            builder: (context) =>
                            const LoginScreen(),
                          ),
                        );
                      },

                      child: Text(
                        "LOGIN",

                        style:
                        GoogleFonts.montserrat(

                          fontSize: 14.sp,
                          letterSpacing: 2,
                          fontWeight:
                          FontWeight.bold,

                          decoration:
                          TextDecoration
                              .underline,

                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 40.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}