import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rideshare/bloc/Login/AuthBlocLogin.dart';
import 'package:rideshare/bloc/getBicycles/get_bicycles_bloc.dart';
import 'package:rideshare/bloc/getBicycles/get_bicycles_event.dart';
import 'package:rideshare/bloc/getBicycles/get_bicycles_state.dart';
import 'package:rideshare/model/getBicyclesModel.dart';
import 'package:rideshare/new/pages/Map/mapScreen.dart';
import 'package:rideshare/new/pages/Search/searchScreen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBlocLogin>(context);
    final token = authBloc.authToken; // Retrieve the token from AuthBlocLogin

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
            const SizedBox(height: 16),
            _buildWeatherCard(),
            const SizedBox(height: 16),
            Expanded(
              child: _buildBicyclesSection(context, token),
            ),
          ],
        ),
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
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
              size: 28,
            ),
            onPressed: () {
              // Navigate to the SearchScreen
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => SearchPage()), // Navigate to SearchPage
              // );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherCard() {
    return Container(
      height: 200,
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

  Widget _buildBicyclesSection(BuildContext context, String? token) {
    return BlocBuilder<GetBicycleBloc, GetBicycleState>(
      builder: (context, state) {
        if (state is GetBicycleLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is GetBicycleLoaded) {
          return _buildBicyclesList(context, state.bicycles); // Pass context here
        } else if (state is GetBicycleError) {
          return Center(child: Text(state.message));
        } else {
          // Trigger fetching bicycles
          if (token != null) {
            context.read<GetBicycleBloc>().add(GetFetchBicyclesEvent(token: token));
          }
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _buildBicyclesList(BuildContext context, List<GetBicycleModel> bicycles) { // Add context parameter
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
                onPressed: () {
                  // Navigate to the MapScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()), // Navigate to MapPage
                  );
                },
                child: const Text(
                  'Browse Map >',
                  style: TextStyle(
                    color: Colors.white,
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

  Widget _buildBicycleCard(GetBicycleModel bicycle) {
    return Container(
      width: 350,
      height: 100,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              'https://${bicycle.photoPath}',
              height: 200,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            decoration: BoxDecoration(
              color: Color(0xFF009EFD).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'Distance 150m', // Example distance, calculate dynamically if needed
              style: const TextStyle(
                color: Color(0xFF009EFD),
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
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
