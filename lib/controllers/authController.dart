import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:transport_booking_system_passenger_mobile/models/apiResponse.dart';
import 'package:transport_booking_system_passenger_mobile/models/userData.dart';
import 'package:transport_booking_system_passenger_mobile/constants.dart';
import 'package:transport_booking_system_passenger_mobile/models/newUserRegister.dart';
import 'dart:convert';
import 'package:transport_booking_system_passenger_mobile/models/busSeat.dart';
import 'package:transport_booking_system_passenger_mobile/models/busTripData.dart';
import 'package:transport_booking_system_passenger_mobile/models/route.dart';

class AuthController {
  
  Future<APIResponse<String>> registerPassenger(NewUserRegister newUserModel) async {
    String url = Constants.SERVER + '/signup';
    String phoneNumberSend = "+94" + newUserModel.phoneNumber.toString().substring(1);
    var body = jsonEncode(<String, String>{
      "firstName": newUserModel.firstName,
      "secondName": newUserModel.secondName,
      "email": newUserModel.email,
      "password": newUserModel.password,
      "phoneNumber": phoneNumberSend,
      "role": newUserModel.role
    });
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json'
    };
    return http.post(
      url,
      headers: headers,
      body: body
    ).then((response){
      if(response.statusCode == 200) {
        Map<String, dynamic> message = jsonDecode(response.body);
        return APIResponse<String>(data: message["message"]);
      } else {
        final error = jsonDecode(response.body);
        return APIResponse<String>(error: true, errorMessage: error['error']);
      }
    }).
    catchError((error) => APIResponse<String> (error: true, errorMessage: 'An error occured')); 
  }

  Future<APIResponse<UserData>> signInPassenger(String email, String password) async {
    // sign in the passenger when the email and password is given
    String url = Constants.SERVER;
    return http.post(
      '$url/signin',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password
      })
    ).then ((response) {
        print ('status code' + response.statusCode.toString());
        if(response.statusCode == 200) {
          Map<String, dynamic> data = jsonDecode(response.body);
          // convert the response to a custom user object
          if (UserData.fromJson(data).role == "PASSENGER") { 
            print (UserData.fromJson(data).uid);
            print (UserData.fromJson(data).phoneNumber);
            print (UserData.fromJson(data).role);
            return APIResponse<UserData>(data: UserData.fromJson(data)); 
          } else {
            return APIResponse<UserData>(error: true, errorMessage: 'Not a valid passenger');
          }
        }
        if(response.statusCode == 400) {
          final error = jsonDecode(response.body);
          return APIResponse<UserData>(error: true, errorMessage: error['error']);
        }
        return APIResponse<UserData>(error: true, errorMessage: 'An error occured');
      }).
      catchError((error) => APIResponse<UserData> (error: true, errorMessage: 'An error occured')); 
  }

  Future<APIResponse<List<List<RouteData>>>> getRoutes(String startingStation, String endingStation, String date) async {
    // get the current and upcoming active turns assigned to the conductor
    String url = Constants.SERVER;
    List<List<RouteData>> fullRoute = [];
    List<RouteData> partialRoute = [];
    print ('dateee');
    print (date);
    return http.post(
      '$url/getroute',
      
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'origin': startingStation,
        'destination': endingStation,
        'date': date,
      })
    ).then ((response) {
      if(response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        for(var i=0; i<data["routes"]["steps"].length; i++){
          for(var j=0; j<data["routes"]["steps"][i].length; j++){
            partialRoute.add(RouteData.fromJson(data["routes"]["steps"][i][j]));
          }
          fullRoute.add(partialRoute);
          partialRoute = [];
        }
        return APIResponse<List<List<RouteData>>>(data: fullRoute);
      } 
      if(response.statusCode == 400) {
        final error = jsonDecode(response.body);
        return APIResponse<List<List<RouteData>>>(error: true, errorMessage: error['error']);
      }
      if(response.statusCode == 404) {
        final error = jsonDecode(response.body);
        return APIResponse<List<List<RouteData>>>(error: true, errorMessage: error['message']);
      }
      if(response.statusCode == 422) {
        final error = jsonDecode(response.body);
        return APIResponse<List<List<RouteData>>>(error: true, errorMessage: error['error']);
      }
      return APIResponse<List<List<RouteData>>>(error: true, errorMessage: 'An error occured');
    }).
    catchError((error) => APIResponse<List<List<RouteData>>>(error: true, errorMessage: 'An error occured'));
  }

  Future<APIResponse<List<BusTripData>>> getTurns(String routeId) async {
    // get the details of the passenger who booked a particular seat
    String url = Constants.SERVER;
    List<BusTripData> turns = [];

    return http.post(
      '$url/getturnbyroute',
      
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'routeId': routeId,
      })
    ).then ((response) {
      if(response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        if (data["turns"] != null && data["turns"].length > 0){
          for(var i=0; i<data["turns"].length;i++){
            turns.add(BusTripData.fromJson(data["turns"][i]));
          }
          return APIResponse<List<BusTripData>>(data: turns);
        } else {
          return APIResponse<List<BusTripData>>(error: true, errorMessage: "No turns");
        }
      } 
      if(response.statusCode == 400) {
        final error = jsonDecode(response.body);
        return APIResponse<List<BusTripData>>(error: true, errorMessage: error['error']);
      }
      return APIResponse<List<BusTripData>>(error: true, errorMessage: 'An error occured');
    }).
    catchError((error) => APIResponse<List<BusTripData>>(error: true, errorMessage: 'An error occured'));
  }

  // APIResponse<List<BusTripData>> getBusTripDetails(String startingDestination, String endingDestination, String journeyDate) {
  //   // get the details of the buses when the starting city, ending destination, and journey date is given 
  //   List<BusSeat> busSeatDetails = [
  //     BusSeat(seatID: '1',booked: true),
  //     BusSeat(seatID: '2',booked: true),
  //     BusSeat(seatID: '3',booked: true),
  //     BusSeat(seatID: '4',booked: true),
  //     BusSeat(seatID: '5',booked: true),
  //     BusSeat(seatID: '6',booked: false),
  //     BusSeat(seatID: '7',booked: true),
  //     BusSeat(seatID: '8',booked: true),
  //     BusSeat(seatID: '9',booked: true),
  //     BusSeat(seatID: '10',booked: true),
  //     BusSeat(seatID: '11',booked: false),
  //     BusSeat(seatID: '12',booked: true),
  //     BusSeat(seatID: '13',booked: true),
  //     BusSeat(seatID: '14',booked: true),
  //     BusSeat(seatID: '15',booked: false),
  //     BusSeat(seatID: '16',booked: true),
  //     BusSeat(seatID: '17',booked: true),
  //     BusSeat(seatID: '18',booked: true),
  //     BusSeat(seatID: '19',booked: true),
  //     BusSeat(seatID: '20',booked: true),
  //     BusSeat(seatID: '21',booked: true),
  //     BusSeat(seatID: '22',booked: true),
  //     BusSeat(seatID: '23',booked: true),
  //     BusSeat(seatID: '24',booked: true),
  //     BusSeat(seatID: '25',booked: true),
  //     BusSeat(seatID: '26',booked: true),
  //     BusSeat(seatID: '27',booked: true),
  //     BusSeat(seatID: '28',booked: true),
  //     BusSeat(seatID: '29',booked: true),
  //     BusSeat(seatID: '30',booked: true),
  //     BusSeat(seatID: '31',booked: true),
  //     BusSeat(seatID: '32',booked: true),
  //     BusSeat(seatID: '33',booked: true),
  //     BusSeat(seatID: '34',booked: true),
  //     BusSeat(seatID: '35',booked: true),
  //     BusSeat(seatID: '36',booked: true),
  //     BusSeat(seatID: '37',booked: true),
  //     BusSeat(seatID: '38',booked: true),
  //     BusSeat(seatID: '39',booked: true),
  //     BusSeat(seatID: '40',booked: true),
  //     BusSeat(seatID: '41',booked: true),
  //     BusSeat(seatID: '42',booked: true),
  //     BusSeat(seatID: '43',booked: true),
  //     BusSeat(seatID: '44',booked: true),
  //     BusSeat(seatID: '45',booked: true),
  //     BusSeat(seatID: '46',booked: false),
  //     BusSeat(seatID: '47',booked: true),
  //     BusSeat(seatID: '48',booked: false),
  //     BusSeat(seatID: '49',booked: true),
  //     BusSeat(seatID: '50',booked: true),
  //     BusSeat(seatID: '51',booked: false),
  //     BusSeat(seatID: '52',booked: true),
  //     BusSeat(seatID: '53',booked: false),
  //     BusSeat(seatID: '54',booked: true),
  //   ];

  //   List<BusTripData> buses = [
  //     BusTripData(
  //       busNumber: 'NA1023', 
  //       busType: 'Type1', 
  //       routeNumber: '87/759',
  //       startingDestination: 'Colombo',
  //       endingDestination: "Jaffna",
  //       startingDateTime: '10 May - 8.00am',
  //       endingDateTime: '10 May - 5.00pm',
  //       seatPrice: 1700,
  //       busSeatDetails: busSeatDetails.sublist(0,49),
  //     ),
  //     BusTripData(
  //       busNumber: 'NA2323', 
  //       busType: 'Type2', 
  //       routeNumber: '87/759',
  //       startingDestination: 'Colombo',
  //       endingDestination: "Jaffna",
  //       startingDateTime: '10 May - 11.00am',
  //       endingDateTime: '10 May - 8.00pm',
  //       seatPrice: 1500,
  //       busSeatDetails: busSeatDetails.sublist(0,30),
  //     ),
  //     BusTripData(
  //       busNumber: 'NA3523', 
  //       busType: 'Type3', 
  //       routeNumber: '87/759',
  //       startingDestination: 'Colombo',
  //       endingDestination: "Jaffna",
  //       startingDateTime: '10 May - 5.00pm',
  //       endingDateTime: '11 May - 2.00am',
  //       seatPrice: 1000,
  //       busSeatDetails: busSeatDetails,
  //     ),
  //     BusTripData(
  //       busNumber: 'NA4623', 
  //       busType: 'Type4', 
  //       routeNumber: '87/759',
  //       startingDestination: 'Colombo',
  //       endingDestination: "Jaffna",
  //       startingDateTime: '10 May - 10.00pm',
  //       endingDateTime: '11 May - 7.00am',
  //       seatPrice: 1000,
  //       busSeatDetails: busSeatDetails.sublist(0,44),
  //     ),
  //   ];
  //   return APIResponse<List<BusTripData>>(data: buses); 
  // }
}

