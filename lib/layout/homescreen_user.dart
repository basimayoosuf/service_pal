
import 'package:flutter/material.dart';
import 'package:service_pal/layout/botnav_user.dart';
import 'package:service_pal/layout/login.dart';
import 'servicecard.dart';  // Import the ServiceCard widget

void main() {
  runApp(homescreen_user());
}

class homescreen_user extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HandyPro",style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold,color: Colors.white),),
        
        
        backgroundColor: Colors.blueAccent,
        actions: [IconButton(onPressed: () => Navigator.pushNamed(context, '/'), icon: Icon(Icons.logout))],
          iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          // Banner Image
          Container(
            width: double.infinity,
            height: 300,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/image.png"), // Add your banner image in asset
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 10,),
          SizedBox(child: Text("Our Services",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),height: 30,),

          // Service Categories
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: EdgeInsets.all(10),
              children: [
                ServiceCard("Appliance Repair", Icons.build_circle),
                ServiceCard("Carpenter", Icons.handyman),
                ServiceCard("Plumber", Icons.plumbing),
                ServiceCard("Electrician", Icons.electrical_services),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: botnav_user(),
    );
  }
}


