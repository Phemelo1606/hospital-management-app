import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hospital_management_app/features/user_auth/Presentation/widgets/form_container_widget.dart';

import 'package:hospital_management_app/features/user_auth/auth_service.dart';
import 'package:hospital_management_app/routes/routes.dart';




class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _auth = AuthServices();
  

  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    //Sets email and password data
    super.initState();
    // _nameController = TextEditingController();
    // _surnameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    //  _nameController.dispose();
    // _surnameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 152, 241, 170),
      appBar: AppBar(
        title: const Text('Login Page',style: TextStyle(color: Colors.white),),
        backgroundColor: const Color.fromARGB(255, 54, 157, 75),
      ),
      body:  Center(
        child: Padding(
          padding: const EdgeInsets.all(
            20.0,
          ),
          child: Form(
             key: _formKey ,
             child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.account_circle,
                    size: 100,
                    color: Color.fromARGB(255, 54, 157, 75),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Log In',
                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FormContainerWidget(
                    hintText: "Email",
                    isPasswordField: false,
                    controller: _emailController,
                    validator: (value) {
                      //Validates email
                      if (value!.isEmpty) {
                        return 'please enter your email address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FormContainerWidget(
                    hintText: "Password",
                    isPasswordField: true,
                    controller: _passwordController,
                    
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                 //login button
                ElevatedButton.icon(
                  icon:  const Icon(
                  Icons.login,
                  color: Colors.white,),
                    onPressed: _logIn,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 40), 
                      backgroundColor: const Color.fromARGB(255, 54, 157, 75),
                     
                    ),
                    label: const Text('LogIn',style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                          ),

                    const SizedBox(height: 5,),
                    Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Dont have an Account?"),
                      const SizedBox(width: 5,),

                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(RouteManager.signUpPage,(route)=>false);
                        },
                        child: const Text("Sign Up", style: TextStyle(color: Color.fromARGB(255, 54, 157, 75),fontWeight: FontWeight.bold),),
                      )
                    ],)
                  ]
              )
             )
          ),
        ),
        
      ),
    );
  }

    goToMain(BuildContext context) => Navigator.of(context).pushNamedAndRemoveUntil(RouteManager.mainPage,(route)=>false);

  _logIn() async{
    
    
    final user = 
      await _auth.loginUserWithEmailAndPassword(_emailController.text, _passwordController.text);
    if(user != null){
      log("User Logged In");
      // ignore: use_build_context_synchronously
      goToMain(context);
    }
  }


}