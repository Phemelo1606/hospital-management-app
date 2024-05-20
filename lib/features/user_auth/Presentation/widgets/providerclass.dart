import 'package:flutter/material.dart';

class UserData extends ChangeNotifier{
  String _name ="";
  String _surname = " ";
  String _email ="";
   
   
  String get email => _email;
  String get name => _name;
  String get surname => _surname;

  void setUserData(String newName, String newSurname, String newEmail) 
  {
    _name = newName;
    _surname =newSurname;
    _email = newEmail;
    notifyListeners();

  }

  

}

