import 'package:flutter/material.dart';
import 'package:medical_store/DemoCheck.dart';
import 'package:medical_store/MedicineScreen.dart';
import 'package:medical_store/bottam.dart';
import 'package:medical_store/home.dart';
import 'package:medical_store/login.dart';
import 'package:medical_store/suppliersdetails.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: Bottam()
    );
  }
}
