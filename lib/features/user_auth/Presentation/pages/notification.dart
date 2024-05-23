import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hospital_management_app/routes/routes.dart';


class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 152, 241, 170),
      appBar: AppBar(
        
        title: const Text('Notifications', style: TextStyle(color: Colors.white,),),
        backgroundColor: const Color.fromARGB(255, 54, 157, 75),

      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            
                    const SizedBox(
                      height: 10,
                    ),
            const IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  
                ],
              ),
            ),
           
            Expanded(
              child: _buildAppointmentsList() ,
            ),
             
            const SizedBox(height: 30,),
        
            SizedBox(
                  height: 40,
                  width: 200,
                  child: ElevatedButton.icon( icon:  const Icon(
                    Icons.arrow_back,
                    color: Colors.white,),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 40),
                      backgroundColor: const Color.fromARGB(255, 54, 157, 75),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      
                    ),
                    onPressed: () {
                       Navigator.of(context).popAndPushNamed(RouteManager.profilePage);
                    },
                    label: const Text("Back",style: TextStyle(color: Colors.white),),
                  ),
                ),
          ],
        ),
      ),
    );
  }
  

  Widget _buildAppointmentsList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('notifications').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        var notifications = snapshot.data!.docs;

        return ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            var notification = notifications[index];
            var data = notification.data() as Map<String, dynamic>?;

            if (data == null) {
              return const ListTile(
                title: Text('No Notifications'),
              );
            }

            return ListTile(
              title: Text(' ${data['notify']}'),
              
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  _deleteAppointment(notification.id);
                },
              ),
              
            );
          },
        );
      },
    );
  }

 

  Future<void> _deleteAppointment(String id) async {
    await FirebaseFirestore.instance.collection('notifications').doc(id).delete();
  }


}
