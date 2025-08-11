import 'package:flutter/material.dart';

class Totalmedicin extends StatefulWidget {
  const Totalmedicin({super.key});

  @override
  State<Totalmedicin> createState() => _TotalmedicinState();
}

class _TotalmedicinState extends State<Totalmedicin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Medicin"), backgroundColor: Colors.blueGrey),
      body: ListView(
        children: [
          
          ListTile(
            onTap: () {},
            leading: Icon(Icons.mediation),

            title: Text("Analgesics"),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.medication),
            onTap: () {},
            title: Text("Antibiotics"),
          ),
          
        ],
        
      ),
    );
  }
}