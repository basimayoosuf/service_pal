
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class mybooking extends StatefulWidget {
//   const mybooking({Key? key}) : super(key: key);

//   @override
//   _mybookingState createState() => _mybookingState();
// }

// class _mybookingState extends State<mybooking> {
//   // Get the current user
//   User? user = FirebaseAuth.instance.currentUser;

//   // Fetch all bookings for the current user
//   Future<List<DocumentSnapshot>> getBookings() async {
//     // Check if the user is logged in
//     if (user != null) {
//       // Query Firestore to fetch the user's bookings
//       QuerySnapshot snapshot = await FirebaseFirestore.instance
//           .collection('bookings')
//           .where('uid', isEqualTo: user!.uid)
//           .get();
//       return snapshot.docs;
//     }
//     return [];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blueAccent,
//         title: Text(
//           'My Bookings',
//           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
//         ),
//         iconTheme: IconThemeData(color: Colors.white),
//       ),
//       body: FutureBuilder<List<DocumentSnapshot>>(
//         future: getBookings(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
      
//           if (snapshot.hasError) {
//             return Center(child: Text('Something went wrong, please try again later.'));
//           }
      
//           if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text('No bookings found.'));
//           }
      
//           // Get the list of bookings from the snapshot
//           List<DocumentSnapshot> bookings = snapshot.data!;
      
//           return SingleChildScrollView(
//             child: ListView.builder(
//               itemCount: bookings.length,
//               itemBuilder: (context, index) {
//                 var booking = bookings[index].data() as Map<String, dynamic>;
//                 return Card(
//                   margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//                   elevation: 5,
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Booking Details
//                         Text('Service ID: ${booking['sid']}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//                         SizedBox(height: 10),
//                         Text('Date: ${booking['date']}', style: TextStyle(fontSize: 14)),
//                         SizedBox(height: 5),
//                         Text('Time: ${booking['time']}', style: TextStyle(fontSize: 14)),
//                         SizedBox(height: 5),
//                         Text('Location: ${booking['location']}', style: TextStyle(fontSize: 14)),
//                         SizedBox(height: 5),
//                         Text('Phone: ${booking['phone']}', style: TextStyle(fontSize: 14)),
//                         SizedBox(height: 5),
//                         Text('Description: ${booking['description']}', style: TextStyle(fontSize: 14)),
//                         SizedBox(height: 10),
//                         Row(
//                           children: [
//                             Text('Status: ', style: TextStyle(fontWeight: FontWeight.bold)),
//                             Text(booking['status'], style: TextStyle(color: booking['status'] == 'pending' ? Colors.orange : Colors.green)),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           );
//         },
//       ),
       
//     );
//   }
// }









import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:service_pal/layout/botnav_user.dart';

class mybooking extends StatefulWidget {
  const mybooking({Key? key}) : super(key: key);

  @override
  _mybookingState createState() => _mybookingState();
}

class _mybookingState extends State<mybooking> {
  // Get the current user
  User? user = FirebaseAuth.instance.currentUser;

  // Fetch all bookings for the current user
  Future<List<DocumentSnapshot>> getBookings() async {
    // Check if the user is logged in
    if (user != null) {
      // Query Firestore to fetch the user's bookings
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('bookings')
          .where('uid', isEqualTo: user!.uid)
          .get();
      return snapshot.docs;
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
       bottomNavigationBar: botnav_user(),
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(
          'My Bookings',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: FutureBuilder<List<DocumentSnapshot>>(
        future: getBookings(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong, please try again later.'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No bookings found.'));
          }

          // Get the list of bookings from the snapshot
          List<DocumentSnapshot> bookings = snapshot.data!;

          return ListView.builder(
            itemCount: bookings.length,
            itemBuilder: (context, index) {
              var booking = bookings[index].data() as Map<String, dynamic>;

              // Add null checks to avoid the type error
              String sid = booking['sid'] ?? 'N/A';
              String date = booking['date'] ?? 'N/A';
              String time = booking['time'] ?? 'N/A';
              String location = booking['location'] ?? 'N/A';
              String phone = booking['phone'] ?? 'N/A';
              String description = booking['description'] ?? 'No description';
              String status = booking['status'] ?? 'Unknown';

              return Card(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                elevation: 5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Booking Details
                      Text('Service ID: $sid', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      SizedBox(height: 10),
                      Text('Date: $date', style: TextStyle(fontSize: 14)),
                      SizedBox(height: 5),
                      Text('Time: $time', style: TextStyle(fontSize: 14)),
                      SizedBox(height: 5),
                      Text('Location: $location', style: TextStyle(fontSize: 14)),
                      SizedBox(height: 5),
                      Text('Phone: $phone', style: TextStyle(fontSize: 14)),
                      SizedBox(height: 5),
                      Text('Description: $description', style: TextStyle(fontSize: 14)),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text('Status: ', style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(status, style: TextStyle(color: status == 'pending' ? Colors.orange : Colors.green)),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}


