import 'package:flutter/material.dart';
import 'package:transport_booking_system_passenger_mobile/controllers/authController.dart';
import 'package:transport_booking_system_passenger_mobile/models/apiResponse.dart';
import 'package:transport_booking_system_passenger_mobile/models/busBookindData.dart';
import 'package:intl/intl.dart';
import 'package:transport_booking_system_passenger_mobile/shared_functions.dart';

class PastBooking extends StatefulWidget {
  final String uid;
  final String token;
  PastBooking({this.uid, this.token});

  @override
  _PastBookingState createState() => _PastBookingState();
}

class _PastBookingState extends State<PastBooking> {
 final AuthController _auth = AuthController();
  APIResponse<List<BusBookingData>> _apiResponse;
  final SharedFunctions sharedFunctions = SharedFunctions();
  List<BusBookingData> pastBookings; 
  bool _isLoading;
  String errorMessage;

  @override
  void initState() {
    _fetchBookingDetails();
    super.initState();
  }

  _fetchBookingDetails() async {
    setState(() { _isLoading = true; });
    _apiResponse = await _auth.getPastBookings(widget.uid, widget.token);
    setState(() { 
      _isLoading = false; 
      if (_apiResponse.error){
        errorMessage = _apiResponse.errorMessage;
      } else {
        pastBookings = _apiResponse.data;
        pastBookings.sort((a, b) => sharedFunctions.getTimeDifference(sharedFunctions.getDateTime(a.departureTime)).compareTo(sharedFunctions.getTimeDifference(sharedFunctions.getDateTime(b.departureTime))));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.green[900],
          title: Text(
            'Past Bookings',
            style: TextStyle(
              color: Colors.white
            ),
          )
        ),
      body: Container(
        child: Stack(
          children: <Widget>[
            _isLoading? Center(child: CircularProgressIndicator()) : Container(
                child: _apiResponse.error? SingleChildScrollView(
                  child: Card(
                    margin: EdgeInsets.fromLTRB(20, 40, 20, 40),
                    color: Colors.grey[100],
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                        child: Text(
                          "$errorMessage",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.green[900],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ) : pastBookings.length == 0 ? SingleChildScrollView(
                  child: Card(
                    margin: EdgeInsets.fromLTRB(20, 40, 20, 40),
                    color: Colors.grey[100],
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                        child: Text(
                          "No past bookings",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.green[900],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ) : 
                ListView.builder(
                  itemCount: pastBookings.length,
                  itemBuilder: (context, index) {
                    return PastBookingTile(uid:widget.uid, token:widget.token, pastBooking: pastBookings[index]);
                  }
                ),
            ),
          ],
        ),
      ),
    );
  }
}

class PastBookingTile extends StatelessWidget {
  final String uid;
  final String token;
  final BusBookingData pastBooking;
  PastBookingTile({this.uid, this.token, this.pastBooking});

  final SharedFunctions sharedFunctions = SharedFunctions();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[200],
      margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
      child: Column(
        children: <Widget>[
          SizedBox(height: 15.0),
          ListTile(
            title: Text(
              '${pastBooking.busNumber} - ${pastBooking.startStation} to ${pastBooking.endStation}',
            ),
            subtitle: Text(
              '${sharedFunctions.formatDateTime(sharedFunctions.getDateTime(pastBooking.departureTime))} to ${sharedFunctions.formatDateTime(sharedFunctions.getDateTime(pastBooking.arrivalTime))}',
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            title: Text(
              'Seat number ${pastBooking.seatId} - LKR ${pastBooking.price}',
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          ListTile(
            title: Text(
              'Conductor contact number',
              style: TextStyle(fontSize: 20.0),
            ),
            subtitle: Text(
              pastBooking.conductorContact,
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 15.0),
        ],
      ),
    );
  }             
}