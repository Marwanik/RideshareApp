import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rideshare/bloc/Login/AuthBlocLogin.dart';
import 'package:rideshare/bloc/bisycle/bisycle_bloc.dart';
import 'package:rideshare/bloc/bisycle/bisycle_event.dart';
import 'package:rideshare/bloc/bisycle/bisycle_state.dart';
import 'package:rideshare/model/bicycleModel.dart';
import 'package:jwt_decoder/jwt_decoder.dart'; // Add this package in your pubspec.yaml

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBlocLogin>(context);
    final token = authBloc.authToken; // Retrieve the token from AuthBlocLogin

    if (token == null || JwtDecoder.isExpired(token)) {
      // If token is null or expired, handle the situation (show login screen or error)
      return _buildLoginPrompt(context);
    }

    print('Auth Token: $token'); // Print the token for debugging

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF009EFD), // Start color of the gradient
              Color(0xFF2AF598), // End color of the gradient
            ],
          ),
        ),
        child: Column(
          children: [
            _buildHeader(context),
            _buildWeatherCard(),
            _buildBicyclesSection(context, token),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginPrompt(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Your session has expired. Please log in again.'),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Navigate to login screen or perform re-authentication
              Navigator.pushReplacementNamed(context, '/login');
            },
            child: Text('Log In'),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 16.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 30,
            backgroundImage: AssetImage('assets/images/splash/Shape.png'), // Add your profile image path
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Hello John,',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'Wanna take a ride today?',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
          Spacer(),
          Icon(
            Icons.search,
            color: Colors.white,
            size: 28,
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(
            Icons.wb_sunny,
            color: Colors.orange,
            size: 40,
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                '18° Cloudy',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Marbella Dr',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          Spacer(),
          const Text(
            '28 September, Wednesday',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBicyclesSection(BuildContext context, String token) {
    return Expanded(
      child: BlocBuilder<BicycleBloc, BicycleState>(
        builder: (context, state) {
          if (state is BicycleLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is BicycleLoaded) {
            return _buildBicyclesList(state.bicycles);
          } else if (state is BicycleError) {
            return Center(child: Text(state.message));
          } else {
            // Trigger fetching bicycles
            print('Fetching bicycles...');
            context.read<BicycleBloc>().add(FetchBicyclesByCategory(token: token, category: ''));
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _buildBicyclesList(List<BicycleModel> bicycles) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Near You',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Browse Map >',
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: bicycles.length,
            itemBuilder: (context, index) {
              return _buildBicycleCard(bicycles[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBicycleCard(BicycleModel bicycle) {
    return Container(
      width: 200,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            'https://${bicycle.photoPath}',
            height: 100,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 8),
          Text(
            'Distance 150m', // Example distance, calculate dynamically if needed
            style: const TextStyle(
              color: Color(0xFF009EFD),
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            bicycle.modelPrice.model,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '${bicycle.modelPrice.price} Available', // Example availability, adjust as needed
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
