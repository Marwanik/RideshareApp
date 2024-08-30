import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rideshare/bloc/Login/AuthBlocLogin.dart';
import 'package:rideshare/bloc/wallet/wallet_bloc.dart';
import 'package:rideshare/bloc/wallet/wallet_event.dart';
import 'package:rideshare/bloc/wallet/wallet_state.dart';
import 'package:rideshare/repos/walletRepo.dart';
import 'package:rideshare/service/walletService.dart';
import 'package:dio/dio.dart';

class WalletPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Wallet'),
      ),
      body: BlocProvider(
        create: (context) => WalletBloc(WalletRepository(WalletService(Dio()))),
        child: WalletView(),
      ),
    );
  }
}

class WalletView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBlocLogin>(context);  // Get the AuthBlocLogin
    final token = authBloc.authToken;  // Retrieve the token from AuthBlocLogin

    if (token == null) {
      // If token is null, prompt user to log in again
      return _buildLoginPrompt(context);
    }

    return BlocConsumer<WalletBloc, WalletState>(
      listener: (context, state) {
        if (state is WalletError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );

          if (state.error.contains('Please log in again')) {
            // Navigate to login screen or show login dialog
            _showLoginDialog(context);
          }
        }
      },
      builder: (context, state) {
        if (state is WalletInitial) {
          context.read<WalletBloc>().add(FetchWalletEvent(token: token));
          return Center(child: CircularProgressIndicator());
        } else if (state is WalletLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is WalletLoaded) {
          final wallet = state.wallet;
          return _buildWalletInfo(wallet);
        } else if (state is WalletError) {
          return Center(child: Text('Error: ${state.error}'));
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildWalletInfo(wallet) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Wallet ID: ${wallet.id}',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Balance: \$${wallet.balance}',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Bank Account: ${wallet.bankAccount}',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginPrompt(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('You need to log in to view your wallet information.'),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              _showLoginDialog(context);
            },
            child: Text('Log In'),
          ),
        ],
      ),
    );
  }

  void _showLoginDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Re-authentication Required'),
          content: Text('Your session has expired. Please log in again.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Navigate to login page or perform re-authentication
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: Text('Login'),
            ),
          ],
        );
      },
    );
  }
}