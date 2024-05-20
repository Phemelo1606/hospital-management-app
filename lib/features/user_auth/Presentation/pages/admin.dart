import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hospital_management_app/features/user_auth/Presentation/widgets/adminprovider.dart';
import 'package:hospital_management_app/features/user_auth/auth_service.dart';
import 'package:hospital_management_app/routes/routes.dart';
import 'package:provider/provider.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final _auth = AuthServices();
  bool showAppointments = true;

  @override
  Widget build(BuildContext context) {
    final adminData = Provider.of<AdminData>(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 152, 241, 170),
      appBar: AppBar(
        title: const Text('Admin Page', style: TextStyle(color: Colors.white,),),
        backgroundColor: const Color.fromARGB(255, 54, 157, 75),
      ),
      body: Column(
        children: [
          const Icon(
                    Icons.account_circle,
                    size: 100,
                    color: Color.fromARGB(255, 54, 157, 75),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                   Text(
                    'Admin: ${adminData.email}',
                    style:const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      showAppointments = true;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                         
                        backgroundColor: const Color.fromARGB(255, 54, 157, 75),
                        
                      ),
                  child: const Text('View Appointments',style: TextStyle(color: Colors.white),),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      showAppointments = false;
                    });
                    
                  },
                   style: ElevatedButton.styleFrom(
                         
                        backgroundColor: const Color.fromARGB(255, 54, 157, 75),
                        
                      ),
                  child: const Text('View Reviews',style: TextStyle(color: Colors.white),),
                ),
              ],
            ),
          ),
         
          Expanded(
            child: showAppointments ? _buildAppointmentsList() : _buildReviewsList(),
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
                goToSignUp(context);

              },
              child: const Text("Logout",style: TextStyle(color: Colors.white),),
            ),
          ),
          const SizedBox(height: 30,)
        ],
      ),
    );
  }
  goToSignUp(BuildContext context) => Navigator.of(context).pushNamedAndRemoveUntil(RouteManager.signUpPage,(route)=>false);

  Widget _buildAppointmentsList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('appointment').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        var appointments = snapshot.data!.docs;

        return ListView.builder(
          itemCount: appointments.length,
          itemBuilder: (context, index) {
            var appointment = appointments[index];
            var data = appointment.data() as Map<String, dynamic>?;

            if (data == null) {
              return const ListTile(
                title: Text('Invalid Appointment Data'),
              );
            }

            return ListTile(
              title: Text('Appointment with ${data['patientName']}'),
              subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Reason: ${data['reason']} ',),
                Text('Date: ${data['date']} ${data['time']} ', ),
              ],) ,
              
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  _deleteAppointment(appointment.id);
                },
              ),
              
            );
          },
        );
      },
    );
  }

  Widget _buildReviewsList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('reviews').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        var reviews = snapshot.data!.docs;

        return ListView.builder(
          itemCount: reviews.length,
          itemBuilder: (context, index) {
            var review = reviews[index];
            var data = review.data() as Map<String, dynamic>?;

            if (data == null) {
              return const ListTile(
                title: Text('Invalid Review Data'),
              );
            }

            String hospitalName = data['hospital name'] ?? 'Unknown Hospital';
            String reviewText = data['review'] ?? 'No review available';

            return ListTile(
              title: Text('Hospital name: $hospitalName'),
              subtitle: Text(reviewText),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  _deleteReview(review.id);
                },
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _deleteAppointment(String id) async {
    await FirebaseFirestore.instance.collection('appointment').doc(id).delete();
  }

  Future<void> _deleteReview(String id) async {
    await FirebaseFirestore.instance.collection('reviews').doc(id).delete();
  }
}
