import 'package:transport_booking_system_passenger_mobile/models/busSeat.dart';

class BusTripData {
  String busNumber;
  String busType;
  String routeNumber;
  String startingDestination;
  String endingDestination;
  String startingDateTime;
  String endingDateTime;
  int seatPrice;
  List<BusSeat> busSeatDetails;

  BusTripData({
    this.busNumber, 
    this.busType, 
    this.routeNumber,
    this.startingDestination,
    this.endingDestination,
    this.startingDateTime,
    this.endingDateTime,
    this.seatPrice,
    this.busSeatDetails
  });

}