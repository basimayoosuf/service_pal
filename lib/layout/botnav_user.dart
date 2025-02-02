

import 'package:flutter/material.dart';

class botnav_user extends StatefulWidget {
  const botnav_user({Key? key}) : super(key: key);

  @override
  State<botnav_user> createState() => _botnav_userState();
}

class _botnav_userState extends State<botnav_user> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _currentIndex,
      onTap: (value) {
        
        setState(() {

          
          _currentIndex = value;
          print(_currentIndex);
          if(_currentIndex==0)
          {
            // Navigator.pop(context);
            Navigator.pushNamed(context, '/main');
          }
          else if(_currentIndex==1)
          {
            // Navigator.pop(context);
            Navigator.pushNamed(context, '/viewservice');
          }
          else if(_currentIndex==2)
          {
            // Navigator.pop(context);
            Navigator.pushNamed(context, '/mybooking');
          }
          else if(_currentIndex==3)
          {
            // Navigator.pop(context);
            Navigator.pushNamed(context, '/profile_user');
          }
          
        });

      },
      items: [
        BottomNavigationBarItem(
          label: 'Home',

          icon: Icon(Icons.home),
        ),
        BottomNavigationBarItem(
          label: 'Services',

          icon: Icon(Icons.build_circle),
        ),
        BottomNavigationBarItem(
          label: 'My Booking',
          icon: Icon(Icons.book_online),
        ),
        BottomNavigationBarItem(
          label: ' Profile',
          icon: Icon(Icons.person),
        ),
        // 
      ],
    );
  }
}



