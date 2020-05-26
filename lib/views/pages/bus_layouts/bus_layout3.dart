import 'package:flutter/material.dart';
import 'package:transport_booking_system_passenger_mobile/models/busSeat.dart';
import 'package:transport_booking_system_passenger_mobile/views/shared_widgets/single_bus_seat.dart';

class BusLayout3 extends StatefulWidget {
  final int count;
  final List<int> selectedSeatNumbers;
  final Function(int) callBackIncrease;
  final Function(int) callBackDecrease;
  final List<BusSeat> busSeatDetails;
  BusLayout3({this.busSeatDetails, this.count, this.selectedSeatNumbers, this.callBackIncrease, this.callBackDecrease});

  @override
  _BusLayout3State createState() => _BusLayout3State();
}

class _BusLayout3State extends State<BusLayout3> {

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
    for (var i = 0; i < 41; i = i+5) {
      children.add(Expanded(
        flex: 1,
        child: busRow(context, i),
      ));
    }
    children.add(Expanded(
      flex: 1,
      child: oneBeforeLastRow(context, 45),
    ));
    children.add(Expanded(
      flex: 1,
      child: lastRow(context, 48),
    ));
    return children;  
  }

  Widget busRow (BuildContext context, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(flex:1,child: SingleBusSeat(index: index, busSeatDetails: widget.busSeatDetails, count: widget.count, callBackIncrease: widget.callBackIncrease, callBackDecrease: widget.callBackDecrease)),
        Expanded(flex:1,child: SingleBusSeat(index: index+1, busSeatDetails: widget.busSeatDetails, count: widget.count, callBackIncrease: widget.callBackIncrease, callBackDecrease: widget.callBackDecrease)),
        Expanded(flex:1,child: SizedBox()),
        Expanded(flex:1,child: SingleBusSeat(index: index+2, busSeatDetails: widget.busSeatDetails, count: widget.count, callBackIncrease: widget.callBackIncrease, callBackDecrease: widget.callBackDecrease)),
        Expanded(flex:1,child: SingleBusSeat(index: index+3, busSeatDetails: widget.busSeatDetails, count: widget.count, callBackIncrease: widget.callBackIncrease, callBackDecrease: widget.callBackDecrease)),
        Expanded(flex:1,child: SingleBusSeat(index: index+4, busSeatDetails: widget.busSeatDetails, count: widget.count, callBackIncrease: widget.callBackIncrease, callBackDecrease: widget.callBackDecrease)),
      ],
    );
  }

  Widget oneBeforeLastRow (BuildContext context, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(flex:1,child: SizedBox()),
        Expanded(flex:1,child: SizedBox()),
        Expanded(flex:1,child: SizedBox()),
        Expanded(flex:1,child: SingleBusSeat(index: index, busSeatDetails: widget.busSeatDetails, count: widget.count, callBackIncrease: widget.callBackIncrease, callBackDecrease: widget.callBackDecrease)),
        Expanded(flex:1,child: SingleBusSeat(index: index+1, busSeatDetails: widget.busSeatDetails, count: widget.count, callBackIncrease: widget.callBackIncrease, callBackDecrease: widget.callBackDecrease)),
        Expanded(flex:1,child: SingleBusSeat(index: index+2, busSeatDetails: widget.busSeatDetails, count: widget.count, callBackIncrease: widget.callBackIncrease, callBackDecrease: widget.callBackDecrease)),
      ],
    );
  }

  Widget lastRow (BuildContext context, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(flex:1,child: SingleBusSeat(index: index, busSeatDetails: widget.busSeatDetails, count: widget.count, callBackIncrease: widget.callBackIncrease, callBackDecrease: widget.callBackDecrease)),
        Expanded(flex:1,child: SingleBusSeat(index: index+1, busSeatDetails: widget.busSeatDetails, count: widget.count, callBackIncrease: widget.callBackIncrease, callBackDecrease: widget.callBackDecrease)),
        Expanded(flex:1,child: SingleBusSeat(index: index+2, busSeatDetails: widget.busSeatDetails, count: widget.count, callBackIncrease: widget.callBackIncrease, callBackDecrease: widget.callBackDecrease)),
        Expanded(flex:1,child: SingleBusSeat(index: index+3, busSeatDetails: widget.busSeatDetails, count: widget.count, callBackIncrease: widget.callBackIncrease, callBackDecrease: widget.callBackDecrease)),
        Expanded(flex:1,child: SingleBusSeat(index: index+4, busSeatDetails: widget.busSeatDetails, count: widget.count, callBackIncrease: widget.callBackIncrease, callBackDecrease: widget.callBackDecrease)),
        Expanded(flex:1,child: SingleBusSeat(index: index+5, busSeatDetails: widget.busSeatDetails, count: widget.count, callBackIncrease: widget.callBackIncrease, callBackDecrease: widget.callBackDecrease)),
      ],
    );
  }
}