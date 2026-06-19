import 'package:ecommerce_openfashion/UI/HomeScreen.dart';
import 'package:ecommerce_openfashion/UI/SignScreen.dart';
import 'package:ecommerce_openfashion/firebase_options.dart';
import 'package:ecommerce_openfashion/services/Notification_%20Service.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MaisonLuxeApp());
}

class MaisonLuxeApp extends StatelessWidget {
  const MaisonLuxeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,

      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: FirebaseAuth.instance.currentUser != null
              ? const MainNavigationScreen()
              : const LoginScreen(),
        );
      },
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;
  bool obscurePassword = true;

  Future<void> login() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.white,
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: dark),
            borderRadius: BorderRadius.circular(0),
          ),
          content: Row(
            children: [
              const Icon(Icons.info_outline, size: 16, color: dark),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  "Please complete all required fields to continue.",
                  style: GoogleFonts.montserrat(
                    color: dark,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      await NotificationService.saveFcmToken();
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      await NotificationService.saveFcmToken();

      await NotificationService.addNotification(
        title: "🎉 Welcome Back",
        body: "Successfully signed in",
      );

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainNavigationScreen()),
      );
    } on FirebaseAuthException catch (e) {
      String message =
          "We're unable to complete your sign-in request at this time. Please try again shortly.";

      if (e.code == 'user-not-found') {
        message =
            "We couldn't find an account associated with this email address.";
      } else if (e.code == 'wrong-password') {
        message = "The password entered is incorrect. Please try again.";
      } else if (e.code == 'invalid-email') {
        message = "Please enter a valid email address.";
      } else if (e.code == 'too-many-requests') {
        message =
            "Too many attempts detected. Please try again in a few moments.";
      } else if (e.code == 'network-request-failed') {
        message =
            "Connection unavailable. Please check your internet and try again.";
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.white,
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: dark),
            borderRadius: BorderRadius.circular(0),
          ),
          content: Row(
            children: [
              const Icon(Icons.info_outline, size: 16, color: dark),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  message,
                  style: GoogleFonts.montserrat(
                    color: dark,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      setState(() {
        isLoading = true;
      });

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        setState(() {
          isLoading = false;
        });

        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,

        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);

      await NotificationService.saveFcmToken();
      await NotificationService.addNotification(
        title: "🎉 Welcome Back",
        body: "Successfully signed in with Google",
      );

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainNavigationScreen()),
      );
    } catch (e) {
      String message =
          "We're unable to create your account at this time. Please try again shortly.";

      if (e is FirebaseAuthException) {
        if (e.code == 'email-already-in-use') {
          message = "An account with this email already exists.";
        } else if (e.code == 'weak-password') {
          message = "Please choose a stronger password to continue.";
        } else if (e.code == 'invalid-email') {
          message = "Please enter a valid email address.";
        }
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.white,
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: dark),
            borderRadius: BorderRadius.circular(0),
          ),
          content: Row(
            children: [
              const Icon(Icons.info_outline, color: dark, size: 16),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  message,
                  style: GoogleFonts.montserrat(
                    color: dark,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
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
      body: Stack(
        children: [
          // BACKGROUND IMAGE

          // OVERLAY
          Container(color: Colors.white.withOpacity(0.45)),

          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 20.h),

                child: Container(
                  width: double.infinity,

                  padding: EdgeInsets.symmetric(
                    horizontal: 30.w,
                    vertical: 40.h,
                  ),

                  decoration: BoxDecoration(
                    color: const Color(0xffF4F1EC),

                    border: Border.all(color: Colors.grey.shade300),
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: [
                      Text(
                        "MAISON LUXE",

                        textAlign: TextAlign.center,

                        style: GoogleFonts.cormorantGaramond(
                          fontSize: 42.sp,
                          letterSpacing: 8,

                          color: Colors.black,
                        ),
                      ),

                      SizedBox(height: 45.h),

                      Text(
                        "Login",

                        style: GoogleFonts.cormorantGaramond(
                          fontSize: 34.sp,
                          fontWeight: FontWeight.bold,

                          color: Colors.black,
                        ),
                      ),

                      SizedBox(height: 18.h),

                      Text(
                        "Enter your credentials to access your\nprivate collection.",

                        textAlign: TextAlign.center,

                        style: GoogleFonts.montserrat(
                          fontSize: 14.sp,
                          height: 1.8,

                          color: Colors.black54,
                        ),
                      ),

                      SizedBox(height: 55.h),

                      Align(
                        alignment: Alignment.centerLeft,

                        child: Text(
                          "Email Address",

                          style: GoogleFonts.montserrat(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,

                            letterSpacing: 3,
                          ),
                        ),
                      ),

                      SizedBox(height: 15.h),

                      TextField(
                        controller: emailController,

                        style: GoogleFonts.montserrat(),

                        decoration: InputDecoration(
                          hintText: "name@maisonluxe.com",

                          hintStyle: GoogleFonts.montserrat(
                            color: Colors.grey.shade400,
                            fontSize: 13.sp,
                          ),

                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),

                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),

                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                      ),

                      SizedBox(height: 45.h),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          Text(
                            "Password",

                            style: GoogleFonts.montserrat(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,

                              letterSpacing: 3,
                            ),
                          ),

                          Text(
                            "Forgot Password?",

                            style: GoogleFonts.cormorantGaramond(
                              fontSize: 16.sp,

                              fontStyle: FontStyle.italic,

                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 15.h),

                      TextField(
                        controller: passwordController,

                        obscureText: obscurePassword,

                        style: GoogleFonts.montserrat(),

                        decoration: InputDecoration(
                          hintText: "••••••••",

                          hintStyle: GoogleFonts.montserrat(
                            color: Colors.grey.shade400,
                            fontSize: 13.sp,
                          ),

                          suffixIcon: IconButton(
                            icon: Icon(
                              obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,

                              size: 20.sp,
                            ),

                            onPressed: () {
                              setState(() {
                                obscurePassword = !obscurePassword;
                              });
                            },
                          ),

                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),

                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),

                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                      ),

                      SizedBox(height: 50.h),

                      SizedBox(
                        width: double.infinity,
                        height: 58.h,

                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                          ),

                          onPressed: isLoading ? null : login,

                          child: isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text(
                                  "LOGIN",

                                  style: GoogleFonts.montserrat(
                                    letterSpacing: 4,

                                    fontSize: 14.sp,

                                    color: const Color(0xffD6B14D),

                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      ),

                      SizedBox(height: 50.h),

                      Row(
                        children: [
                          Expanded(child: Divider(color: Colors.grey.shade300)),

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),

                            child: Text(
                              "OR",

                              style: GoogleFonts.montserrat(
                                color: Colors.black54,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),

                          Expanded(child: Divider(color: Colors.grey.shade300)),
                        ],
                      ),

                      SizedBox(height: 45.h),

                      SizedBox(
                        width: double.infinity,
                        height: 60.h,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: const Color(0xffF4F1EC),
                            side: const BorderSide(
                              color: Colors.black,
                              width: 1.2,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                          ),
                          onPressed: signInWithGoogle,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.g_mobiledata,
                                  size: 34.sp,
                                  color: Colors.black,
                                ),
                                SizedBox(width: 6.w),
                                Text(
                                  "SIGN IN WITH GOOGLE",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 13.sp,
                                    letterSpacing: 1.5,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 45.h),

                      Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: GoogleFonts.montserrat(
                              fontSize: 12.sp,
                              color: Colors.black54,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const SignupScreen(),
                                ),
                              );
                            },
                            child: Text(
                              "Create an Account",
                              style: GoogleFonts.cormorantGaramond(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 30.h),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          Text(
                            "PRIVACY POLICY",

                            style: GoogleFonts.montserrat(
                              fontSize: 10.sp,
                              letterSpacing: 2,
                              color: Colors.black45,
                            ),
                          ),

                          Text(
                            "TERMS OF SERVICE",

                            style: GoogleFonts.montserrat(
                              fontSize: 10.sp,
                              letterSpacing: 2,
                              color: Colors.black45,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
