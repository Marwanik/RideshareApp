import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:rideshare/bloc/Hub/HubBloc.dart';
import 'package:rideshare/bloc/Hub/HubStateBloc.dart';
import 'package:rideshare/widget/button/customSmallButton.dart';
import 'package:rideshare/widget/drawer/homeDrawer.dart';
import 'package:rideshare/widget/textField/searchTextField.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  final TextEditingController searchController = TextEditingController();
  late MapController mapController;
  LatLng? userLocation; // Variable to store the user's current location

  @override
  void initState() {
    super.initState();
    mapController = MapController();
    _getCurrentLocation(); // Fetch user's location as soon as the widget initializes
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Location services are disabled.'),
      ));
      return;
    }

    // Check location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Location permissions are denied.'),
        ));
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Location permissions are permanently denied.'),
      ));
      return;
    }

    // Get current location
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // Update the userLocation variable and trigger a rebuild
    setState(() {
      userLocation = LatLng(position.latitude, position.longitude);

      // Center the map on the current location
      mapController.move(
        userLocation!,
        20.0,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      body: Stack(
        children: [
          BlocBuilder<HubBloc, HubState>(
            builder: (context, state) {
              return FlutterMap(
                mapController: mapController,
                options: MapOptions(
                  initialCenter: userLocation ?? LatLng(33.5093553, 36.2939167), // Default center if no location yet
                  initialZoom: 13.0,
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.app',
                  ),
                  if (userLocation != null) // Show marker for user's location
                    MarkerLayer(
                      markers: [
                        Marker(
                          rotate: false,
                          point: userLocation!,
                          width: 80,
                          height: 80,
                          child: const Icon(
                            Icons.location_on,
                            size: 40,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  if (state is HubLoaded) // Show markers for hubs
                    MarkerLayer(
                      markers: state.hubs.map((hub) {
                        return Marker(
                          point: LatLng(hub.latitude, hub.longitude),
                          width: 80,
                          height: 80,
                          child: const Icon(
                            Icons.location_pin,
                            size: 40,
                            color: Colors.green,
                          ),
                        );
                      }).toList(),
                    ),
                ],
              );
            },
          ),
          Positioned(
            top: 40,
            left: 16,
            right: 16,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Builder(
                      builder: (context) => IconButton(
                        icon: Icon(Icons.menu),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.notifications),
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                CustomSearchField(
                  controller: searchController,
                  hintText: "Where would you go?",
                  leadingIcon: Icons.search,
                  trailingIcon: Icons.favorite,
                ),
                const SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.green),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          text: "Transport",
                          onPressed: () {},
                          color: Colors.green,
                          textColor: Colors.white,
                          borderColor: Colors.green,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: CustomButton(
                          text: "Delivery",
                          onPressed: () {},
                          color: Colors.white,
                          textColor: Colors.green,
                          borderColor: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 80,
            right: 16,
            child: FloatingActionButton(
              onPressed: _getCurrentLocation,
              child: Icon(Icons.my_location),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favourite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: 'Wallet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_offer),
            label: 'Offer',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
