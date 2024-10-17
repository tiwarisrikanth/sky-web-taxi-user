import 'dart:async';
import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxiuser/constants/colors/colors.dart';
import 'package:taxiuser/constants/mapstyle/mapstyle.dart';

class SearchingCab extends StatefulWidget {
  const SearchingCab({super.key});

  @override
  State<SearchingCab> createState() => _SearchingCabState();
}

class _SearchingCabState extends State<SearchingCab> {
  late GoogleMapController mapController;
  Position? _currentPosition;
  Timer? _rotationTimer;
  double _bearing = 0.0;

  LatLng _initialPosition =
      LatLng(37.7749, -122.4194); // Default position (San Francisco)

  List<String> _searchMessages = [
    "Searching your driver...",
    "Please wait while we locate the nearest driver...",
    "Thank you for your patience...",
    "Almost there, just finalizing details...",
    "Your driver will arrive soon...",
    "Matching you with the best available driver...",
    "Hang tight, your driver is being notified...",
    "Verifying your ride details...",
    "Your safety is our priority, ensuring a smooth ride...",
    "Double-checking the route for accuracy...",
    "Please hold on while we prepare your journey...",
    "Your cab is on its way, just a moment...",
    "Your ride will be arriving shortly..."
  ];

  String _currentMessage = "Searching your driver...";
  Timer? _messageTimer;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _startMessageAnimation();
  }

  @override
  void dispose() {
    _rotationTimer?.cancel(); // Stop the timer when the widget is disposed
    _messageTimer?.cancel(); // Stop message timer
    super.dispose();
  }

  void _startMessageAnimation() {
    int index = 0;
    _messageTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        _currentMessage = _searchMessages[index];
        index = (index + 1) % _searchMessages.length; // Loop through messages
      });
    });
  }

  // Function to set the map style based on the time of day
  void _setMapStyle(GoogleMapController controller) {
    int hour = DateTime.now().hour;

    if (hour >= 6 && hour < 18) {
      controller.setMapStyle(dayStyle); // Daytime style
    } else if (hour >= 18 && hour < 20) {
      controller.setMapStyle(eveningStyle); // Evening style
    } else {
      controller.setMapStyle(nightStyle); // Night style
    }
  }

  void _getCurrentLocation() async {
    _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // Update the initial position with the current location
    _initialPosition =
        LatLng(_currentPosition!.latitude, _currentPosition!.longitude);

    // Animate the camera to the current location
    mapController?.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: _initialPosition,
        zoom: 14.0,
      ),
    ));

    // Start rotating the camera
    _startCameraRotation();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _setMapStyle(controller);
    _getCurrentLocation(); // Ensure to get location after map creation
  }

  void _startCameraRotation() {
    _rotationTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      setState(() {
        _bearing += 2; // Adjust the speed by changing this value
        if (_bearing > 360) {
          _bearing = 0;
        }

        if (_currentPosition != null && mapController != null) {
          mapController.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(
                  _currentPosition!.latitude, _currentPosition!.longitude),
              zoom: 14.0,
              bearing: _bearing,
            ),
          ));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            zoomControlsEnabled: false,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _initialPosition,
              zoom: 11.0,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: white,
                ),
                child: Column(
                  children: [
                    Gap(10),
                    Container(
                      height: 6,
                      width: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(90),
                        color: Colors.black26,
                      ),
                    ),
                    // Gap(5),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: SizedBox(
                          height: 20,
                          child: Align(
                            child: LinearProgressIndicator(),
                          ),
                        ),
                      ),
                    ),
                    Gap(10),
                    // AnimatedSwitcher for rotating messages
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          child: Text(
                            _currentMessage,
                            key: ValueKey<String>(_currentMessage),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Bounce(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SearchingCab(),
                              ),
                            );
                          },
                          child: Align(
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: black,
                              ),
                              child: Center(
                                  child: Text(
                                "Cancel Ride",
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  color: white,
                                  fontWeight: FontWeight.w600,
                                ),
                              )),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Expanded(child: Container()),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
