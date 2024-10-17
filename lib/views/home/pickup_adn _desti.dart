import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxiuser/constants/colors/colors.dart';
import 'package:taxiuser/views/vehicles/vehiclkes.dart';

class PickNDrop extends StatefulWidget {
  const PickNDrop({super.key});

  @override
  State<PickNDrop> createState() => _PickNDropState();
}

class _PickNDropState extends State<PickNDrop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        centerTitle: true,
        titleSpacing: 0,
        toolbarHeight: 100,
        backgroundColor: white,
        title: Text(
          "Pick your trip",
          style: GoogleFonts.poppins(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: black,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 110,
            color: white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
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
              ],
            ),
          ),
          Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Container(
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VehicleData(),
                        ),
                      );
                    },
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
              },
            ),
          )
        ],
      ),
    );
  }
}
