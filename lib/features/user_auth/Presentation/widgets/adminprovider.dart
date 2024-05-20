import 'package:flutter/material.dart';

class AdminData extends ChangeNotifier{
 
  String _email ="";
   
   
  String get email => _email;
 

  void setAdminData( String newEmail) 
  {
   
    _email = newEmail;
    notifyListeners();

  }

  

}