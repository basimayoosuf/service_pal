import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:service_pal/layout/login.dart';

class userreg extends StatefulWidget {
  const userreg({Key? key}) : super(key: key);

  @override
  State<userreg> createState() => _userregState();
}

class _userregState extends State<userreg> {
  late TextEditingController username, password, address, email, phone, location;

  @override
  void initState() {
    super.initState();
    username = TextEditingController();
    password = TextEditingController();
    address = TextEditingController();
    email = TextEditingController();
    phone = TextEditingController();
    location = TextEditingController();
  }

  // This method uses Firebase Auth for registration and stores user data in Firestore
  void postdata() async {
    try {
      // Register the user using Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text.toString(),
        password: password.text.toString(),
      );

      // After registration, store additional user details in Firestore
      User? user = userCredential.user;

      if (user != null) {
        // Add user details to Firestore
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'username': username.text.trim(),
          'email': email.text.trim(),
          'address': address.text.trim(),
          'phone': phone.text.trim(),
          'location': location.text.trim(),
          'createdAt': Timestamp.now(),
        });

        // If registration is successful, show success dialog
        showSuccessDialog(context);
      }
    } on FirebaseAuthException catch (e) {
      // If there is an error (e.g., weak password, invalid email), show error dialog
      showErrorDialog(context, e.message ?? "Registration failed");
    }
  }

  // Function to show the success dialog
  void showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Registration Successful", style: TextStyle(fontWeight: FontWeight.bold)),
          content: Text("Your registration was successful!"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (BuildContext context) => login(), // Redirect to login or another screen
                  ),
                );
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Function to show the error dialog
  void showErrorDialog(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Registration Failed", style: TextStyle(fontWeight: FontWeight.bold)),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('Register', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(90, 10, 90, 10),
                  child: TextFormField(
                    controller: username,
                    decoration: InputDecoration(
                      labelText: 'User name',
                      hintText: 'user name',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(90, 10, 90, 10),
                  child: TextFormField(
                    controller: password,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'password',
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    obscureText: true,
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(90, 10, 90, 10),
                  child: TextFormField(
                    controller: address,
                    decoration: InputDecoration(
                      labelText: 'Address',
                      hintText: 'address',
                      prefixIcon: Icon(Icons.home_filled),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(90, 10, 90, 10),
                  child: TextFormField(
                    controller: email,
                    decoration: InputDecoration(
                      labelText: 'E-mail',
                      hintText: 'e-mail',
                      prefixIcon: Icon(Icons.alternate_email),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(90, 10, 90, 10),
                  child: TextFormField(
                    controller: phone,
                    decoration: InputDecoration(
                      labelText: 'Phone',
                      hintText: 'phone',
                      prefixIcon: Icon(Icons.phone),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(90, 10, 90, 10),
                  child: TextFormField(
                    controller: location,
                    decoration: InputDecoration(
                      labelText: 'Location',
                      hintText: 'location',
                      prefixIcon: Icon(Icons.location_on),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(90, 0, 90, 0),
                  child: ElevatedButton(
                    onPressed: () {
                      postdata(); // Trigger registration when button is pressed
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      textStyle: TextStyle(fontSize: 18),
                    ),
                    child: Text("Register"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
