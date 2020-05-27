import 'package:flutter/material.dart';
import 'package:transport_booking_system_passenger_mobile/controllers/authController.dart';
import 'package:transport_booking_system_passenger_mobile/models/apiResponse.dart';
import 'package:transport_booking_system_passenger_mobile/models/busTripData.dart';

class TripDetails extends StatefulWidget {
  final String routeId;
  TripDetails({this.routeId});

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
        ) : Card(
          child: Text(trips.length.toString()), //show a single card for each turn
        ),
      ),
    );
  }
}