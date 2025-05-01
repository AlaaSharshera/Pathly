import 'package:flutter/material.dart';
import 'package:pathly/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pathly/utils/api_keys.dart';
import 'firebase_options.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Stripe.publishableKey = ApiKeys.stripePuplishedKey;
  runApp(const Pathly());
}
