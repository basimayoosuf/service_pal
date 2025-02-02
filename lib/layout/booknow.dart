import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:service_pal/layout/botnav_user.dart';
import 'package:service_pal/layout/login.dart';

class booknow extends StatefulWidget {
  const booknow({Key? key}) : super(key: key);

  @override
  State<booknow> createState() => _booknowState();
  static String sid = "";
}

class _booknowState extends State<booknow> {
  late TextEditingController date, time, location, phone, description;

  @override
  void initState() {
    date = TextEditingController();
    time = TextEditingController();
    location = TextEditingController();
    phone = TextEditingController();
    description = TextEditingController();
    super.initState();
  }

  // This function sends booking data to Firestore
  void postdata() async {
    try {
      // Getting the current user
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Create a document for the booking in Firestore
        await FirebaseFirestore.instance.collection('bookings').add({
          'uid': user.uid, // User ID of the current logged-in user
          'sid': booknow.sid, // Service ID passed
          'date': date.text.trim(),
          'time': time.text.trim(),
          'location': location.text.trim(),
          'phone': phone.text.trim(),
          'description': description.text.trim(),
          'createdAt': Timestamp.now(), // Time when the booking is created
          'status': 'pending'
        });

        // After adding the data, show a success message or navigate to another page
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Booking Successful"),
              content: Text("Your booking has been successfully submitted."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/viewservice'); // Close the dialog
                    // Navigator.pop(context); // Close the dialog
                    // Navigator.of(context).pushReplacement(MaterialPageRoute(
                    //   builder: (BuildContext context) => botnav_user(), // Redirect to the bottom nav or another page
                    // ));
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
      } else {
        // If no user is logged in, show an error
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text("You must be logged in to book a service."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/viewservice'); // Close the dialog
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      // Handle any errors during data submission
      print("Error submitting booking: $e");
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Failed to submit your booking. Please try again."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/viewservice'); // Close the dialog
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      bottomNavigationBar: botnav_user(),
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(
          'Book services',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildTextField(controller: date, label: 'Date', icon: Icons.date_range),
                _buildTextField(controller: time, label: 'Time', icon: Icons.timelapse),
                _buildTextField(controller: location, label: 'Location', icon: Icons.location_on),
                _buildTextField(controller: phone, label: 'Phone', icon: Icons.phone),
                _buildTextField(controller: description, label: 'Problem Description', icon: Icons.note),
                Container(
                  padding: EdgeInsets.fromLTRB(90, 0, 90, 0),
                  child: ElevatedButton(
                    onPressed: () {
                      postdata(); // Submit the booking data to Firestore
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      textStyle: TextStyle(fontSize: 18),
                    ),
                    child: Text("Book Now"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper function to build text fields
  Widget _buildTextField({required TextEditingController controller, required String label, required IconData icon}) {
    return Container(
      padding: EdgeInsets.fromLTRB(90, 10, 90, 10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}



