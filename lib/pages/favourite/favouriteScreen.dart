import 'package:flutter/material.dart';
import 'package:rideshare/pages/wallet/myWallet/walletScreen.dart';
import 'package:rideshare/widget/button/mainButton.dart';
import 'package:rideshare/widget/drawer/homeDrawer.dart';
import 'package:rideshare/widget/listTile/FavoriteListTile.dart';

class FavouriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favourite'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.green[100], // Light green background
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(
                Icons.menu,
                color: Colors.black, // Black icon color
              ),
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            FavouriteListItem(
              name: 'Office',
              address: '2972 Westheimer Rd, Santa Ana, Illinois 85486',
              onDelete: () {
                // Handle delete action
              },
            ),
            FavouriteListItem(
              name: 'Home',
              address: '2972 Westheimer Rd, Santa Ana, Illinois 85486',
              onDelete: () {
                // Handle delete action
              },
            ),
            FavouriteListItem(
              name: 'Office',
              address: '2972 Westheimer Rd, Santa Ana, Illinois 85486',
              onDelete: () {
                // Handle delete action
              },
            ),
            FavouriteListItem(
              name: 'House',
              address: '2972 Westheimer Rd, Santa Ana, Illinois 85486',
              onDelete: () {
                // Handle delete action
              },
            ),
            FavouriteListItem(
              name: 'Home',
              address: '2972 Westheimer Rd, Santa Ana, Illinois 85486',
              onDelete: () {
                // Handle delete action
              },
            ),
            FavouriteListItem(
              name: 'Office',
              address: '2972 Westheimer Rd, Santa Ana, Illinois 85486',
              onDelete: () {
                // Handle delete action
              },
            ),
            FavouriteListItem(
              name: 'House',
              address: '2972 Westheimer Rd, Santa Ana, Illinois 85486',
              onDelete: () {
                // Handle delete action
              },
            ),

            CustomFilledButton(
              text: 'Wallet',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>WalletScreen(),)
                );
              },

            ),
          ],
        ),
      ),
    );
  }
}
