import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final Widget? child;
  const SplashScreen({super.key, this.child});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {

@override
  void initState() {
    
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => widget.child!), (route) => false);
    }
    );
    super.initState();
  }



  @override

  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: prefer_const_constructors
      backgroundColor: Color.fromARGB(255, 152, 241, 170),
      body : Center(
       child: Column(
        children: [Image.asset('lib/features/user_auth/Presentation/image/logo.jpg'),
        const Text("Hospital Management made easy",style :TextStyle(color: Color.fromARGB(255, 27, 39, 49),fontWeight: FontWeight.bold, fontSize: 25,),
        ),
        ],
        ),
        
      )
    );
  }
}