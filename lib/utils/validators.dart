import 'package:flutter/material.dart';
import 'package:get/get.dart';

List validatePassword(String pass) {
  List<String> passErrors = [];

  if (pass.length < 6) {
    passErrors.add("6 characters");
  }
  if (!RegExp(r'[A-Z]').hasMatch(pass)) {
    passErrors.add("\none uppercase letter");
  }
  if (!RegExp(r'[a-z]').hasMatch(pass)) {
    passErrors.add("on lowercase letter");
  }
  if (!RegExp(r'[1-9]').hasMatch(pass)) {
    passErrors.add("one digit ('0'-'9')");
  }
  if (!RegExp(r'[!_@#$%^&*(),.?":{}|<>]').hasMatch(pass)) {
    passErrors.add("\none special character.");
  }
  return passErrors;
}

List validateUserName(String userName) {
  List<String> usernameErrors = [];
  if (userName.length < 3 || userName.length > 20) {
    usernameErrors.add("be 3-20 characters long\n");
  }
  if (!RegExp(r'[A-Za-z]').hasMatch(userName)) {
    usernameErrors.add("include at least one letter\n");
  }
  if (RegExp(r'[!_@#$%^&*(),.?":{}|<>]').hasMatch(userName)) {
    usernameErrors.add("contain only letters and numbers");
  }
  return usernameErrors;
}
