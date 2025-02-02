


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:service_pal/layout/botnav_user.dart';

class profile_user extends StatefulWidget {
  const profile_user({Key? key}) : super(key: key);

  @override
  _profile_userState createState() => _profile_userState();
}

class _profile_userState extends State<profile_user> {
  bool isEditing = false;
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController addressController;
  late TextEditingController phoneController;
  late TextEditingController locationController;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    emailController = TextEditingController();
    addressController = TextEditingController();
    phoneController = TextEditingController();
    locationController = TextEditingController();
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    addressController.dispose();
    phoneController.dispose();
    locationController.dispose();
    super.dispose();
  }

  // Function to update profile data in Firestore
  void updateProfile() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        // Update user data in Firestore
        await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
          'username': usernameController.text,
          'email': emailController.text,
          'address': addressController.text,
          'phone': phoneController.text,
          'location': locationController.text,
        });

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Profile updated successfully!"),
        ));

        setState(() {
          isEditing = false; // Set back to view mode after update
        });
      } catch (e) {
        print("Error updating profile: $e");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Error updating profile. Please try again."),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Scaffold(
        body: Center(child: Text("You are not logged in")),
      );
    }

    return Scaffold(
      backgroundColor: Colors.blue[50],
       bottomNavigationBar: botnav_user(),
      appBar: AppBar(
        title: Text("My Profile",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: Icon(isEditing ? Icons.save : Icons.edit),
            onPressed: () {
              if (isEditing) {
                updateProfile(); // Save the changes if editing
              } else {
                setState(() {
                  isEditing = true; // Switch to edit mode
                });
              }
            },
          ),
        ],
         iconTheme: IconThemeData(color: Colors.white),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('users').doc(user.uid).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text("No data found"));
          }

          var userData = snapshot.data!;

          // Initialize the controllers with existing data
          usernameController.text = userData['username'] ?? "N/A";
          emailController.text = userData['email'] ?? "N/A";
          addressController.text = userData['address'] ?? "N/A";
          phoneController.text = userData['phone'] ?? "N/A";
          locationController.text = userData['location'] ?? "N/A";

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.blueAccent,
                  child: Icon(Icons.person, size: 50, color: Colors.white),
                ),
                SizedBox(height: 20),
                buildProfileTile(Icons.person, "Username", usernameController, isEditing),
                buildProfileTile(Icons.email, "Email", emailController, isEditing),
                buildProfileTile(Icons.home, "Address", addressController, isEditing),
                buildProfileTile(Icons.phone, "Phone", phoneController, isEditing),
                buildProfileTile(Icons.location_on, "Location", locationController, isEditing),
              ],
            ),
          );
        },
      ),
       
    );
  }

  // Helper function to build profile tiles
  Widget buildProfileTile(IconData icon, String title, TextEditingController controller, bool isEditing) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      child: ListTile(
        leading: Icon(icon, color: Colors.blueAccent),
        title: Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        subtitle: isEditing
            ? TextFormField(
                controller: controller,
                decoration: InputDecoration(border: InputBorder.none),
              )
            : Text(controller.text, style: TextStyle(fontSize: 14)),
      ),
    );
  }
}
