import 'package:doctor_flutter_laravel/models/auth_model.dart';
import 'package:doctor_flutter_laravel/screens/appointment_page.dart';
import 'package:doctor_flutter_laravel/screens/auth_page.dart';
import 'package:doctor_flutter_laravel/screens/booking_page.dart';
import 'package:doctor_flutter_laravel/screens/success_booked.dart';
import 'package:doctor_flutter_laravel/screens/doctor_details.dart';
import 'package:doctor_flutter_laravel/utils/config.dart';
import 'package:doctor_flutter_laravel/utils/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final navigatorKey = GlobalKey<NavigatorState>();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthModel>(
      create: (context) => AuthModel(),
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Flutter Doctor App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            inputDecorationTheme: const InputDecorationTheme(
                focusColor: Config.primaryColor,
                border: Config.outlineBorder,
                focusedBorder: Config.focusBorder,
                errorBorder: Config.errorBorder,
                enabledBorder: Config.outlineBorder,
                floatingLabelStyle: TextStyle(color: Config.primaryColor),
                prefixIconColor: Colors.black38),
            scaffoldBackgroundColor: Colors.white,
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: Config.primaryColor,
                selectedItemColor: Colors.white,
                showSelectedLabels: true,
                showUnselectedLabels: false,
                unselectedItemColor: Colors.grey.shade700,
                elevation: 10,
                type: BottomNavigationBarType.fixed)),
        initialRoute: '/',
        routes: {
          '/': (context) => const AuthPage(),
          'main': (context) => const MainLayout(),
          'doc_details': (context) => const DoctorDetails(),
          'booking_page': (context) => const BookingPage(),
          'success_booking': (context) => const AppointmentBooked(),
        },
      ),
    );
  }
}
