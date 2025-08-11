import 'package:flutter/material.dart';
import 'package:medical_store/home.dart';
import 'package:medical_store/profile.dart';

class Bottam extends StatefulWidget {
  const Bottam({super.key});

  @override
  State<Bottam> createState() => _BottomnavscreenState();
}

class _BottomnavscreenState extends State<Bottam> {
  int selected = 0;

  var list = [Home(), Profile()];

  @override
  void initState() {
    super.initState();

    print("Check Value: $selected");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: list[selected],

      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],

        onTap: (value) {
          selected = value;
          setState(() {});
        },
      ),
    );
  }
}
