import 'package:flutter/material.dart';
import 'package:transport_booking_system_passenger_mobile/models/busSeat.dart';
import 'package:transport_booking_system_passenger_mobile/views/pages/bus_book.dart';
import 'package:transport_booking_system_passenger_mobile/views/pages/bus_layouts/bus_layout1.dart';
import 'package:transport_booking_system_passenger_mobile/views/pages/bus_layouts/bus_layout2.dart';
import 'package:transport_booking_system_passenger_mobile/views/pages/bus_layouts/bus_layout3.dart';
import 'package:transport_booking_system_passenger_mobile/views/pages/bus_layouts/bus_layout4.dart';

class BusLayoutWrapper extends StatefulWidget {
  final int seatPrice;
  final String busType;
  final List<BusSeat>  busSeatDetails;
  BusLayoutWrapper({this.seatPrice, this.busType,this.busSeatDetails});

  @override
  _BusLayoutWrapperState createState() => _BusLayoutWrapperState();
}

class _BusLayoutWrapperState extends State<BusLayoutWrapper> {
  int count = 0;
  List<int> selectedSeatNumbers = [];
  int availableSeats = 0;

  countAvailableSeats() {
    for(var i=0; i<widget.busSeatDetails.length;i++){
      if (!widget.busSeatDetails[i].booked) {
        availableSeats = availableSeats + 1;
      }
    }
  }

  callBackIncrease(seatNumber) {
    setState(() {
      count = count + 1;
      selectedSeatNumbers.add(seatNumber);
    });
  }

  callBackDecrease(seatNumber) {
    setState(() {
      count = count - 1;
      selectedSeatNumbers.remove(seatNumber);
    });
  }

  @override
  void initState() {
    countAvailableSeats();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      Widget layout; // return the layout according to the type of the bus
      if (widget.busType == "Type1"){
        layout = BusLayout1(busSeatDetails: widget.busSeatDetails, count: count, selectedSeatNumbers: selectedSeatNumbers, callBackIncrease: callBackIncrease, callBackDecrease: callBackDecrease);
      }
      if (widget.busType == "Type2"){
        layout = BusLayout2(busSeatDetails: widget.busSeatDetails, count: count, selectedSeatNumbers: selectedSeatNumbers, callBackIncrease: callBackIncrease, callBackDecrease: callBackDecrease);
      }
      if (widget.busType == "Type3"){
        layout = BusLayout3(busSeatDetails: widget.busSeatDetails, count: count, selectedSeatNumbers: selectedSeatNumbers, callBackIncrease: callBackIncrease, callBackDecrease: callBackDecrease);
      }
      if (widget.busType == "Type4"){
        layout = BusLayout4(busSeatDetails: widget.busSeatDetails, count: count, selectedSeatNumbers: selectedSeatNumbers, callBackIncrease: callBackIncrease, callBackDecrease: callBackDecrease);
      }
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[900],
          title: Text(
            'Book Bus',
            style: TextStyle(
              color: Colors.white
            ),
          )
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Menu()
            ),
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration( 
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Colors.grey[400], 
                ),
                width: double.infinity,
                margin: EdgeInsets.all(10.0),
                child: Center(
                  child: Text(
                    'Front', 
                    textAlign: TextAlign.center, 
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.grey[700],
                    ),
                  )
                )
              ),
            ),
            Expanded(
              flex: 8,
              child: layout,
            ),
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.all(10.0),
                child: Center(
                  child: FlatButton(
                    child: Text(
                      "Book Now",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                    color: Colors.green[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)
                    ),
                    onPressed: () async {
                      if (count < 5 && count > 0) {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => BusBook(
                          count: count, 
                          selectedSeatNumbers: selectedSeatNumbers,
                          busType: widget.busType,
                          seatPrice: widget.seatPrice,
                        )));
                      } else if (count == 0) {
                        final result = await showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('You should book at least one seat'),
                            actions: <Widget>[
                              FlatButton(
                                child: Text(
                                  'OK',
                                  style: TextStyle(
                                    color: Colors.green[700],
                                    fontSize: 15.0,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                        );
                        return result;
                      } else {
                        final result = await showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('You can book maximum 4 seats'),
                            actions: <Widget>[
                              FlatButton(
                                child: Text(
                                  'OK',
                                  style: TextStyle(
                                    color: Colors.green[700],
                                    fontSize: 15.0,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                        );
                        return result;
                      }
                    },
                  ),
                ),
              ),
            ),
            // show 'add to waiting list' only if less than 4 seats are available
            availableSeats > 3 ? SizedBox(height: 20) : Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.all(10.0),
                child: Center(
                  child: FlatButton(
                    child: Text(
                      "Add To Waiting List",
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
                      // Navigate to 'add to waiting list' page
                    },
                  ),
                )
              ),
            ),
          ],
        ),
      );
  }
}

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration( 
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: Colors.green[500], 
                    ),
                    margin: EdgeInsets.fromLTRB(20.0,0.0,20.0,0),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration( 
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: Colors.amber[400], 
                    ),
                    margin: EdgeInsets.fromLTRB(20.0,0.0,20.0,0),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration( 
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: Colors.grey[700], 
                    ),
                    margin: EdgeInsets.fromLTRB(20.0,0.0,20.0,0),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Container(
                    child: Text(
                      'Booked', 
                      textAlign: TextAlign.center, 
                      style: TextStyle(
                        fontSize: 15.0
                      ),
                    )
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    child: Text(
                      'Available', 
                      textAlign: TextAlign.center, 
                      style: TextStyle(
                        fontSize: 15.0
                      ),
                    )
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    child: Text(
                      'Selected', 
                      textAlign: TextAlign.center, 
                      style: TextStyle(
                        fontSize: 15.0
                      ),
                    )
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}