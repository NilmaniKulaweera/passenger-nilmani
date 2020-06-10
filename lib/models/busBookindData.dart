class BusBookingData {
  String bookingId;
  String busNumber;
  String busType;
  String startStation;
  Map<String, dynamic> departureTime;
  String endStation;
  Map<String, dynamic> arrivalTime;
  String seatId;
  int price;
  String paymentId;
  String conductorContact;

  BusBookingData({
    this.bookingId, 
    this.busNumber, 
    this.busType,
    this.startStation,
    this.departureTime,
    this.endStation,
    this.arrivalTime,
    this.seatId,
    this.price,
    this.paymentId,
    this.conductorContact
  });

  factory BusBookingData.fromJson(Map<String,dynamic> booking)  {
    return BusBookingData(
      bookingId: booking['bookingid'],
      busNumber: booking['busNo'],
      busType: booking['bustype'],
      startStation: booking['startStation'], 
      departureTime: booking['departureTime'],
      endStation: booking['endStation'],
      arrivalTime: booking['arrivalTime'],
      seatId: booking['seatId'],
      price: booking['price'],
      paymentId: booking['paymentId'],
      conductorContact: booking['conductor_contact'],
    );
  }
}