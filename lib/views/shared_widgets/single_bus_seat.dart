import 'package:flutter/material.dart';
import 'package:transport_booking_system_passenger_mobile/models/busSeat.dart';

class SingleBusSeat extends StatefulWidget {
  final int index;
  final List<BusSeat> busSeatDetails;
  final int count;
  final List<int> selectedSeatNumbers;
  final Function(int) callBackIncrease;
  final Function(int) callBackDecrease;
  SingleBusSeat({this.index, this.busSeatDetails, this.count, this.selectedSeatNumbers, this.callBackIncrease, this.callBackDecrease});

  @override
  _SingleBusSeatState createState() => _SingleBusSeatState();
}

class _SingleBusSeatState extends State<SingleBusSeat> {
  bool pressAttention = false;

  @override
  Widget build(BuildContext context) { 
    return Container(
      margin:EdgeInsets.symmetric(horizontal:10.0,vertical: 5.0),
      child: FlatButton(
        padding: const EdgeInsets.all(0),
        child: Center(
          child: Text(
            widget.busSeatDetails[widget.index].seatID,
            style: TextStyle(color: Colors.grey[900]),
          )
        ),
        color: widget.busSeatDetails[widget.index].status == "Unavailable" ? Colors.green[500] : (pressAttention ? Colors.grey[700] : Colors.amber[400]),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5)
        ),
        onPressed: () async {
          print (widget.count);
          if (widget.busSeatDetails[widget.index].status == "Unavailable") {
            final result = await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('This seat is already booked'),
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
            setState(() async {
              pressAttention = !pressAttention;
              if (pressAttention) {
                widget.callBackIncrease(widget.index+1);
              } else {
                widget.callBackDecrease(widget.index+1);
              }
            });   
          }
        }, 
      ),
    );
  }
}
