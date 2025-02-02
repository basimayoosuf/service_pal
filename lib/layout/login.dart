import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:service_pal/Firebase/firebase_functions.dart';
import 'package:service_pal/layout/homescreen_user.dart';
import 'package:service_pal/layout/userreg.dart';

import 'package:http/http.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
  static var url = "";
  static var uid = "";
}

class _loginState extends State<login> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  late TextEditingController USER_NAME, PASSWORD;
  bool _passwordVisible = true;
  var data = [];
  @override
  void initState() {
    USER_NAME = TextEditingController();
    PASSWORD = TextEditingController();
    super.initState();
  }

  void showCustomDialog(BuildContext context,
      {String message = "You have successfully logged in"}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Login Status",
              style: TextStyle(fontWeight: FontWeight.bold)),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void postdata() async {
    var url = Uri.parse(login.url + "login/asdf/");
    Response resp = await post(url, body: {
      "username": USER_NAME.text,
      "password": PASSWORD.text,
    });
    data = jsonDecode(resp.body);
    if (data.length > 0) {
      login.uid = data[0]['u_id'].toString();
      if (data[0]['type'] == "user") {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (BuildContext) => homescreen_user()));
        showCustomDialog(context);
      }
      // if(data[0]['type']=="artist"  && data[0]['status']=="approved")
      // {
      //   Navigator.of(context).push(MaterialPageRoute(
      //     builder:(BuildContext)=> home_user()));
      //     showCustomDialog(context);
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.pinkAccent,title: Text('Login'),
      // ),
      body: Container(
        decoration: BoxDecoration(
          // image: DecorationImage(
          //   image: AssetImage('assets/hh.jpg'),
          //   fit: BoxFit.cover,
          //    ),
          gradient: LinearGradient(
            colors: [Colors.white, Colors.lightBlueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
            child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: const Text(
                    'HandyPro',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight
                          .w600, // Slightly bolder than FontWeight.bold
                      fontStyle: FontStyle.normal, // Makes the text italic
                      color: Colors.blueAccent,
                    ),
                  ),
                  
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(90, 10, 90, 0),
                  child: TextFormField(
                    validator: (value) => USER_NAME.text.trim().isEmpty
                        ? "This field is required."
                        : null,
                    controller: USER_NAME,
                    decoration: InputDecoration(
                        labelText: "Email",
                        hintText: "Enter your Email",
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(90, 10, 90, 0),
                  child: TextFormField(
                    validator: (value) => PASSWORD.text.trim().isEmpty
                        ? "This field is required."
                        : null,
                    obscureText: _passwordVisible,
                    controller: PASSWORD,
                    decoration: InputDecoration(
                        labelText: "Password",
                        hintText: "Password",
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(90, 10, 90, 0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        FirebaseFunctions.loginUser(context,
                            USER_NAME.text.trim(), PASSWORD.text.trim());
                      }
                      // postdata();
                      // Navigator.of(context).push(MaterialPageRoute(builder:(BuildContext context) => login()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            120), // Adjust this value for more or less curve
                      ),
                      foregroundColor:
                          Colors.white, // Change the text color here
                    ),
                    child: Text("LOGIN"),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(30, 20, 30, 30),
                  child: Column(
                    children: [
                      // Row with "Do you have an account?" and the Register button
                      Row(
                        mainAxisAlignment: MainAxisAlignment
                            .center, // Center the row's contents
                        children: [
                          // Text "Do you have an account?"
                          Text(
                            "Don't have an account?",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors
                                  .black54, // Customize this color as needed
                            ),
                          ),
                          SizedBox(
                              width:
                                  10), // Spacing between the text and the button

                          // Register button styled like a link
                          TextButton(
                            onPressed: () {
                              // postdata();
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) => userreg()));
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: Color.fromARGB(
                                  223, 26, 158, 163), //Text color (link-like)
                              textStyle: TextStyle(
                                fontSize: 14, // Adjust text size if needed
                                fontWeight:
                                    FontWeight.bold, // Optional: make it bold
                                decoration: TextDecoration
                                    .underline, // Underline to resemble a link
                              ),
                            ),
                            child: Text("REGISTER"),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}
