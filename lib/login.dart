import 'package:flutter/material.dart';
import 'package:medical_store/bottam.dart';
import 'package:medical_store/home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var email = "email@gmail.com";
  var emailFocus = FocusNode();
  var passFocus = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Login",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 10),
            TextField(
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              controller: emailController,
              focusNode: emailFocus,
              decoration: InputDecoration(
                hintText: "E-mail",
                labelText: "Enter your name",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),

            TextField(
              controller: passwordController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.number,
              focusNode: passFocus,
              decoration: InputDecoration(
                hintText: "Password",
                labelText: "Enter your Password",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                    maximumSize: Size(double.infinity, 50),
                  ),
                  onPressed: () {
                    if (emailController.text.toString() == "Admin" &&
                        passwordController.text.toString() == "123456") {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text("Thankyou Admin")));

                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => Bottam()),
                        (Route<dynamic> route) => false,
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Wrong user Name and Password")),
                      );
                    }
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
