import 'dart:async';
import 'package:ecommerce_openfashion/UI/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,

        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff111111),

      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Container(
                width: 55.w,
                height: 1.5.h,
                color: const Color(0xffC8A44D),
              ),

              SizedBox(height: 30.h),

              Text(
                "MAISON",

                style: GoogleFonts.cormorantGaramond(
                  fontSize: 52.sp,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 10,

                  color: const Color(0xffC8A44D),
                ),
              ),

              SizedBox(height: 5.h),

              Text(
                "LUXE",

                style: GoogleFonts.cormorantGaramond(
                  fontSize: 44.sp,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 12,

                  color: const Color(0xffC8A44D),
                ),
              ),

              SizedBox(height: 28.h),

              Text(
                "ESTABLISHED HERITAGE",

                style: GoogleFonts.montserrat(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 4,

                  color: const Color(0xffC8A44D),
                ),
              ),

              SizedBox(height: 220.h),

              Text(
                "ENTERING THE GALLERY",

                style: GoogleFonts.montserrat(
                  fontSize: 10.sp,
                  letterSpacing: 3,
                  fontWeight: FontWeight.w500,

                  color: Colors.white38,
                ),
              ),

              SizedBox(height: 25.h),

              SizedBox(
                width: 20.w,
                height: 20.h,

                child: const CircularProgressIndicator(
                  strokeWidth: 1.2,
                  color: Color(0xffC8A44D),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
