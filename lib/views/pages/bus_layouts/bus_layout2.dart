import 'package:flutter/material.dart';
import 'package:transport_booking_system_passenger_mobile/models/busSeat.dart';
import 'package:transport_booking_system_passenger_mobile/views/shared_widgets/single_bus_seat.dart';

class BusLayout2 extends StatefulWidget {
  final int count;
  final List<int> selectedSeatNumbers;
  final Function(int) callBackIncrease;
  final Function(int) callBackDecrease;
  final List<BusSeat> busSeatDetails;
  BusLayout2({this.busSeatDetails, this.count, this.selectedSeatNumbers, this.callBackIncrease, this.callBackDecrease});
  
  @override
  _BusLayout2State createState() => _BusLayout2State();
}

class _BusLayout2State extends State<BusLayout2> {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: generateExpanded(context),
      ),
    );
  }

  // create the bus layout
  List<Widget> generateExpanded(BuildContext context) {
    final children = <Widget>[];
    children.add(Expanded(
      flex: 1,
      child: firstRow(context, 0),
    ));
    for (var i = 2; i < 27; i = i+4) {
      children.add(Expanded(
        flex: 1,
        child: busRow(context, i),
      ));
    }
    return children; 
  }

  Widget firstRow (BuildContext context, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(flex:1,child: SizedBox()),
        Expanded(flex:1,child: SizedBox()),
        Expanded(flex:1,child: SingleBusSeat(index: index, busSeatDetails: widget.busSeatDetails, count: widget.count, callBackIncrease: widget.callBackIncrease, callBackDecrease: widget.callBackDecrease)),
        Expanded(flex:1,child: SingleBusSeat(index: index+1, busSeatDetails: widget.busSeatDetails, count: widget.count, callBackIncrease: widget.callBackIncrease, callBackDecrease: widget.callBackDecrease)),
      ],
    );
  }

  Widget busRow (BuildContext context, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(flex:1,child: SingleBusSeat(index: index, busSeatDetails: widget.busSeatDetails, count: widget.count, callBackIncrease: widget.callBackIncrease, callBackDecrease: widget.callBackDecrease)),
        Expanded(flex:1,child: SingleBusSeat(index: index+1, busSeatDetails: widget.busSeatDetails, count: widget.count, callBackIncrease: widget.callBackIncrease, callBackDecrease: widget.callBackDecrease)),
        Expanded(flex:1,child: SingleBusSeat(index: index+2, busSeatDetails: widget.busSeatDetails, count: widget.count, callBackIncrease: widget.callBackIncrease, callBackDecrease: widget.callBackDecrease)),
        Expanded(flex:1,child: SingleBusSeat(index: index+3, busSeatDetails: widget.busSeatDetails, count: widget.count, callBackIncrease: widget.callBackIncrease, callBackDecrease: widget.callBackDecrease)),
      ],
    );
  }
}