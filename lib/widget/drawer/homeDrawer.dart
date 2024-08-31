import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rideshare/bloc/Login/AuthBlocLogin.dart';
import 'package:rideshare/bloc/wallet/wallet_bloc.dart';
import 'package:rideshare/bloc/wallet/wallet_event.dart';
import 'package:rideshare/bloc/wallet/wallet_state.dart';
import 'package:rideshare/new/pages/login/login.dart';
import 'package:rideshare/pages/policys/policyScreen.dart';
import 'package:rideshare/pages/wallet/createNewWallet/createWalletScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';

final GetIt sl = GetIt.instance;

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authBloc = sl<AuthBlocLogin>(); // Using GetIt for AuthBlocLogin
    final token = authBloc.authToken;

    return ClipRRect(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(80),
        bottomRight: Radius.circular(80),
      ),
      child: Drawer(
        backgroundColor: Colors.white,
        width: MediaQuery.of(context).size.width * .6,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with gradient background and profile
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/images/splash/Shape.png'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'John Doe', // Replace with dynamic user data if available
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
            SizedBox(height: 30),
            // Drawer menu items
            _buildDrawerItem(
              context,
              icon: Icons.wallet,
              text: 'My Wallet',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WalletView()),
                );
              },
            ),
            _buildDivider(),
            _buildDrawerItem(
              context,
              icon: Icons.report_problem,
              text: 'My Statistics',
              onTap: () {
                // Navigate to Statistics Screen
              },
            ),
            _buildDivider(),
            _buildDrawerItem(
              context,
              icon: Icons.card_giftcard,
              text: 'Invite Friends',
              onTap: () {
                // Navigate to Invite Friends Screen
              },
            ),
            _buildDivider(),
            _buildDrawerItem(
              context,
              icon: Icons.info,
              text: 'Support',
              onTap: () {
                // Navigate to Support Screen
              },
            ),
            _buildDivider(),
            _buildDrawerItem(
              context,
              icon: Icons.settings,
              text: 'Settings',
              onTap: () {
                // Navigate to Settings Screen
              },
            ),
            _buildDivider(),
            _buildDrawerItem(
              context,
              icon: Icons.help,
              text: 'Privacy Policy',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PolicyScreen()),
                );
              },
            ),
            _buildDivider(),
            Spacer(),
            // Logout item
            _buildDrawerItem(
              context,
              icon: Icons.exit_to_app,
              text: 'Logout',
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

  Widget _buildDrawerItem(BuildContext context, {required IconData icon, required String text, required GestureTapCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(
        text,
        style: TextStyle(
          color: Colors.black,
          fontFamily: 'Poppins',
        ),
      ),
      onTap: onTap,
    );
  }

  Widget _buildDivider() {
    return Divider(color: Colors.grey);
  }

  Widget _buildWalletBalance(BuildContext context, String? token) {
    if (token == null) {
      return Text(
        '\$0.00',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ); // Fallback balance if not loaded
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
            return Text(
              '\$0.00',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ); // Fallback balance if not loaded
          }
        },
      ),
    );
  }
}
