import 'package:flutter/material.dart';
import 'package:hospital_management_app/features/user_auth/Presentation/widgets/adminprovider.dart';
import 'dart:developer';
import 'package:hospital_management_app/features/user_auth/Presentation/widgets/form_container_widget.dart';
import 'package:hospital_management_app/features/user_auth/auth_service.dart';
import 'package:hospital_management_app/routes/routes.dart';
import 'package:provider/provider.dart';

class AdminRegistrationPage extends StatefulWidget {
  const AdminRegistrationPage({super.key});

  @override
  State<AdminRegistrationPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminRegistrationPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _auth = AuthServices();

  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _nameController;
  late TextEditingController _surnameController;

  @override
  void initState() {
    //Sets email and password data
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _nameController = TextEditingController();
    _surnameController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _surnameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
       return Scaffold(
        backgroundColor: const Color.fromARGB(255, 152, 241, 170),
      appBar: AppBar(
        title: const Text(
          'Admin Signup Page',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 54, 157, 75),
      ),
      body:  Center(
        child: Padding(
          padding: const EdgeInsets.all(
            20.0,
          ),
          child: Form(
            key: _formKey,
              child: SingleChildScrollView(
                  child: Column(
                    
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                const Icon(
                              Icons.account_circle,
                              size: 150,
                              color: Color.fromARGB(255, 54, 157, 75),
                            ),
                const SizedBox(
                  height: 20,
                ),

                const Text('Admin Signup',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                ),
                const SizedBox(height: 10,),

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
                  hintText: "Password",
                  isPasswordField: true,
                  controller: _passwordController,
                  validator: (value) {
                      //validates password
                      if (value!.isEmpty) {
                        return 'please enter your password';
                      }
                      if ((value.length == 8) ||
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
                  onPressed: _signup, //_addData,

                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity,
                        40), // Set the width to match the parent and height to 40
                    backgroundColor: const Color.fromARGB(255, 54, 157, 75),
                    //borderRadius: BorderRadius.circular(10) // Set the button background color
                    // You can also customize other button properties here
                    // For example, padding, shape, elevation, textStyle, etc.
                  ),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ), // Add your button text here
                ),
                const SizedBox(
                  height: 5,
                ),
               const SizedBox(height: 5,),
                    Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Not Admin?"),
                      const SizedBox(width: 5,),

                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(RouteManager.signUpPage,(route)=>false);
                        },
                        child: const Text("Sign Up", style: TextStyle(color:  Color.fromARGB(255, 54, 157, 75),fontWeight: FontWeight.bold),),
                      )
                    ],),
              ],
              ),
              ),
              ),
        ),
      ),
    );
  }
  goToLogin(BuildContext context) => Navigator.of(context).pushNamedAndRemoveUntil(RouteManager.adminPage,(route)=>false);
  

  _signup() async{
    final adminData = Provider.of<AdminData>(context, listen: false);
    adminData.setAdminData(_emailController.text.trim(),);
    final user = await _auth.createUserWithEmailAndPassword(_emailController.text, _passwordController.text);
    
    if(user != null || _formKey.currentState!.validate()){


      log("User Created Successfully");


      

      // ignore: use_build_context_synchronously
      goToLogin(context);
    }
  }
}
  

late TextEditingController _emailController;

late TextEditingController _passwordController;

@override
void initState() {
  //Sets email and password data
  _emailController = TextEditingController();
  _passwordController = TextEditingController();
}

@override
void dispose() {
  _emailController.dispose();
  _passwordController.dispose();
}
