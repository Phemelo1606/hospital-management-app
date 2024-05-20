import 'package:flutter/material.dart';
import 'package:hospital_management_app/features/app/splash%20_screen/splash_screen.dart';
import 'package:hospital_management_app/features/user_auth/Presentation/pages/admin.dart';
import 'package:hospital_management_app/features/user_auth/Presentation/pages/admin_registration_page.dart';
import 'package:hospital_management_app/features/user_auth/Presentation/pages/appointment_page.dart';
import 'package:hospital_management_app/features/user_auth/Presentation/pages/login.dart';
import 'package:hospital_management_app/features/user_auth/Presentation/pages/main_page.dart';
import 'package:hospital_management_app/features/user_auth/Presentation/pages/profile.dart';
import 'package:hospital_management_app/features/user_auth/Presentation/pages/review_page.dart';
import 'package:hospital_management_app/features/user_auth/Presentation/pages/user_sign_up.dart';

class RouteManager
{
  static const String splashScreen = "/";
  static const String signUpPage = "/signUp";
  static const String loginPage = "/login";
  static const String mainPage = "/mainPage";
  static const String appointmentPage = "/appointmentPage";
  static const String adminPage = "/adminPage";
  static const String reviewPage = "/reviewPage";
  static const String adminSignUp = "/adminSignUp";
  static const String profilePage = "/profilePage";

  static Route<dynamic> generateRoute (RouteSettings settings) {
    switch (settings.name){
      case splashScreen:
        return MaterialPageRoute(builder: (context) => const SplashScreen(),
        );
      case signUpPage:
        return MaterialPageRoute(builder: (context) => const SignUpPage(),
        );
      case loginPage:
        return MaterialPageRoute(builder: (context) => const LoginPage(),
        );
        case mainPage:
        return MaterialPageRoute(builder: (context) => const MainPage(),
        );

        case appointmentPage:
        return MaterialPageRoute(builder: (context) => const AppointmentPage(),
        );

        case adminPage:
        return MaterialPageRoute(builder: (context) => const AdminPage(),
        );

        case reviewPage:
        return MaterialPageRoute(builder: (context) => const ReviewPage(),
        );

        case adminSignUp:
        return MaterialPageRoute(builder: (context) => const AdminRegistrationPage(),
        );

        case profilePage:
        return MaterialPageRoute(builder: (context) => const ProfilePage(),
        );

        default:
        throw const FormatException('Route Not found!!');
    }


  }
}