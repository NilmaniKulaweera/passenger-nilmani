class BusTripData {
  String tripId;
  String departureTime;
  String startStation;
  String arrivalTime;
  String endStation;
  int normalSeatPrice;
  String busType;

  BusTripData({
    this.tripId, 
    this.departureTime,
    this.startStation,
    this.arrivalTime,
    this.endStation,
    this.normalSeatPrice,
    this.busType
  });

  factory BusTripData.fromJson(Map<String,dynamic> trip)  {
    return BusTripData(
      tripId: trip['turnId'],
      departureTime: trip['departureTime'],
      startStation: trip['startStation'], 
      arrivalTime: trip['arrivalTime'],
      endStation: trip['endStation'],
      normalSeatPrice: trip['NormalSeatPrice'],
      busType: trip['busType'],
    );
  }
}