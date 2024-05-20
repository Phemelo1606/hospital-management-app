import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hospital_management_app/features/user_auth/Presentation/widgets/form_container_widget.dart';
import 'package:hospital_management_app/features/user_auth/Presentation/widgets/providerclass.dart';
import 'package:hospital_management_app/features/user_auth/auth_service.dart';
import 'package:hospital_management_app/routes/routes.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _auth = AuthServices();
  late TextEditingController _nameController;
  late TextEditingController _surnameController;
  late TextEditingController _emailController;
  late TextEditingController _idController;
  late TextEditingController _dateOfBirthController;
  late TextEditingController _contactsController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    //Sets email and password data
    super.initState();
    _nameController = TextEditingController();
    _surnameController = TextEditingController();
    _emailController = TextEditingController();
    _idController = TextEditingController();
    _dateOfBirthController = TextEditingController();
    _contactsController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _surnameController.dispose();
    _idController.dispose();
    _dateOfBirthController.dispose();
    _contactsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 152, 241, 170),
      appBar: AppBar(
        title: const Text('Sign Up Page',style: TextStyle(color: Colors.white),),
        backgroundColor: const Color.fromARGB(255, 54, 157, 75),
      ),
      body:  Center(
        
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            20, 0,20,20
          ),
          child: Form(
            key: _formKey,
             child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Sign Up',
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
                    
                    hintText: "Name",
                    isPasswordField: false,
                    controller: _nameController,
                    validator: (value) {
                      //validates password
                      if (value!.isEmpty) {
                        return 'please enter your Name';
                      }
                      
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FormContainerWidget(
                    hintText: "Surname",
                    isPasswordField: false,
                    controller: _surnameController,
                    validator: (value) {
                      //validates password
                      if (value!.isEmpty) {
                        return 'please enter your Surname';
                      }
                      
                      return null;
                    },
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
                      if (!value.contains('@')) {
                        return 'should contain \'@\' character';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FormContainerWidget(
                    hintText: "ID number",
                    isPasswordField: false,
                    controller: _idController,
                    validator: (value) {
                      //validates password
                      if (value!.isEmpty) {
                        return 'please enter your ID number';
                      }
                      if ((value.length == 14)
                          ) {
                        return 'Number must be 13 numbers';
                      }
                      return null;
                    },
                    ),
                 
                  const SizedBox(
                    height: 10,
                  ),
                  FormContainerWidget(
                    hintText: "Date of Birth(DD/MM/YYYY)",
                    isPasswordField: false,
                    controller: _dateOfBirthController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FormContainerWidget(
                    hintText: "Contact no.",
                    isPasswordField: false,
                    controller: _contactsController,
                    validator: (value) {
                      //validates password
                      if (value!.isEmpty) {
                        return 'please enter your Contact number';
                      }
                      if ((value.length == 11)
                          ) {
                        return 'Number must be 10 numbers';
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
                    validator: (value) {
                      //validates password
                      if (value!.isEmpty) {
                        return 'please enter your password';
                      }
                      if ((value.length == 9) ||
                          !value.contains('@')) {
                        return 'password must be 8 charecters\nand should contain \'@\' character';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                   onPressed: _signup,
                    //_addData,
                   
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 40), // Set the width to match the parent and height to 40
                      backgroundColor: const Color.fromARGB(255, 54, 157, 75),
                      //borderRadius: BorderRadius.circular(10) // Set the button background color
                      // You can also customize other button properties here
                      // For example, padding, shape, elevation, textStyle, etc.
                    ),
                    child: const Text('Sign Up',style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),), // Add your button text here
                          ),
                    const SizedBox(height: 5,),
                    Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have Account?"),
                      const SizedBox(width: 5,),

                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(RouteManager.loginPage,(route)=>false);
                        },
                        child: const Text("Login", style: TextStyle(color: Color.fromARGB(255, 54, 157, 75), fontWeight: FontWeight.bold),),
                      )
                    ],),

                    const SizedBox(
                      height: 5,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Sign Up as Admin?"),
                      const SizedBox(width: 5,),

                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(RouteManager.adminSignUp,(route)=>false);
                        },
                        child: const Text("Sign Up as Admin", style: TextStyle(color: Color.fromARGB(255, 54, 157, 75), fontWeight: FontWeight.bold),),
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

    goToLogin(BuildContext context) => Navigator.of(context).pushNamedAndRemoveUntil(RouteManager.loginPage,(route)=>false);
  



_signup() async 
  {
    final userData = Provider.of<UserData>(context, listen: false);
    userData.setUserData(_nameController.text.trim(), _surnameController.text.trim(), _emailController.text.trim());
    if (_formKey.currentState!.validate()) 
    {
      try 
      {
            final user = await _auth.createUserWithEmailAndPassword
            (
              _emailController.text.trim(),
              _passwordController.text.trim(),
            );
            
            if (user != null) 
            {
              // Collects user data from SignUp Form
              await FirebaseFirestore.instance.collection('user').doc(user.uid).set({
                'name': _nameController.text.trim(),
                'surname': _surnameController.text.trim(),
                'email': _emailController.text.trim(),
                'id': _idController.text.trim(),
                'dateOfBirth': _dateOfBirthController.text.trim(),
                'contact': _contactsController.text.trim(),
                'password': _passwordController.text.trim(),
              });

              log("User Created Successfully");

              // Navigate to login page or main page
              // ignore: use_build_context_synchronously
              goToLogin(context);
            }
          } catch (e) 
          {
            log("Error: $e");
            // ignore: use_build_context_synchronously
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error creating user: $e')),
          );
        }
    }
  }

}