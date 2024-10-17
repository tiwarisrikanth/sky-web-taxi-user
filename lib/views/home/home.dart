import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:taxiuser/constants/colors/colors.dart';
import 'package:taxiuser/constants/mapstyle/mapstyle.dart';
import 'package:taxiuser/views/home/pickup_adn%20_desti.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late GoogleMapController mapController;
  Position? _currentPosition;

  LatLng _initialPosition =
      LatLng(37.7749, -122.4194); // Default position (San Francisco)

  @override
  void initState() {
    super.initState();
    _setMapStyle();
    _determinePosition();
    _getCurrentLocation();
    getAllOptions();
  }

  // Function to set the map style based on the time of day
  void _setMapStyle() {
    int hour = DateTime.now().hour;

    if (hour >= 6 && hour < 18) {
      mapStyle = dayStyle; // Daytime style
    } else if (hour >= 18 && hour < 20) {
      mapStyle = eveningStyle; // Evening style
    } else {
      mapStyle = nightStyle; // Night style
    }
  }

  List ofptio = [];

  Future getAllOptions() async {
    var request = http.Request('GET',
        Uri.parse('https://mocki.io/v1/53847979-4994-4864-9832-49c3f2ecc9a1'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseString = await response.stream.bytesToString();
      final decodedMap = json.decode(responseString);

      setState(() {
        ofptio = decodedMap['data'];
      });
      print(ofptio);
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _initialPosition = LatLng(position.latitude, position.longitude);
    });

    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: _initialPosition,
          zoom: 17.0,
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    mapController.setMapStyle(mapStyle);
  }

  void _getCurrentLocation() async {
    _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    mapController?.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
        zoom: 14.0,
      ),
    ));
  }

  void _centralizeLocation() {
    if (_currentPosition != null) {
      mapController?.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target:
              LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
          zoom: 14.0,
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlidingUpPanel(
        minHeight: MediaQuery.of(context).size.height / 1.8,
        // maxHeight: MediaQuery.of(context).size.height / 2,
        panel: Container(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Gap(10),
              Container(
                height: 4,
                width: MediaQuery.of(context).size.width / 7,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(90),
                  color: black.withOpacity(0.1),
                ),
              ),
              Gap(10),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PickNDrop()));
                },
                child: Row(
                  children: [
                    Gap(10),
                    Icon(
                      Icons.my_location,
                      size: 25,
                      color: black.withOpacity(0.4),
                    ),
                    Gap(10),
                    Expanded(
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.brown.withOpacity(0.1)),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              "Enter your current location",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: black,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Gap(10),
                  ],
                ),
              ),
              Row(
                children: [
                  Gap(15),
                  Image.asset(
                    'assets/images/lines.png',
                    height: 20,
                  )
                ],
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PickNDrop()));
                },
                child: Row(
                  children: [
                    Gap(10),
                    Icon(
                      Icons.location_on,
                      size: 25,
                      color: Colors.red.withOpacity(0.4),
                    ),
                    Gap(10),
                    Expanded(
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.grey.withOpacity(0.1)),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              "Enter your destination location",
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors.red.withOpacity(0.3),
                                  fontWeight: FontWeight.w600),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Gap(10),
                  ],
                ),
              ),
              Gap(10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Recently Visited",
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: black,
                        ),
                      ),
                    ),
                    ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: 3,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Container(
                            child: ListTile(
                              leading: Icon(
                                Icons.location_on,
                                color: Colors.red,
                              ),
                              title: Text("Destination Title",
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey,
                                  )),
                              subtitle: Text("Destination Title",
                                  style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.grey,
                                  )),
                            ),
                          );
                        }),
                  ],
                ),
              ),
              Gap(2),
              Divider(),
              Container(
                height: 190,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Explore",
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: black,
                          ),
                        ),
                      ),
                      Gap(10),
                      ofptio.isEmpty
                          ? Container(
                              height: 60,
                              width: 60,
                              child: CircularProgressIndicator(
                                color: Colors.green,
                              ),
                            )
                          : Container(
                              height: 80,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: ofptio.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Container(
                                        height: 60,
                                        width: 80,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.brown.withOpacity(0.3),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Align(
                                              child: Container(
                                                height: 40,
                                                width: 40,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                  image: NetworkImage(
                                                    ofptio[index]['rideImage'],
                                                  ),
                                                )),
                                              ),
                                            ),
                                            Text(
                                              ofptio[index]['ridename'],
                                              style: GoogleFonts.poppins(
                                                fontSize: 13,
                                                color: black,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              textAlign: TextAlign.center,
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            )
                    ],
                  ),
                ),
              )
            ],
          ),
        )),
        // collapsed: Container(
        //   color: Colors.blueGrey,
        //   child: Center(
        //     child: Text(
        //       "This is the collapsed Widget",
        //       style: TextStyle(color: Colors.white),
        //     ),
        //   ),
        // ),
        body: Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: MediaQuery.of(context).size.height / 2 - 20,
            child: Stack(
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
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 38.0, right: 12.0),
                    child: InkWell(
                      onTap: () {
                        _centralizeLocation();
                      },
                      child: Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(90),
                          color: white,
                        ),
                        child: Icon(Icons.my_location_rounded),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 42.0, left: 12.0),
                    child: InkWell(
                      onTap: () {
                        _centralizeLocation();
                      },
                      child: Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(90),
                          color: Colors.grey.withOpacity(0.4),
                        ),
                        child: Icon(
                          Icons.menu,
                          color: black,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.0)),
      ),
    );
  }
}
