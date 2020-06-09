import 'package:flutter/material.dart';
import 'package:transport_booking_system_passenger_mobile/models/busTripData.dart';
import 'package:transport_booking_system_passenger_mobile/views/pages/PaypalPayment.dart';

class BusBook extends StatefulWidget {
  final String uid;
  final String token;
  final int count;
  final List<int> selectedSeatNumbers;
  final String busType;
  final int totalPrice;
  final String startingDestination;
  final String endingDestination;
  final BusTripData trip;
  BusBook({this.uid, this.token, this.count, this.selectedSeatNumbers, this.busType, this.totalPrice, this.startingDestination, this.endingDestination, this.trip});

  @override
  _BusBookState createState() => _BusBookState();
}

class _BusBookState extends State<BusBook> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        title: Text(
          'Book Bus',
          style: TextStyle(
            color: Colors.white
          ),
        )
      ),
      body: SingleChildScrollView(
        child: Card(
          color: Colors.grey[100],
          margin: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text(
                  "No of seats",
                  style: TextStyle(fontSize: 20.0),
                ),
                subtitle: Text(
                  "${widget.count}",
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                title: Text(
                  "Selected Seats",
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
                  'Start Station',
                  style: TextStyle(fontSize: 20.0),
                ),
                subtitle: Text(
                  widget.startingDestination,
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                title: Text(
                  'End Station',
                  style: TextStyle(fontSize: 20.0),
                ),
                subtitle: Text(
                  widget.endingDestination, 
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              FlatButton(
                child: Text(
                  "Click To Pay",
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
                    // direct to the payment gateway
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (BuildContext context) => PaypalPayment(
                          uid: widget.uid,
                          token: widget.token,
                          startingDestination: widget.startingDestination,
                          endingDestination: widget.endingDestination,
                          trip: widget.trip,
                          selectedSeatNumbers: widget.selectedSeatNumbers,
                          totalPrice: widget.totalPrice,
                        ),
                      ),
                    );
                },
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}