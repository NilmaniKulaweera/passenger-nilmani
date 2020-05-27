class RouteData {
  String routeName;
  String shortName;
  String departureStop;
  String arrivalStop;
  String status;
  dynamic routeId;

  RouteData({this.routeName, this.shortName, this.departureStop, this.arrivalStop, this.status, this.routeId});

  factory RouteData.fromJson(Map<String,dynamic> route)  {
    return RouteData(
      routeName: route['name'],
      shortName: route['short_name'],
      departureStop: route['departure_stop'],
      arrivalStop: route['arrival_stop'], 
      status: route['status'],
      // routeId: route['routeId'],
      routeId: "1 Colombo Kandy",
    );
  }
}