import 'package:flutter/material.dart';

class NewUserRegister{
  final String email;
  final String password;
  final String firstName;
  final String secondName;
  final String phoneNumber;
  final String role;

  NewUserRegister({ 
    @required this.email, 
    @required this.password,
    @required this.firstName,
    @required this.secondName,
    @required this.phoneNumber,
    this.role = "PASSENGER"
  });
}
