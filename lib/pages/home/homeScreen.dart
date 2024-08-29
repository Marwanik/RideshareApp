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
import 'package:rideshare/model/hubModel.dart';
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
  LatLng? userLocation;
  LatLng? selectedStartHubLocation;
  LatLng? selectedDestinationHubLocation;
  late MapController mapController;
  late AnimationController _animationController;
  List<Hub> availableHubs = [];
  List<Hub> filteredHubs = [];  // To hold the search results
  List<LatLng> polylinePoints = [];
  int selectedTabIndex = 0;
  final TextEditingController searchController = TextEditingController();
  bool isSearchEnabled = true;  // Control the search functionality
  bool isLocationObtained = false;  // Track whether the current location is obtained


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

    BlocProvider.of<AuthBlocLogin>(context).stream.listen((state) {
      if (state is SuccessLogin) {
        if (userLocation != null) {
          _fetchHubs();
        }
      }
    });

    _initializeMap().then((_) {
      if (BlocProvider.of<AuthBlocLogin>(context).authToken != null) {
        _fetchHubs();
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
      mapController.move(userLocation!, 15.0);
      isLocationObtained = true;  // Set this to true after obtaining the location
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

  Future<void> _fetchRoute() async {
    if (selectedStartHubLocation == null ||
        selectedDestinationHubLocation == null) return;

    setState(() {
      polylinePoints = [
        selectedStartHubLocation!,
        selectedDestinationHubLocation!,
      ];
    });
  }

  void _onHubSelected(Hub hub, bool isStart) {
    setState(() {
      if (isStart) {
        selectedStartHubLocation = LatLng(hub.latitude, hub.longitude);
      } else {
        selectedDestinationHubLocation = LatLng(hub.latitude, hub.longitude);
      }
      isSearchEnabled = false;  // Disable search after a hub is selected
      _fetchRoute();  // Fetch the route when both locations are selected
    });
  }

  void _showHubDistance(Hub hub) {
    if (userLocation != null) {
      double distance = Geolocator.distanceBetween(
        userLocation!.latitude,
        userLocation!.longitude,
        hub.latitude,
        hub.longitude,
      );

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.lightGreen[100],
            title: Text('Hub Info'),
            content: Text('Distance to selected hub: ${(distance / 1000).toStringAsFixed(2)} KM'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Close'),
              ),
            ],
          );
        },
      );
    }
  }

  void _filterHubs(String query) {
    setState(() {
      filteredHubs = availableHubs.where((hub) =>
      hub.name.toLowerCase().contains(query.toLowerCase()) ||
          hub.description.toLowerCase().contains(query.toLowerCase())).toList();
    });
  }

  void _resetSelections() {
    setState(() {
      selectedStartHubLocation = null;
      selectedDestinationHubLocation = null;
      polylinePoints = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: selectedTabIndex,
      child: Scaffold(
        drawer: CustomDrawer(),
        body: Stack(
          children: [
            BlocBuilder<HubBloc, HubState>(
              builder: (context, state) {
                if (state is HubLoaded) {
                  availableHubs = state.hubs;
                  filteredHubs = state.hubs; // Initialize filteredHubs with all hubs
                }

                List<Marker> hubMarkers = [];

                if (selectedStartHubLocation != null) {
                  hubMarkers.add(
                    Marker(
                      point: selectedStartHubLocation!,
                      width: 120,
                      height: 80,
                      child: const Icon(
                        Icons.location_pin,
                        size: 40,
                        color: Colors.blue,
                      ),
                    ),
                  );
                }

                if (selectedDestinationHubLocation != null) {
                  hubMarkers.add(
                    Marker(
                      point: selectedDestinationHubLocation!,
                      width: 120,
                      height: 80,
                      child: const Icon(
                        Icons.location_pin,
                        size: 40,
                        color: Colors.purple,
                      ),
                    ),
                  );
                }

                if (selectedStartHubLocation == null && selectedDestinationHubLocation == null) {
                  hubMarkers = filteredHubs.map((hub) {
                    return Marker(
                      rotate: true,
                      point: LatLng(hub.latitude, hub.longitude),
                      width: 120,
                      height: 80,
                      child: GestureDetector(
                        onTap: () {
                          _showHubDistance(hub);
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
                              hub.name,
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
                            point: userLocation!,
                            width: 80,
                            height: 80,
                            child: Column(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  size: 40,
                                  color: Colors.red,
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  "انت هنا",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
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
                            gradientColors: [
                              Color(0xFFFFD700), // Yellow
                              Color(0xFFFF8C00), // Orange
                            ],
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
            if (isSearchEnabled)
              Positioned(
                top: 100, // Adjust as needed
                left: 16,
                right: 16,
                child: CustomSearchField(
                  controller: searchController,
                  hintText: 'Search Hubs...',
                  leadingIcon: Icons.search,
                  trailingIcon: Icons.clear,
                  onChanged: (query) {
                    _filterHubs(query);
                  },
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
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => SelectBikeScreen()),
                                    );
                                  },
                                  borderColor: Colors.green,
                                ),
                              ),
                              const SizedBox(width: 8),
                              IconButton(
                                icon: Icon(Icons.my_location),
                                onPressed: () {
                                  _getCurrentLocation();
                                },
                                color: Colors.green,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          DropdownButton<Hub>(
                            hint: Text('Select Start Hub'),
                            value: selectedStartHubLocation != null
                                ? availableHubs.firstWhere(
                                    (hub) =>
                                hub.latitude == selectedStartHubLocation!.latitude &&
                                    hub.longitude == selectedStartHubLocation!.longitude)
                                : null,
                            items: availableHubs.map((Hub hub) {
                              return DropdownMenuItem<Hub>(
                                value: hub,
                                child: Text(hub.name),
                              );
                            }).toList(),
                            onChanged: (Hub? hub) {
                              if (hub != null) {
                                _onHubSelected(hub, true);
                              }
                            },
                          ),

                          const SizedBox(height: 8),
                          DropdownButton<Hub>(
                            hint: Text('Select End Hub'),
                            value: selectedDestinationHubLocation != null
                                ? availableHubs.firstWhere(
                                    (hub) =>
                                hub.latitude == selectedDestinationHubLocation!.latitude &&
                                    hub.longitude == selectedDestinationHubLocation!.longitude)
                                : null,
                            items: availableHubs.map((Hub hub) {
                              return DropdownMenuItem<Hub>(
                                value: hub,
                                child: Text(hub.name),
                              );
                            }).toList(),
                            onChanged: (Hub? hub) {
                              if (hub != null) {
                                _onHubSelected(hub, false);
                              }
                            },
                          ),

                          const SizedBox(height: 8),
                          if (selectedStartHubLocation != null && selectedDestinationHubLocation != null)
                            Column(
                              children: [
                                Text(
                                  'Distance: ${(Geolocator.distanceBetween(
                                    selectedStartHubLocation!.latitude,
                                    selectedStartHubLocation!.longitude,
                                    selectedDestinationHubLocation!.latitude,
                                    selectedDestinationHubLocation!.longitude,
                                  ) / 1000).toStringAsFixed(2)} KM',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                ElevatedButton(
                                  onPressed: _resetSelections,
                                  child: Text('Reset'),
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
