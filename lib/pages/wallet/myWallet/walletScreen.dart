import 'package:flutter/material.dart';
import 'package:rideshare/pages/wallet/addAmount/addAmountScreen.dart';
import 'package:rideshare/pages/wallet/createNewWallet/createWalletScreen.dart';
import 'package:rideshare/widget/button/outlineButton.dart';
import 'package:rideshare/widget/container/balanceCardContainer.dart';
import 'package:rideshare/widget/drawer/homeDrawer.dart';
import 'package:rideshare/widget/listTile/TransactionListItem.dart';

class WalletScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wallet'),
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
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.black),
            onPressed: () {
              // Handle notification icon press
            },
          ),
        ],
      ),
      drawer: CustomDrawer(), // Use the CustomDrawer widget
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 175,
                  child: CustomOutlinedButton(
                    text: 'Create Wallet',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WalletPage(),
                          ));
                    },
                  ),
                ),

                Container(
                  width: 175,
                  child: CustomOutlinedButton(
                    text: 'Add Money',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddAmountScreen(),
                          ));
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: BalanceCard(
                    amount: '\$500',
                    label: 'Available Balance',
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: BalanceCard(
                    amount: '\$200',
                    label: 'Total Expend',
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Transactions',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                TextButton(
                  onPressed: () {
                    // Handle See All press
                  },
                  child: Text('See All'),
                ),
              ],
            ),
            Expanded(
              child: ListView(
                children: [
                  TransactionItem(
                    name: 'Welton',
                    time: 'Today at 09:20 am',
                    amount: '-\$570.00',
                    type: 'debit',
                  ),
                  TransactionItem(
                    name: 'Nathsam',
                    time: 'Today at 09:20 am',
                    amount: '\$570.00',
                    type: 'credit',
                  ),
                  TransactionItem(
                    name: 'Welton',
                    time: 'Today at 09:20 am',
                    amount: '-\$570.00',
                    type: 'debit',
                  ),
                  TransactionItem(
                    name: 'Nathsam',
                    time: 'Today at 09:20 am',
                    amount: '\$570.00',
                    type: 'credit',
                  ),
                  // Add more transactions as needed
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
