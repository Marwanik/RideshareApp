import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rideshare/bloc/Login/AuthBlocLogin.dart';
import 'package:rideshare/bloc/changePassword/change_password_bloc.dart';
import 'package:rideshare/bloc/changePassword/change_password_event.dart';
import 'package:rideshare/bloc/changePassword/change_password_state.dart';
import 'package:rideshare/model/changePasswordModel.dart';
import 'package:rideshare/repos/changePasswordRepo.dart';
import 'package:rideshare/service/changePasswordService.dart';
import 'package:dio/dio.dart';

class ChangePasswordScreen extends StatelessWidget {
  final TextEditingController currentPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBlocLogin>(context);
    final token = authBloc.authToken; // Retrieve the token from AuthBlocLogin

    if (token == null) {
      return _buildLoginPrompt(context);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
      ),
      body: BlocProvider(
        create: (context) => ChangePasswordBloc(ChangePasswordRepository(ChangePasswordService(Dio()))),
        child: BlocConsumer<ChangePasswordBloc, ChangePasswordState>(
          listener: (context, state) {
            if (state is ChangePasswordSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Password changed successfully')),
              );
            } else if (state is ChangePasswordError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          builder: (context, state) {
            if (state is ChangePasswordLoading) {
              return Center(child: CircularProgressIndicator());
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: currentPasswordController,
                    decoration: InputDecoration(labelText: 'Current Password'),
                    obscureText: true,
                  ),
                  TextField(
                    controller: newPasswordController,
                    decoration: InputDecoration(labelText: 'New Password'),
                    obscureText: true,
                  ),
                  TextField(
                    controller: confirmPasswordController,
                    decoration: InputDecoration(labelText: 'Confirm Password'),
                    obscureText: true,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      final request = ChangePasswordRequest(
                        currentPassword: currentPasswordController.text,
                        newPassword: newPasswordController.text,
                        confirmPassword: confirmPasswordController.text,
                      );

                      context.read<ChangePasswordBloc>().add(
                        ChangePasswordButtonPressed(request: request, token: token),
                      );
                    },
                    child: Text('Change Password'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildLoginPrompt(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('You need to log in to change your password.'),
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
