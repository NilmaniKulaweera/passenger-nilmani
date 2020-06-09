import 'package:flutter/material.dart';
import 'package:transport_booking_system_passenger_mobile/controllers/authController.dart';
import 'package:transport_booking_system_passenger_mobile/models/apiResponse.dart';

class PaymentSuccessPage extends StatefulWidget {
  final String uid;
  final String token;
  final String startingDestination;
  final String endingDestination;
  final String tripId;
  final List<int> selectedSeatNumbers;
  final int totalPrice;
  final String payerID;
  final String paymentID;
  PaymentSuccessPage({this.uid, this.token, this.startingDestination, this.endingDestination, this.tripId, this.selectedSeatNumbers, this.totalPrice, this.payerID, this.paymentID});

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
      widget.tripId, 
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
                Container(
                  alignment: Alignment.topRight,
                  child: FlatButton.icon(
                    icon: Icon(Icons.refresh),
                    label: Text(
                      'Refresh',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    onPressed: () async {
                      // to load all th bus details and the trip details again
                      _bookSeats();
                    },
                  ),
                ),
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
                  Navigator.of(context).pop();
                }
              )
            ],
          ),
        ),
      )
    );
  }
}