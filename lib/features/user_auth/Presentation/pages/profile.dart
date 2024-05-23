import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hospital_management_app/features/user_auth/Presentation/widgets/form_container_widget.dart';
import 'package:hospital_management_app/routes/routes.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _surnameController;
  late TextEditingController _emailController;
  late TextEditingController _idController;
  late TextEditingController _dateOfBirthController;
  late TextEditingController _contactsController;
  late TextEditingController _passwordController;
  late String userId;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _surnameController = TextEditingController();
    _emailController = TextEditingController();
    _idController = TextEditingController();
    _dateOfBirthController = TextEditingController();
    _contactsController = TextEditingController();
    _passwordController = TextEditingController();

    _loadUserData();
  }

Future<void> _loadUserData() async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    userId = user.uid;
    DocumentSnapshot userData = await FirebaseFirestore.instance.collection('user').doc(userId).get();
    
    if (userData.exists) {
      setState(() {
        _nameController.text = userData['name'];
        _surnameController.text = userData['surname'];
        _emailController.text = userData['email'];
        _idController.text = userData['id'];
        _dateOfBirthController.text = userData['dateOfBirth'];
        _contactsController.text = userData['contact'];
        _passwordController.text = userData['password'];
      });
    } else {
      // Handle the case when the document does not exist
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User data does not exist')),
      );
    }
  }
}


  Future<void> _updateUserProfile() async {
    if (_formKey.currentState!.validate()) {
      await FirebaseFirestore.instance.collection('user').doc(userId).update({
        'name': _nameController.text,
        'surname': _surnameController.text,
        'email': _emailController.text,
        'id': _idController.text,
        'dateOfBirth': _dateOfBirthController.text,
        'contact': _contactsController.text,
        'password': _passwordController.text,
      });
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile updated successfully')));
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _emailController.dispose();
    _idController.dispose();
    _dateOfBirthController.dispose();
    _contactsController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
      backgroundColor: const Color.fromARGB(255, 152, 241, 170),
      appBar: AppBar(
        // leading: ElevatedButton(style: ElevatedButton.styleFrom(
        //               minimumSize: const Size(double.infinity, 40),
        //               backgroundColor: const Color.fromARGB(255, 54, 157, 75),
        //               shape: RoundedRectangleBorder(
        //                 borderRadius: BorderRadius.circular(20),
        //               ),
                      
        //             ), onPressed: () {
        //   Navigator.of(context).popAndPushNamed(RouteManager.mainPage);
        // },child: const Icon(Icons.arrow_back,color: Colors.white,),),
        title: const Text('Profile Page', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 54, 157, 75),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
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

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("User: ${_nameController.text}  ${_surnameController.text} ",
                                 style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                                 ),
                                 ElevatedButton( 
                                    
                                      onPressed: (){goToNavigation(context);},
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: const Size(1,40), 
                                        backgroundColor: const Color.fromARGB(255, 54, 157, 75),
                                      
                                      ),
                                      child: const Center(
                                        child: Icon(
                                          Icons.notifications_active, color: Colors.white,),
                                      ),
                                      ),                            ],
                            ),
                            const SizedBox(height: 5,),
                  FormContainerWidget(
                    hintText: "Name",
                    isPasswordField: false,
                    controller: _nameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your Name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  FormContainerWidget(
                    hintText: "Surname",
                    isPasswordField: false,
                    controller: _surnameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your Surname';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  FormContainerWidget(
                    hintText: "Email",
                    isPasswordField: false,
                    controller: _emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email address';
                      }
                      if (!value.contains('@')) {
                        return 'Should contain \'@\' character';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  FormContainerWidget(
                    hintText: "ID number",
                    isPasswordField: false,
                    controller: _idController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your ID number';
                      }
                      if (value.length != 13) {
                        return 'Number must be 13 digits';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  FormContainerWidget(
                    hintText: "Date of Birth",
                    isPasswordField: false,
                    controller: _dateOfBirthController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your Date of Birth';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  FormContainerWidget(
                    hintText: "Contact no.",
                    isPasswordField: false,
                    controller: _contactsController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your Contact number';
                      }
                      if (value.length != 10) {
                        return 'Number must be 10 digits';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  FormContainerWidget(
                    hintText: "Password",
                    isPasswordField: true,
                    controller: _passwordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 8 || !value.contains('@')) {
                        return 'Password must be at least 8 characters and contain \'@\' character';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    icon:  const Icon(
                  Icons.update,
                  color: Colors.white,),
                    onPressed: _updateUserProfile,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 40),
                      backgroundColor: const Color.fromARGB(255, 54, 157, 75),
                    ),
                    label: const Text(
                      'Update Profile',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  goToNavigation(BuildContext context) => Navigator.of(context).pushNamedAndRemoveUntil(RouteManager.notificationPage,(route)=>false);
}
