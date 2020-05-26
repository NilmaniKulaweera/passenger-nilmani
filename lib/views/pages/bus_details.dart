import 'package:flutter/material.dart';
import 'package:transport_booking_system_passenger_mobile/controllers/authController.dart';
import 'package:transport_booking_system_passenger_mobile/models/busTripData.dart';
import 'package:transport_booking_system_passenger_mobile/views/pages/bus_layout_wrapper.dart';

class BusDetails extends StatefulWidget {
  final String startingDestination;
  final String endingDestination;
  final String journeyDate;
  BusDetails({this.startingDestination, this.endingDestination, this.journeyDate, String uid});

  @override
  _BusDetailsState createState() => _BusDetailsState();
}

class _BusDetailsState extends State<BusDetails> {
  final AuthController _auth = AuthController();
  List<BusTripData> busDetails;

  @override
  void initState() {
    busDetails = _auth.getBusTripDetails(
      widget.startingDestination, widget.endingDestination, widget.journeyDate
    ).data; // get the list of bus details
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        title: Text(
          'Bus Details',
          style: TextStyle(
            color: Colors.white
          ),
        )
      ),
      body: ListView.builder(
        itemCount: busDetails.length,
        itemBuilder: (context, index) {
          return BusDetailTile(busTripData: busDetails[index]);
        }
      ),
    );
  } 
}

class BusDetailTile extends StatelessWidget {
  final BusTripData busTripData;
  BusDetailTile({this.busTripData});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[200],
      margin: EdgeInsets.all(15.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Text('Bus Number - ${busTripData.busNumber}'),
            SizedBox(
              height: 10,
            ),
            Text('Bus Type - ${busTripData.busType}'),
            SizedBox(
              height: 10,
            ),
            Text('Route Number - ${busTripData.routeNumber}'),
            SizedBox(
              height: 10,
            ),
            Text('Starting Destination - ${busTripData.startingDestination} - ${busTripData.startingDateTime}'),
            SizedBox(
              height: 10,
            ),
            Text('Ending Destination - ${busTripData.endingDestination} - ${busTripData.endingDateTime}'),
            SizedBox(
              height: 10,
            ),
            Text('Seat Price - LKR ${busTripData.seatPrice}'),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                  child: Text(
                    "View Seats",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                  color: Colors.green[900],
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => BusLayoutWrapper(
                      seatPrice: busTripData.seatPrice,
                      busType: busTripData.busType, 
                      busSeatDetails: busTripData.busSeatDetails
                    )));   
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }             
}