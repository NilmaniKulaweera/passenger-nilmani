import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';
import 'package:transport_booking_system_passenger_mobile/views/pages/PaypalPayment.dart';

class BusBook extends StatefulWidget {
  final int count;
  final List<int> selectedSeatNumbers;
  final String busType;
  final int totalPrice;
  final String startingDestination;
  final String endingDestination;
  final String tripId;
  BusBook({this.count, this.selectedSeatNumbers, this.busType, this.totalPrice, this.startingDestination, this.endingDestination, this.tripId});

  @override
  _BusBookState createState() => _BusBookState();
}

class _BusBookState extends State<BusBook> {
  final _formKey = GlobalKey<FormState>();
  String passengerName = '';
  String contactNumber = '';
  String boardingPlace = '';
  String destination = '';

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
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Passenger Name",
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        validator: (val) => val.isEmpty ? 'Enter your name' : null,
                        onChanged: (val) {
                          setState(() => passengerName = val);
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Contact Number",
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        validator: (val) => (isNumeric(val) && (val.length == 10)) ? null : 'Enter a valid contact number',
                        onChanged: (val) {
                          setState(() => contactNumber = val);
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          labelText: "Boarding Place",
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        validator: (val) => val.isEmpty ? 'Enter boarding station' : null,
                        onChanged: (val) {
                          setState(() => boardingPlace = val);
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          labelText: "Destination",
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        validator: (val) => val.isEmpty ? 'Enter destination' : null,
                        onChanged: (val) {
                          setState(() => destination = val);
                        },
                      ),
                    ],
                  ),
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
                  if (_formKey.currentState.validate()) {
                    // direct to the payment gateway
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => PaypalPayment(
                          onFinish: (number) async {
                            // payment done
                            print('order id: '+number);
                          },
                          startingDestination: widget.startingDestination,
                          endingDestination: widget.endingDestination,
                          tripId: widget.tripId,
                          selectedSeatNumbers: widget.selectedSeatNumbers
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}