import 'package:flutter/material.dart';
import 'package:pathly/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Stripe.publishableKey =
      "pk_test_51RH2bBIgCCjsMlEkgCPZdYr1Mxu25fvapVo09dkY10KhKQw9YQFIpR9lBNWXqTHVctWMunhL1infFeiS9wY4RX6q00JjSbiuro";
  runApp(const Pathly());
}
