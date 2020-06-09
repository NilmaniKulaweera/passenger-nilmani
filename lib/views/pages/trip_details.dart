import 'package:flutter/material.dart';
import 'package:transport_booking_system_passenger_mobile/controllers/authController.dart';
import 'package:transport_booking_system_passenger_mobile/models/apiResponse.dart';
import 'package:transport_booking_system_passenger_mobile/models/busTripData.dart';
import 'package:intl/intl.dart';
import 'package:transport_booking_system_passenger_mobile/views/pages/bus_layout_wrapper.dart';

class TripDetails extends StatefulWidget {
  final String uid;
  final String token;
  final String routeId;
  final String startingDestination;
  final String endingDestination;
  TripDetails({this.uid, this.token, this.routeId,  this.startingDestination, this.endingDestination});

  @override
  _TripDetailsState createState() => _TripDetailsState();
}

class _TripDetailsState extends State<TripDetails> {
  final AuthController _auth = AuthController();
  APIResponse<List<BusTripData>> _apiResponse;
  bool _isLoading;
  List<BusTripData> trips; 
  String errorMessage;

  @override
  void initState() {
    _fetchTripDetails();
    super.initState();
  }

  _fetchTripDetails() async {
    setState(() { _isLoading = true; });
    _apiResponse = await _auth.getTurns(widget.routeId);
    setState(() { 
      if (_apiResponse.error){
        _isLoading = false; 
        errorMessage = _apiResponse.errorMessage;
      } else {
        _isLoading = false; 
        trips = _apiResponse.data;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        title: Text(
          'Trip Details',
          style: TextStyle(
            color: Colors.white
          ),
        )
      ),
      body: Container(
        child: _isLoading? Center(child: CircularProgressIndicator()) : 
        _apiResponse.error? Center(
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
        ) : 
        ListView.builder(
          itemCount: trips.length,
          itemBuilder: (context, index) {
            return TripTile(
              uid:widget.uid, 
              token:widget.token, 
              trip: trips[index],
              startingDestination: widget.startingDestination,
              endingDestination: widget.endingDestination,
            );
          }
        ),
      ),
    );
  }
}

class TripTile extends StatelessWidget {
  final String uid;
  final String token;
  final BusTripData trip;
  final String startingDestination;
  final String endingDestination;
  TripTile({this.uid, this.token, this.trip, this.startingDestination, this.endingDestination});

  _formatDateTime(String dateTime) {
    DateTime dt = DateTime.parse(dateTime);
    dt = dt.add(Duration(hours: 5,minutes: 30));
    String date = DateFormat.yMd().format(dt);
    String time = DateFormat.jm().format(dt);
    return ('$date at $time');
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[200],
      margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
      child: Column(
        children: <Widget>[
          SizedBox(height: 15.0),
          ListTile(
            leading: Icon(
              Icons.airport_shuttle,
              color: Colors.grey[700],
            ),
            title: Text(
              '${trip.startStation} to ${trip.endStation}',
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          ListTile(
            title: Text(
              'Departure Date and Time',
              style: TextStyle(fontSize: 20.0),
            ),
            subtitle: Text(
              _formatDateTime(trip.departureTime),
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            title: Text(
              'Arrival Date and Time',
              style: TextStyle(fontSize: 20.0),
            ),
            subtitle: Text(
              _formatDateTime(trip.arrivalTime),
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            title: Text(
              'Bus Type',
              style: TextStyle(fontSize: 20.0),
            ),
            subtitle: Text(
              'LKR ${trip.busType}',
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            title: Text(
              'Normal Seat Price',
              style: TextStyle(fontSize: 20.0),
            ),
            subtitle: Text(
              'LKR ${trip.normalSeatPrice.toString()}',
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
          ),
          FlatButton.icon( 
            label: Text(
              'View Bookings',
              style: TextStyle(fontSize: 20.0),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5)
            ),
            color: Colors.green[700],
            textColor: Colors.white,
            icon: Icon(Icons.dashboard),
            onPressed: () { 
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => BusLayoutWrapper(
                  uid: uid, token: token, 
                  seatPrice: trip.normalSeatPrice, 
                  busType: trip.busType,
                  startingDestination: startingDestination,
                  endingDestination: endingDestination,
                  trip: trip,
                )
              ));   
            },
          ),
          SizedBox(height: 15.0),
        ],
      ),
    );
  }             
}