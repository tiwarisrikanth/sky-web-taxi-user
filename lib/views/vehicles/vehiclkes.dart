import 'dart:convert';

import 'package:bounce/bounce.dart';
import 'package:date_time_picker_widget/date_time_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:taxiuser/constants/colors/colors.dart';
import 'package:taxiuser/constants/mapstyle/mapstyle.dart';
import 'package:taxiuser/views/home/pickup_adn%20_desti.dart';
import 'package:taxiuser/views/home/searching_cab.dart';

class VehicleData extends StatefulWidget {
  const VehicleData({super.key});

  @override
  State<VehicleData> createState() => _VehicleDataState();
}

class _VehicleDataState extends State<VehicleData> {
  String _d1 = '', _d2 = '';
  String _t1 = '', _t2 = '';

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

  int selectedInt = -1;
  String selectedCAb = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlidingUpPanel(
        minHeight: MediaQuery.of(context).size.height / 1.8,
        // maxHeight: MediaQuery.of(context).size.height / 2,
        panel: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Container(
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
                  // onTap: () {
                  //   Navigator.push(context,
                  //       MaterialPageRoute(builder: (context) => PickNDrop()));
                  // },
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
                  // onTap: () {
                  //   Navigator.push(context,
                  //       MaterialPageRoute(builder: (context) => PickNDrop()));
                  // },
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
                          "Available Rides",
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
                          itemCount: 11,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: selectedInt == index
                                  ? EdgeInsets.all(8.0)
                                  : EdgeInsets.all(0.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: selectedInt == index
                                        ? Colors.green
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                        width: 2,
                                        color: selectedInt == index
                                            ? Colors.black.withOpacity(0.4)
                                            : Colors.transparent)),
                                child: ListTile(
                                  onTap: () {
                                    if (selectedInt == index) {
                                      setState(() {
                                        selectedInt = -1;
                                        selectedCAb = "";
                                      });
                                    } else {
                                      setState(() {
                                        selectedInt = index;
                                        selectedCAb = "Mini ${index + 1}";
                                      });
                                    }
                                  },
                                  leading: index == 0
                                      ? Image.asset(
                                          'assets/images/car.png',
                                          height: 50,
                                          width: 50,
                                        )
                                      : index == 1
                                          ? Image.asset(
                                              'assets/images/rikshaw.png',
                                              height: 50,
                                              width: 50,
                                            )
                                          : index == 2
                                              ? Image.asset(
                                                  'assets/images/motorcycle.png',
                                                  height: 50,
                                                  width: 50,
                                                )
                                              : ImageIcon(
                                                  NetworkImage(
                                                    'https://firebasestorage.googleapis.com/v0/b/newsapp-df8ab.appspot.com/o/360_F_213750591_6bVeg9sH1cD7wEvYhb2OUyHOesJzPtAL-removebg-preview.png?alt=media&token=6f02843a-703d-4ac0-86f8-f659c9590dfa',
                                                  ),
                                                  size: 44,
                                                  color: selectedInt == index
                                                      ? white
                                                      : Colors.black,
                                                ),
                                  title: Text(
                                      index == 0
                                          ? "Taxi"
                                          : index == 1
                                              ? "Auto"
                                              : index == 2
                                                  ? "Bike"
                                                  : "Taxi ${index + 1}",
                                      style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: selectedInt == index
                                            ? white
                                            : Colors.grey,
                                      )),
                                  subtitle: Text("${2 + index + 1} Mins ago",
                                      style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w300,
                                        color: selectedInt == index
                                            ? white
                                            : Colors.grey,
                                      )),
                                  trailing: Text(
                                      index == 0
                                          ? "₹ ${500 + index + 500}/-"
                                          : index == 1
                                              ? "₹ ${500 + index + 200}/-"
                                              : index == 2
                                                  ? "₹ ${500}/-"
                                                  : "₹ ${500 + index + 200}/-",
                                      style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        fontWeight: selectedInt == index
                                            ? FontWeight.w800
                                            : FontWeight.w600,
                                        color: selectedInt == index
                                            ? Colors.white
                                            : black,
                                      )),
                                ),
                              ),
                            );
                          }),
                    ],
                  ),
                ),
              ],
            ),
          )),
        ),
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
                        Navigator.pop(context);
                        // _centralizeLocation();
                      },
                      child: Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(90),
                          color: Colors.grey.withOpacity(0.4),
                        ),
                        child: Icon(
                          Icons.arrow_back,
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
      bottomNavigationBar: selectedInt == -1
          ? null
          : Container(
              height: 60,
              child: BottomAppBar(
                padding: EdgeInsets.zero,
                surfaceTintColor: white,
                child: Row(
                  children: [
                    Gap(10),
                    Expanded(
                      child: Bounce(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SearchingCab(),
                            ),
                          );
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: black,
                          ),
                          child: Center(
                              child: Text(
                            "Book $selectedCAb Ride",
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              color: white,
                              fontWeight: FontWeight.w600,
                            ),
                          )),
                        ),
                      ),
                    ),
                    Gap(10),
                    Bounce(
                      onTap: () {
                        getDateandTime(context);
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: black.withOpacity(0.4)),
                        child: Icon(
                          Icons.schedule,
                          color: white,
                          size: 30,
                        ),
                      ),
                    ),
                    Gap(10),
                  ],
                ),
              ),
            ),
    );
  }

  void getDateandTime(BuildContext context) {
    final dt = DateTime.now();
    final dtMin = DateTime.now().subtract(const Duration(hours: 1, minutes: 0));
    final dtMax = dtMin.add(const Duration(
      days: 4,
    ));
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: 500,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Center(
                      child: Container(
                        height: 4,
                        width: MediaQuery.of(context).size.width / 7,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(90),
                          color: Colors.black.withOpacity(0.1),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Please select Date and Time",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: black,
                      ),
                    ),

                    Expanded(
                      child: DateTimePicker(
                        initialSelectedDate: dt,
                        startDate: dt,
                        endDate: dt.add(const Duration(days: 120)),
                        startTime: DateTime(dt.year, dt.month, dt.day, 6),
                        endTime: DateTime(dt.year, dt.month, dt.day, 18),
                        timeInterval: const Duration(minutes: 15),
                        datePickerTitle: 'Pick date',
                        timePickerTitle: 'Pick time',
                        timeOutOfRangeError: 'Sorry shop is closed now',
                        is24h: false,
                        numberOfWeeksToDisplay: 4,
                        onDateChanged: (date) {
                          setState(() {
                            _d1 = DateFormat('dd MMM, yyyy').format(date);
                          });
                        },
                        onTimeChanged: (time) {
                          setState(() {
                            _t1 = DateFormat('hh:mm:ss aa').format(time);
                          });
                        },
                      ),
                    )
                    // Add more widgets here that need dynamic updates
                  ],
                ),
              ),
            );
          },
        );
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
      ),
      backgroundColor: Colors.transparent,
    );
  }
}
