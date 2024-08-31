import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rideshare/bloc/Login/AuthBlocLogin.dart';
import 'package:rideshare/bloc/wallet/wallet_bloc.dart';
import 'package:rideshare/bloc/wallet/wallet_event.dart';
import 'package:rideshare/bloc/wallet/wallet_state.dart';
import 'package:rideshare/config/serviceLocater.dart';
import 'package:rideshare/new/pages/login/login.dart';
import 'package:rideshare/pages/wallet/createNewWallet/createWalletScreen.dart';
import 'package:rideshare/pages/changePassword/changePasswordScreen.dart'; // Import ChangePasswordScreen
import 'package:rideshare/pages/policys/policyScreen.dart'; // Import PolicyScreen
import 'package:shared_preferences/shared_preferences.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final token = sl<AuthBlocLogin>().authToken;

    return ClipRRect(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(80),
        bottomRight: Radius.circular(80),
      ),
      child: Drawer(
        backgroundColor: Colors.white,
        width: MediaQuery.of(context).size.width * .6,
        child: Column(
          children: [
            // Profile section with a gradient background
            Container(
              width: 300,
              padding: const EdgeInsets.symmetric(vertical: 40),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF009EFD), Color(0xFF2AF598)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/images/splash/Shape.png'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'John Doe',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  if (token != null) _buildWalletBalance(context, token),
                ],
              ),
            ),
            // Drawer items
            ListTile(
              title: Text('My Wallet'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WalletView()),
                );
              },
            ),
            ListTile(
              title: Text('Change Password'), // Change Password Option
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChangePasswordScreen()), // Navigate to ChangePasswordScreen
                );
              },
            ),
            ListTile(
              title: Text('Privacy Policy'), // Privacy Policy Option
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PolicyScreen()), // Navigate to PolicyScreen
                );
              },
            ),
            ListTile(
              title: Text('My Statistics'),
              onTap: () {
                // Navigate to Statistics Screen
              },
            ),
            ListTile(
              title: Text('Invite Friends'),
              onTap: () {
                // Navigate to Invite Friends Screen
              },
            ),
            ListTile(
              title: Text('Support'),
              onTap: () {
                // Navigate to Support Screen
              },
            ),
            ListTile(
              title: Text('Settings'),
              onTap: () {
                // Navigate to Settings Screen
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Log Out'),
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.clear(); // Clear all preferences
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginSignupScreen()),
                      (route) => false,
                ); // Navigate to LoginSignupScreen
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWalletBalance(BuildContext context, String? token) {
    if (token == null) {
      return Text('\$0.00',
          style: TextStyle(
              color: Colors.white)); // Fallback balance if not loaded
    }
    return BlocProvider(
      create: (context) => sl<WalletBloc>()..add(FetchWalletEvent(token: token)),
      child: BlocBuilder<WalletBloc, WalletState>(
        builder: (context, state) {
          if (state is WalletLoaded) {
            return Text(
              '\$${state.wallet.balance}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            );
          } else if (state is WalletLoading) {
            return CircularProgressIndicator();
          } else {
            return Text('\$0.00',
                style: TextStyle(
                    color: Colors.white)); // Fallback balance if not loaded
          }
        },
      ),
    );
  }
}
