

import 'package:flutter/material.dart';
import 'package:service_pal/layout/booknow.dart';
import 'package:service_pal/layout/botnav_user.dart';  // Assuming this is the navigation bar you are using

void main() {
  runApp(viewservice());
}

class viewservice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ServiceScreen(),
    );
  }
}

class ServiceScreen extends StatelessWidget {
  // Define the service descriptions and icons
  final Map<String, String> serviceDescriptions = {
    "Appliance Repair": "Expert technicians for all home appliance repairs.",
    "Carpenter": "Professional carpentry services for furniture & fittings.",
    "Plumber": "Reliable plumbing solutions for your home & office.",
    "Electrician": "Certified electricians for wiring, repairs & installations.",
  };

  final Map<String, IconData> serviceIcons = {
    "Appliance Repair": Icons.build_circle,
    "Carpenter": Icons.handyman,
    "Plumber": Icons.plumbing,
    "Electrician": Icons.electrical_services,
  };

  // Navigation function to navigate to specific service page
  void navigateToServicePage(BuildContext context, String serviceName) {
    switch (serviceName) {
      case 'Plumber':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => profile_plumber()),
        );
        break;
      case 'Electrician':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => profile_electrician()),
        );
        break;
      case 'Appliance Repair':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => profile_appliance_repair()),
        );
        break;
      case 'Carpenter':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => profile_carpenter()),
        );
        break;
      default:
        // Handle any undefined service (optional)
        print('Service not defined');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: Column(
        children: [
          // Category Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Text(
              "Category",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 20),

          // List of service cards
          Expanded(
            child: Column(
              children: serviceIcons.entries.map((entry) {
                return ServiceCard(
                  serviceName: entry.key,
                  icon: entry.value,
                  onTap: navigateToServicePage,
                );
              }).toList(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: botnav_user(),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final String serviceName;
  final IconData icon;
  final Function(BuildContext, String) onTap;

  ServiceCard({required this.serviceName, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 3,
      child: Container(
        height: 100,
        child: ListTile(
          leading: Icon(icon, size: 40, color: Colors.blueAccent),
          title: Text(
            serviceName,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          onTap: () => onTap(context, serviceName), // Navigate to the page
        ),
      ),
    );
  }
}

// Profile page for Plumber
class profile_plumber extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      // appBar: AppBar(
      //   title: Text('Plumber'),
      // ),
      body: 
      SingleChildScrollView(
  child: Column(
          children: [
            // Category Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Text(
                "Plumber",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),
            
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Profile Image Section
              Center(
                child: CircleAvatar(
                  radius: 50,
                  child: Icon(Icons.person,color: Colors.blueAccent,size: 60,),
                  // backgroundImage: AssetImage('assets/plumber_profile.jpg'), // Replace with your image
                ),
              ),
              SizedBox(height: 20),
          
              // Name Section
              Center(
                child: Text(
                  'John Sebastian',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),
              Text(
               "Categories: Plumber,Electrician\nContact no:9856345699\nLocation:Vengara\nAvailability:10:00 am to 7:00 pm\nWorking Days:Monday-Saturday",
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
          
              // Rating Section
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star, color: Colors.yellow[700]),
                  Text(
                    "4.8/5 Rating",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              SizedBox(height: 10),
              // Book Now Button
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext  context)=>
                      booknow()));
                  // Navigate to booking page or handle booking action
                },
                child: Text('Book Now'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),

             SizedBox(height: 30,),

              Center(
                child: CircleAvatar(
                  radius: 50,
                  // backgroundImage: AssetImage('assets/plumber_profile.jpg'), // Replace with your image
                                    child: Icon(Icons.person,color: Colors.blueAccent,size: 60,),

                  
                ),
              ),
              SizedBox(height: 20),
          
              // Name Section
              Center(
                child: Text(
                  'Katrina Kaif',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),
              Text(
               "Categories: Plumber,Electrician\nContact no:9856345699\nLocation:Vengara\nAvailability:10:00 am to 7:00 pm\nWorking Days:Monday-Saturday",
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
          
              // Rating Section
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star, color: Colors.yellow[700]),
                  Text(
                    "4.8/5 Rating",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              SizedBox(height: 10),
          
          
              // Book Now Button
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext  context)=>
                      booknow()));
                  // Navigate to booking page or handle booking action
                },
                child: Text('Book Now'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
            ],
          
          
          
            
          
          
          ),
        ),
      ),
          ],
  ),
      ),
       bottomNavigationBar: botnav_user(),
    );
  }
}

