import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hospital_management_app/features/user_auth/Presentation/widgets/form_container_widget.dart';
import 'package:hospital_management_app/features/user_auth/Presentation/widgets/providerclass.dart';
import 'package:provider/provider.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({super.key});

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  late TextEditingController reasonController;
  late TextEditingController dateController;
  late TextEditingController timeController;
  late TextEditingController patientNameController;
  //DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    reasonController = TextEditingController();
    dateController = TextEditingController();
    timeController = TextEditingController();
    patientNameController = TextEditingController();
  }

  @override
  void dispose() {
    reasonController.dispose();
    dateController.dispose();
    timeController.dispose();
    patientNameController.dispose();
    super.dispose();
  }

  DateTime dateTime = DateTime(2024, 12, 31, 5, 30);

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context);
    final hours = dateTime.hour.toString().padLeft(2, '0');
    final minutes = dateTime.minute.toString().padLeft(2, '0');
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 152, 241, 170),
      appBar: AppBar(
        title: const Text("Appointment Page", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 54, 157, 75),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Full Name: ${userData.name} ${userData.surname}"),
                const SizedBox(height: 40),
                const Text("Select a date for Appointment:"),
                const SizedBox(height: 20),
                  FormContainerWidget(
                    controller: patientNameController,
                    hintText:"Patient Name"
                      
                    ),
                    const SizedBox(height: 10,),
                    const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text("Select Date"),
                      SizedBox( width: 80,),
                      Text("Select Time"),
                    ],),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  
                  SizedBox(
                    width: 130,
                    
                    child: TextFormField(
                      
                      controller: dateController,
                      decoration: InputDecoration(
                        labelText: 'Select Date',
                        suffixIcon: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 40),
                            backgroundColor: const Color.fromARGB(255, 54, 157, 75),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () async {
                            final date = await pickDate();
                            if (date == null) return;

                            final newDateTime = DateTime(
                              date.year,
                              date.month,
                              date.day,
                              dateTime.hour,
                              dateTime.minute,
                            );
                            dateController.text = "${newDateTime.year}/${newDateTime.month}/${newDateTime.day}";
                            setState(() => dateTime = newDateTime);
                          },
                          child:  const Text(
                            "Pick Date",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 30),
                  SizedBox(
                    width: 130,
                    child: TextFormField(
                      controller: timeController,
                      decoration: InputDecoration(
                        labelText: 'Select Time',
                        suffixIcon: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 40),
                            backgroundColor: const Color.fromARGB(255, 54, 157, 75),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () async {
                            final time = await pickTime();
                            if (time == null) return;

                            final newDateTime = DateTime(
                              dateTime.year,
                              dateTime.month,
                              dateTime.day,
                              time.hour,
                              time.minute,
                            );
                            timeController.text = "$hours:$minutes";
                            setState(() => dateTime = newDateTime);
                          },
                          child: const Text(
                            "Pick Time",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
                const SizedBox(height: 50),
                const Text("Provide a reason for booking an Appointment:"),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FormContainerWidget(
                    controller: reasonController,
                    hintText:"Reasons"
                      
                    ),
                ),
                const SizedBox(height: 40),
                Center(
                  child: SizedBox(
                    height: 40,
                    width: 150,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 40),
                        backgroundColor: const Color.fromARGB(255, 54, 157, 75),
                        shape:  RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        _submit();
                        final snackBar = SnackBar(
                          content: Text(
                            "${userData.name} ${userData.surname} your appointment for ${dateController.text} at ${timeController.text} has been received",
                            style: const TextStyle(color: Colors.white),
                          ),
                          duration: const Duration(seconds: 7),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      child: const Text(
                        "Submit",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _submit() async {
    try 
      {
              // Collects user data from SignUp Form
               DocumentReference docRef = FirebaseFirestore.instance.collection('appointment').doc();

                  // Set the review data in Firestore
                  await docRef.set({
                    'uid': docRef.id,
                    'patientName': patientNameController.text, // Save the generated document ID
                    'reason': reasonController.text,
                    'date': dateController.text,
                    'time': timeController.text,
                    
                  });
          } catch (e) 
          {
            log("Error: $e");
            // ignore: use_build_context_synchronously
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error creating appointment: $e')),
          );
        }
         log("Submitted Successfully");

    
  }

  Future<DateTime?> pickDate() => showDatePicker(
        context: context,
        initialDate: dateTime,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100),
      );

  Future<TimeOfDay?> pickTime() => showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute),
      );
}
