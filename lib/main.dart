import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hospital_management_app/features/app/splash%20_screen/splash_screen.dart';
import 'package:hospital_management_app/features/user_auth/Presentation/pages/user_sign_up.dart';
import 'package:hospital_management_app/features/user_auth/Presentation/widgets/adminprovider.dart';
import 'package:hospital_management_app/features/user_auth/Presentation/widgets/providerclass.dart';
import 'package:hospital_management_app/routes/routes.dart';
import 'package:provider/provider.dart';
Future main() async{
  WidgetsFlutterBinding.ensureInitialized();


  Platform.isAndroid?

  await Firebase.initializeApp(
    options: const FirebaseOptions(apiKey: "AIzaSyAOCK1S5nsfsxcpMJqc1QHIVDyLba4vqHk", appId: "1:566465323906:android:7d41bae2f9ed347d4f259b", messagingSenderId: "566465323906", projectId: "hospital-management-app-fc345"),)

  
  :await Firebase.initializeApp();
 
  runApp(
    MultiProvider(
      providers: [ 
        ChangeNotifierProvider(create: (context) => UserData()),
         ChangeNotifierProvider(create: (context) => AdminData()),
      ],
      child : const MyApp(),
      ),
  );
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flutter Firebase",
      home: SplashScreen(
        child:SignUpPage(),
      ) ,
      onGenerateRoute: RouteManager.generateRoute,
    
    );
  }
}

