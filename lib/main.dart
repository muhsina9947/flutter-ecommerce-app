import 'package:ecommerce_openfashion/PROVIDER/cart_provider.dart';
import 'package:ecommerce_openfashion/PROVIDER/wishlist_provider.dart';
import 'package:ecommerce_openfashion/UI/SplashScreen.dart';
import 'package:ecommerce_openfashion/firebase_options.dart';
import 'package:ecommerce_openfashion/services/Notification_%20Service.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await NotificationService.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),

        ChangeNotifierProvider(create: (_) => WishlistProvider()),
      ],

      child: ScreenUtilInit(
        designSize: const Size(390, 844),

        minTextAdapt: true,

        splitScreenMode: true,

        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,

            title: 'Open Fashion',

            theme: ThemeData(scaffoldBackgroundColor: Colors.white),

            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
