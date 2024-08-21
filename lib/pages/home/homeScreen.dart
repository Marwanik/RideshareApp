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
import 'package:rideshare/widget/button/customSmallButton.dart';
import 'package:rideshare/widget/drawer/homeDrawer.dart';
import 'package:rideshare/widget/textField/searchTextField.dart';
import 'package:flutter/scheduler.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final TextEditingController searchController = TextEditingController();
  late MapController mapController;
  LatLng? userLocation;
  String searchQuery = '';
  late AnimationController _animationController;
  int selectedTabIndex = 0;

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
    _fetchHubs();
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

  void _searchHubs(String query) {
    setState(() {
      searchQuery = query.toLowerCase();
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
                List<Marker> hubMarkers = [];
                if (state is HubLoaded) {
                  hubMarkers = state.hubs
                      .where((hub) =>
                  hub.name.toLowerCase().contains(searchQuery) ||
                      hub.description.toLowerCase().contains(searchQuery))
                      .map(
                        (hub) => Marker(
                      point: LatLng(hub.latitude, hub.longitude),
                      width: 120,
                      height: 80,
                      child:  Column(
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
                  )
                      .toList();
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
                                  // Handle rental action
                                },
                                borderColor: Colors.green,
                              ),
                            ),
                            const SizedBox(width: 8),
                            IconButton(
                              icon: Icon(Icons.my_location),
                              onPressed: _initializeMap,
                              color: Colors.green,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        CustomSearchField(
                          controller: searchController,
                          hintText: "Where would you go?",
                          leadingIcon: Icons.search,
                          trailingIcon: Icons.favorite_border,
                          onChanged: _searchHubs, // Enable searching hubs
                        ),
                        const SizedBox(height: 16),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.green),
                          ),
                          child: TabBar(
                            onTap: (index) {
                              setState(() {
                                selectedTabIndex = index;
                              });
                            },
                            indicator: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            indicatorPadding: EdgeInsets.all(2.0),
                            tabs: [
                              Tab(
                                child: Text(
                                  'Transport',
                                  style: TextStyle(
                                    color: selectedTabIndex == 0
                                        ? Colors.white
                                        : Colors.grey,
                                  ),
                                ),
                              ),
                              Tab(
                                child: Text(
                                  'Delivery',
                                  style: TextStyle(
                                    color: selectedTabIndex == 1
                                        ? Colors.white
                                        : Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
