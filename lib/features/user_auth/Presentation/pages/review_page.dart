import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hospital_management_app/features/user_auth/Presentation/widgets/form_container_widget.dart';
import 'package:hospital_management_app/features/user_auth/Presentation/widgets/providerclass.dart';
import 'package:provider/provider.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage>
    with SingleTickerProviderStateMixin {
  TextEditingController hospitalNameController = TextEditingController();
  TextEditingController reviewsController = TextEditingController();
  

  @override
  Widget build(BuildContext context) {
  final userData = Provider.of<UserData>(context);  
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 152, 241, 170),
      appBar: AppBar(
        title: const Text("Review Page",style: TextStyle(color: Colors.white),),
        backgroundColor: const Color.fromARGB(255, 54, 157, 75),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Provide the name of the hospital you attended below:",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              FormContainerWidget(
                controller: hospitalNameController,
                hintText: "Hospital name",
                
              ),
              const SizedBox(
                height: 15,
              ),
              FormContainerWidget(
                controller: reviewsController,
                hintText:"Provide feedback or review",
                ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton.icon(
                icon:  const Icon(
                  Icons.send,
                  color: Colors.white,),
                  onPressed: () {submitreview();
                   final snackBar = SnackBar(
                      content: Text("${userData.name} ${userData.surname} you review is recieved"),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 40),
                      backgroundColor: const Color.fromARGB(255, 54, 157, 75),
                      
                    ),
                    
                  label: const Text("submit Reviews",style: TextStyle(color: Colors.white),))
            ],
          ),
        ),
      ),
    );
  }
  submitreview() async{

       try 
      {
              // Collects user data from SignUp Form
               DocumentReference docRef = FirebaseFirestore.instance.collection('reviews').doc();

                  // Set the review data in Firestore
                  await docRef.set({
                    'uid': docRef.id, // Save the generated document ID
                    'hospital name': hospitalNameController.text,
                    'review': reviewsController.text,
                    
                  });
          } catch (e) 
          {
            log("Error: $e");
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error creating review: $e')),
          );
        }
         log("Submitted Successfully");

  }

  

}