// Profile page for Electrician
class profile_electrician extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      // appBar: AppBar(
      //   title: Text('Electrician'),
      // ),
      body:
      SingleChildScrollView(
  child: Column(
          children: [
            // Category Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Text(
                " Electrician",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),
            
       Padding(
        padding: const EdgeInsets.all(20.0),
        child:SingleChildScrollView(
        child: Column(
          children: [
            // Profile Image Section
            Center(
              child: CircleAvatar(
                radius: 50,
                  child: Icon(Icons.person,color: Colors.blueAccent,size: 60,),

              ),
            ),
            SizedBox(height: 20),

            // Name Section
            Center(
              child: Text(
                'Muhammed',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Categories: Plumber,Electrician\nContact no:9856345699\nLocation:Vengara\nAvailability:10:00 am to 7:00 pm\nWorking Days:Monday-Saturday",
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),

            // Rating Section
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.star, color: Colors.yellow[700]),
                Text(
                  "4.9/5 Rating",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            SizedBox(height: 10),

            // Book Now Button
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext  context)=>
                    booknow()));
                // Navigate to booking page or handle booking action
              },
              child: Text('Book Now'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),            SizedBox(height: 30,),

             // Profile Image Section
            Center(
              child: CircleAvatar(
                radius: 50,
                  child: Icon(Icons.person,color: Colors.blueAccent,size: 60,),

              ),
            ),
            SizedBox(height: 20),

            // Name Section
            Center(
              child: Text(
                'David',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Categories: Plumber,Electrician\nContact no:9856345699\nLocation:Vengara\nAvailability:10:00 am to 7:00 pm\nWorking Days:Monday-Saturday",
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),

            // Rating Section
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.star, color: Colors.yellow[700]),
                Text(
                  "4.9/5 Rating",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            SizedBox(height: 10),

            // Book Now Button
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext  context)=>
                    booknow()));
                // Navigate to booking page or handle booking action
              },
              child: Text('Book Now'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    ),
          ],
  ),
      ),
       bottomNavigationBar: botnav_user(),
    );
  }
}

// Profile page for Appliance Repair
class profile_appliance_repair extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      // appBar: AppBar(
      //   title: Text('Appliance Repair'),
      // ),
      body:
SingleChildScrollView(
  child: Column(
          children: [
            // Category Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Text(
                "Appliance Repair",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),
            
  
         Padding(
          padding: const EdgeInsets.all(20.0),
          child:Column(
            children: [
              // Profile Image Section
              Center(
                child: CircleAvatar(
                  radius: 50,   
                  child: Icon(Icons.person,color: Colors.blueAccent,size: 60,),
               
                ),
              ),
              SizedBox(height: 20),
          
              // Name Section
              Center(
                child: Text(
                  'Alice James',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),
              Text(
               "Categories: Appliance Repairing,Electrician\nContact no:9856345699\nLocation:Kottakkal\nAvailability:10:00 am to 7:00 pm\nWorking Days:Monday-Saturday",
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
          
              // Rating Section
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star, color: Colors.yellow[700]),
                  Text(
                    "4.6/5 Rating",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              SizedBox(height: 10),
          
              // Book Now Button
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext  context)=>
                      booknow()));
                  // Navigate to booking page or handle booking action
                },
                child: Text('Book Now'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: 30,),
              Center(
                child: CircleAvatar(
                  radius: 50,   
                  child: Icon(Icons.person,color: Colors.blueAccent,size: 60,),
               
                ),
              ),
              SizedBox(height: 20),
          
              // Name Section
              Center(
                child: Text(
                  'Fathima',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),
              Text(
               "Categories: Appliance Repairing,Electrician\nContact no:9856345699\nLocation:Kottakkal\nAvailability:10:00 am to 7:00 pm\nWorking Days:Monday-Saturday",
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
          
              // Rating Section
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star, color: Colors.yellow[700]),
                  Text(
                    "4.6/5 Rating",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              SizedBox(height: 10),
          
              // Book Now Button
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext  context)=>
                      booknow()));
                  // Navigate to booking page or handle booking action
                },
                child: Text('Book Now'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
            ],
          )
      ),
          ],
  ),
),
 bottomNavigationBar: botnav_user(),
    );
  }
}

// Profile page for Carpenter
class profile_carpenter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      // appBar: AppBar(
      //   title: Text('Carpenter'),
      // ),
      body:
      SingleChildScrollView(
  child: Column(
          children: [
            // Category Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Text(
                "Carpenter",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),
            
      
       Padding(
        padding: const EdgeInsets.all(20.0),
        child:SingleChildScrollView(

         child: Column(
          children: [
            // Profile Image Section
            Center(
              child: CircleAvatar(
                radius: 50,  
                 child: Icon(Icons.person,color: Colors.blueAccent,size: 60,),              

              ),
            ),
            SizedBox(height: 20),

            // Name Section
            Center(
              child: Text(
                'Lucas',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Categories: Carpenting,Plumbing\nContact no:9856345699\nLocation:Kottakkal\nAvailability:10:00 am to 7:00 pm\nWorking Days:Monday-Saturday",
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),

            // Rating Section
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.star, color: Colors.yellow[700]),
                Text(
                  "4.7/5 Rating",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            SizedBox(height: 10),

            // Book Now Button
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext  context)=>
                    booknow()));
                // Navigate to booking page or handle booking action
              },
              child: Text('Book Now'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
                        
            SizedBox(height: 30,),
             Center(
              child: CircleAvatar(
                radius: 50,  
                 child: Icon(Icons.person,color: Colors.blueAccent,size: 60,),              

              ),
            ),
            SizedBox(height: 20),

            // Name Section
            Center(
              child: Text(
                'Anusree',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Categories: Carpenting,Electrician\nContact no:9856345699\nLocation:Kottakkal\nAvailability:10:00 am to 7:00 pm\nWorking Days:Monday-Saturday",
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),

            // Rating Section
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.star, color: Colors.yellow[700]),
                Text(
                  "4.7/5 Rating",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            SizedBox(height: 10),

            // Book Now Button
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext  context)=>
                    booknow()));
                // Navigate to booking page or handle booking action
              },
              child: Text('Book Now'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    ),
          ],
  ),
    ),
     bottomNavigationBar: botnav_user(),
    );
      
      
  }
}
