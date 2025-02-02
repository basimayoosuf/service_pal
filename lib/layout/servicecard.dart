import 'package:flutter/material.dart';

class ServiceCard extends StatelessWidget {
  final String title;
  final IconData icon;

  ServiceCard(this.title, this.icon);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () {
          _showServiceDescriptionBottomSheet(context);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Colors.blueAccent),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _showServiceDescriptionBottomSheet(BuildContext context) {
    String description = '';

    // Define descriptions for each service
    if (title == 'Electrician') {
      description = 'Electricians handle electrical wiring, installations, and repairs.';
    } else if (title == 'Plumber') {
      description = 'Plumbers fix leaks, install pipes, and maintain water systems.';
    } else if (title == 'Appliance Repair') {
      description = 'Technicians repair household appliances like washing machines, refrigerators, etc.';
    } else if (title == 'Carpenter') {
      description = 'Carpenters work with wood to build and repair structures and furniture.';
    }

    // Show the bottom sheet with the description
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(description),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);  // Close the bottom sheet
                },
                child: Text('Close'),
              ),
            ],
          ),
        );
      },
    );
  }
}
