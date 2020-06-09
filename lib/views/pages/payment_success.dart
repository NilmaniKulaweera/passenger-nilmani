import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:transport_booking_system_passenger_mobile/controllers/authController.dart';
import 'package:transport_booking_system_passenger_mobile/models/apiResponse.dart';
import 'package:transport_booking_system_passenger_mobile/models/busTripData.dart';

class PaymentSuccessPage extends StatefulWidget {
  final String uid;
  final String token;
  final String startingDestination;
  final String endingDestination;
  final BusTripData trip;
  final List<int> selectedSeatNumbers;
  final int totalPrice;
  final String payerID;
  final String paymentID;
  PaymentSuccessPage({this.uid, this.token, this.startingDestination, this.endingDestination, this.trip, this.selectedSeatNumbers, this.totalPrice, this.payerID, this.paymentID});

  @override
  _PaymentSuccessPageState createState() => _PaymentSuccessPageState();
}

class _PaymentSuccessPageState extends State<PaymentSuccessPage> {
  final AuthController _auth = AuthController();
  APIResponse<String> _apiResponse;
  bool _isLoading;
  String successMessage;
  String errorMessage;

  @override
  void initState() {
    _bookSeats();
    super.initState();
  }

  _bookSeats() async {
    setState(() { _isLoading = true; });
    _apiResponse = await _auth.bookSeats(
      widget.uid, 
      widget.token, 
      widget.trip.tripId, 
      widget.startingDestination,
      widget.endingDestination,
      widget.selectedSeatNumbers,
      widget.payerID,
      widget.paymentID
    );
    setState(() { 
      _isLoading = false; 
      if (_apiResponse.error){
        errorMessage = _apiResponse.errorMessage;
      } else {
        successMessage = _apiResponse.data;
      }
    });
  }

  _formatDateTime(String dateTime) {
    DateTime dt = DateTime.parse(dateTime);
    dt = dt.add(Duration(hours: 5,minutes: 30));
    String date = DateFormat.yMd().format(dt);
    String time = DateFormat.jm().format(dt);
    return ('$date at $time');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        title: Text(
          'Payment Success',
          style: TextStyle(
            color: Colors.white
          ),
        )
      ),
      body: _isLoading? Center(child: CircularProgressIndicator()) : 
        SingleChildScrollView(
          child: _apiResponse.error? Card(
            margin: EdgeInsets.fromLTRB(20, 40, 20, 40),
            color: Colors.grey[100],
            child: Column(
              children: <Widget>[
                Center(
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
              ],
            ),
          ) : Card(
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text(
                  'Start Station',
                  style: TextStyle(fontSize: 20.0),
                ),
                subtitle: Text(
                  widget.startingDestination, // get the nearest upcoming trip from the list
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                title: Text(
                  'End Station',
                  style: TextStyle(fontSize: 20.0),
                ),
                subtitle: Text(
                  widget.endingDestination, // get the nearest upcoming trip from the list
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                title: Text(
                  "Booked Seats",
                  style: TextStyle(fontSize: 20.0),
                ),
                subtitle: Text(
                  "${widget.selectedSeatNumbers}",
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                title: Text(
                  "Total Amount",
                  style: TextStyle(fontSize: 20.0),
                ),
                subtitle: Text(
                  "LKR ${widget.totalPrice}",
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                title: Text(
                  "Payment ID",
                  style: TextStyle(fontSize: 20.0),
                ),
                subtitle: Text(
                  "${widget.paymentID}",
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                title: Text(
                  "Turn Details",
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              ListTile(
                title: Text(
                  "Initial Departure Station",
                  style: TextStyle(fontSize: 20.0),
                ),
                subtitle: Text(
                  widget.trip.startStation,
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                title: Text(
                  "Departure Date and Time",
                  style: TextStyle(fontSize: 20.0),
                ),
                subtitle: Text(
                  _formatDateTime(widget.trip.departureTime),
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                title: Text(
                  "Final Arrival Station",
                  style: TextStyle(fontSize: 20.0),
                ),
                subtitle: Text(
                  widget.trip.endStation,
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                title: Text(
                  "Arrival Date and Time",
                  style: TextStyle(fontSize: 20.0),
                ),
                subtitle: Text(
                  _formatDateTime(widget.trip.arrivalTime),
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                ),
              ),
              FlatButton(
                child: Text(
                  "Go to main page",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
                color: Colors.green[900],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                }
              ),
              SizedBox(
                height: 15.0,
              )
            ],
          ),
        ),
      )
    );
  }
}