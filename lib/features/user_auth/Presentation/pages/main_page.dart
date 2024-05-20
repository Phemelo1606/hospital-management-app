import 'package:flutter/material.dart';
import 'package:hospital_management_app/features/user_auth/Presentation/widgets/providerclass.dart';
import 'package:hospital_management_app/features/user_auth/auth_service.dart';
import 'package:hospital_management_app/routes/routes.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
      final _auth = AuthServices();
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 152, 241, 170),
      appBar: AppBar(
        title: const Text("Hospital Management App",style: TextStyle(color: Colors.white),),
        backgroundColor: const Color.fromARGB(255, 54, 157, 75),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('lib/features/user_auth/Presentation/image/logo.jpg', width: 300,),
          const SizedBox(
            height: 10,
          ),
           Text("Welcome : ${userData.name} ${userData.surname} "),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 40,
            width: 200,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 40),
                backgroundColor: const Color.fromARGB(255, 54, 157, 75),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                 Navigator.of(context).pushNamed(RouteManager.appointmentPage);
              },
              child: const Text("Appointments Page",style: TextStyle(color: Colors.white),),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 40,
            width: 200,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 40), 
                backgroundColor: const Color.fromARGB(255, 54, 157, 75),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(RouteManager.profilePage);
              },
              child: const Text("My-profile Page",style: TextStyle(color: Colors.white),),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 40,
            width: 200,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 40), 
                backgroundColor: const Color.fromARGB(255, 54, 157, 75),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(RouteManager.reviewPage);
              },
              child: const Text("Review Page",style: TextStyle(color: Colors.white),),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 40,
            width: 150,
            //logout button
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 40),
                backgroundColor: const Color.fromARGB(255, 54, 157, 75),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () async{
                await _auth.signout();
                // ignore: use_build_context_synchronously
                goToLogin(context);

              },
              child: const Text("Logout",style: TextStyle(color: Colors.white),),
            ),
          ),
        ],
      )),
    );
  }
  goToLogin(BuildContext context) => Navigator.of(context).pushNamedAndRemoveUntil(RouteManager.loginPage,(route)=>false);
}