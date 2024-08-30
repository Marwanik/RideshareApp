import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rideshare/bloc/Login/AuthBlocLogin.dart';
import 'package:rideshare/bloc/policy/policy_bloc.dart';
import 'package:rideshare/bloc/policy/policy_event.dart';
import 'package:rideshare/bloc/policy/policy_state.dart';
import 'package:rideshare/repos/policyRepo.dart';
import 'package:rideshare/service/policyService.dart';
import 'package:dio/dio.dart';

class PolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBlocLogin>(context);
    final token = authBloc.authToken; // Retrieve the token from AuthBlocLogin

    if (token == null) {
      return _buildLoginPrompt(context);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy'),
      ),
      body: BlocProvider(
        create: (context) => PolicyBloc(PolicyRepository(PolicyService(Dio()))),
        child: PolicyView(token: token),
      ),
    );
  }

  Widget _buildLoginPrompt(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('You need to log in to view the privacy policy.'),
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

class PolicyView extends StatelessWidget {
  final String token;

  PolicyView({required this.token});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PolicyBloc, PolicyState>(
      listener: (context, state) {
        if (state is PolicyError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );

          if (state.error.contains('Please log in again')) {
            _showLoginDialog(context);
          }
        }
      },
      builder: (context, state) {
        if (state is PolicyInitial) {
          context.read<PolicyBloc>().add(FetchPolicyEvent(token: token));
          return Center(child: CircularProgressIndicator());
        } else if (state is PolicyLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is PolicyLoaded) {
          final policy = state.policy;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    policy.title,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Text(
                    policy.description,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          );
        } else if (state is PolicyError) {
          return Center(child: Text('Error: ${state.error}'));
        } else {
          return Container();
        }
      },
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
