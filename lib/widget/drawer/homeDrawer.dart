import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(80),
        bottomRight: Radius.circular(80),
      ),

      child: Drawer(

        backgroundColor: Colors.white,
        width: MediaQuery.of(context).size.width * .6,
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {},
                child: Container(
                  width: MediaQuery.of(context).size.width * .2,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Icon(Icons.arrow_back_ios),
                      Text("Back")
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage:
                  NetworkImage('https://via.placeholder.com/150'),
                  backgroundColor: Colors.transparent,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey, width: 2),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Nate Samson",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "nate@email.com",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              ListTile(
                leading: Icon(Icons.history),
                title: Text('History'),
                onTap: () {},
              ),
              Divider(color: Colors.grey),
              ListTile(
                leading: Icon(Icons.report_problem),
                title: Text('Complain'),
                onTap: () {},
              ),
              Divider(color: Colors.grey),
              ListTile(
                leading: Icon(Icons.card_giftcard),
                title: Text('Referral'),
                onTap: () {},
              ),
              Divider(color: Colors.grey),
              ListTile(
                leading: Icon(Icons.info),
                title: Text('About Us'),
                onTap: () {},
              ),
              Divider(color: Colors.grey),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                onTap: () {},
              ),
              Divider(color: Colors.grey),
              ListTile(
                leading: Icon(Icons.help),
                title: Text('Help and Support'),
                onTap: () {},
              ),
              Divider(color: Colors.grey),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Logout'),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
