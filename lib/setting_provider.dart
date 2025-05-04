import 'package:flutter/material.dart';

class SettingProvider extends ChangeNotifier{
  nameValidator(String value){
    if(value.isEmpty){
      return "Enter your name";
    }
    else{
      return null;
    }
  }
  passwordValidator(value){
    if (value == null || value.isEmpty) {
      return 'Enter your password';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }
  emailValidator(value){
    if (value == null || value.trim().isEmpty) {
      return 'Enter your email';
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }
}