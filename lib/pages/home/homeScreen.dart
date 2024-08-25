import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:rideshare/bloc/Hub/HubBloc.dart';
import 'package:rideshare/bloc/Hub/HubEventBloc.dart';
import 'package:rideshare/bloc/Hub/HubStateBloc.dart';
import 'package:rideshare/bloc/Login/AuthBlocLogin.dart';
import 'package:rideshare/bloc/Login/AuthStateLogin.dart';
import 'package:rideshare/pages/category/categoryChoose/chooseCategoryScreen.dart';
import 'package:rideshare/widget/button/customSmallButton.dart';
import 'package:rideshare/widget/drawer/homeDrawer.dart';
import 'package:rideshare/widget/textField/searchTextField.dart';
import 'package:flutter/scheduler.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final TextEditingController searchControllerStart = TextEditingController();
  final TextEditingController searchControllerDestination = TextEditingController();
  late MapController mapController;
  LatLng? userLocation;
  LatLng? selectedHubStartLocation;
  LatLng? selectedHubDestinationLocation;
  String searchQueryStart = '';
  String searchQueryDestination = '';
  late AnimationController _animationController;
  int selectedTabIndex = 0;
  bool locationRefreshed = false;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    SchedulerBinding.instance.addPostFrameCallback((_) {
      _animationController.forward();
    });

    // Listen for authentication state changes
    BlocProvider.of<AuthBlocLogin>(context).stream.listen((state) {
      if (state is SuccessLogin) {
        if (userLocation != null) {
          _fetchHubs(); // Fetch hubs only if location is already available
        }
      }
    });

    // Initialize map and fetch hubs when both token and location are ready
    _initializeMap().then((_) {
      if (BlocProvider.of<AuthBlocLogin>(context).authToken != null) {
        _fetchHubs(); // Fetch hubs only if token is already available
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _initializeMap() async {
    await _getCurrentLocation();
    if (!locationRefreshed) {
      _fetchHubs();
    }
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      userLocation = LatLng(position.latitude, position.longitude);
      if (!locationRefreshed) {
        mapController.move(userLocation!, 15.0);
      }
    });
  }

  void _fetchHubs() {
    final authBloc = BlocProvider.of<AuthBlocLogin>(context);
    final authToken = authBloc.authToken;

    if (authToken != null && userLocation != null) {
      BlocProvider.of<HubBloc>(context).add(FetchHubs(
        latitude: userLocation!.latitude,
        longitude: userLocation!.longitude,
        token: authToken,
      ));
    }
  }

  void _searchHubs(String query, bool isStart) {
    setState(() {
      if (isStart) {
        searchQueryStart = query.toLowerCase();
      } else {
        searchQueryDestination = query.toLowerCase();
      }
    });
  }

  void _navigateToSelectBikeScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SelectBiketScreen()),
    );
  }

  double _calculateDistance(LatLng start, LatLng end) {
    return Geolocator.distanceBetween(start.latitude, start.longitude, end.latitude, end.longitude) / 1000; // Returns distance in kilometers
  }

  void _showHubInfoDialog(String name, String description, double distance) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(name),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(description),
              const SizedBox(height: 8),
              Text('Distance: ${distance.toStringAsFixed(2)} km'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double distanceBetweenHubs = 0.0;

    if (selectedHubStartLocation != null && selectedHubDestinationLocation != null) {
      distanceBetweenHubs = _calculateDistance(selectedHubStartLocation!, selectedHubDestinationLocation!);
    }

    return DefaultTabController(
      length: 2,
      initialIndex: selectedTabIndex,
      child: Scaffold(
        drawer: CustomDrawer(),
        body: Stack(
          children: [
            BlocBuilder<HubBloc, HubState>(
              builder: (context, state) {
                List<Marker> hubMarkers = [];
                List<LatLng> polylinePoints = [];

                if (state is HubLoaded) {
                  hubMarkers = state.hubs
                      .where((hub) =>
                  hub.name.toLowerCase().contains(searchQueryStart) ||
                      hub.name.toLowerCase().contains(searchQueryDestination))
                      .map((hub) {
                    final LatLng hubLocation = LatLng(hub.latitude, hub.longitude);
                    final distance = userLocation != null ? _calculateDistance(userLocation!, hubLocation) : 0.0;

                    return Marker(
                      rotate: true,
                      point: hubLocation,
                      width: 120,
                      height: 80,
                     child: GestureDetector(
                        onTap: () {
                          if (searchQueryStart.isNotEmpty && searchQueryDestination.isEmpty) {
                            setState(() {
                              selectedHubStartLocation = hubLocation;
                            });
                          } else if (searchQueryDestination.isNotEmpty) {
                            setState(() {
                              selectedHubDestinationLocation = hubLocation;
                            });
                          }
                          _showHubInfoDialog(hub.name, hub.description, distance);
                        },
                        child: Column(
                          children: [
                            ScaleTransition(
                              scale: _animationController,
                              child: const Icon(
                                Icons.location_pin,
                                size: 40,
                                color: Colors.green,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "${hub.name} ",
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList();

                  if (selectedHubStartLocation != null && selectedHubDestinationLocation != null) {
                    polylinePoints = [selectedHubStartLocation!, selectedHubDestinationLocation!];
                  }
                }

                return FlutterMap(
                  mapController: mapController,
                  options: MapOptions(
                    initialCenter: userLocation ?? LatLng(33.5093553, 36.2939167),
                    initialZoom: 13.0,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.app',
                    ),
                    if (userLocation != null)
                      MarkerLayer(
                        markers: [
                          Marker(
                            rotate: true,
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
                    MarkerLayer(
                      markers: hubMarkers,
                    ),
                    if (polylinePoints.isNotEmpty)
                      PolylineLayer(
                        polylines: [
                          Polyline(
                            points: polylinePoints,
                            strokeWidth: 4.0,
                            color: Colors.blue,
                          ),
                        ],
                      ),
                  ],
                );
              },
            ),
            Positioned(
              top: 40,
              left: 16,
              right: 16,
              child: Row(
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
            ),
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.green[50],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.green),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: CustomButton(
                                  text: 'Rental',
                                  onPressed: _navigateToSelectBikeScreen,
                                  borderColor: Colors.green,
                                ),
                              ),
                              const SizedBox(width: 8),
                              IconButton(
                                icon: Icon(Icons.my_location),
                                onPressed: () {
                                  setState(() {
                                    locationRefreshed = true;
                                  });
                                },
                                color: Colors.green,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          CustomSearchField(
                            controller: searchControllerStart,
                            hintText: "Enter starting hub",
                            leadingIcon: Icons.search,
                            trailingIcon: Icons.clear,
                            onChanged: (query) => _searchHubs(query, true),
                          ),
                          const SizedBox(height: 8),
                          CustomSearchField(
                            controller: searchControllerDestination,
                            hintText: "Enter destination hub",
                            leadingIcon: Icons.search,
                            trailingIcon: Icons.clear,
                            onChanged: (query) => _searchHubs(query, false),
                          ),
                          const SizedBox(height: 8),
                          if (distanceBetweenHubs > 0)
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Do something when pressed
                                    },
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.green,
                                      backgroundColor: Colors.white,
                                      side: BorderSide(color: Colors.green),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Text(
                                      'Calculate Distance',
                                      style: TextStyle(color: Colors.green),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.green),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    '${distanceBetweenHubs.toStringAsFixed(2)} km',
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
