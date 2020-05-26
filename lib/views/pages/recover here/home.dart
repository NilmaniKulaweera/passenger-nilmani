// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:transport_booking_system_passenger_mobile/views/pages/auth.dart';
// import 'package:transport_booking_system_passenger_mobile/views/shared_widgets/page_widget.dart';
// import 'package:transport_booking_system_passenger_mobile/views/pages/bus_details.dart';

// class Home extends StatefulWidget {
//   @override
//   _HomeState createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   String stateCard;
 
//   SharedPreferences sharedPreferences;
//   String uid;
//   bool _isLoading = true;

//   @override
//   void initState() { 
//     checkLoginStatus();
//     super.initState();
//   }

//   checkLoginStatus() async {
//     sharedPreferences = await SharedPreferences.getInstance();
//     if(sharedPreferences.getString("token") == null){
//       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage())); // if user is not logged in navigate to sign in page
//     } else {
//       setState(() { _isLoading = true; });
//       uid = sharedPreferences.getString("uid");
//       print(uid);
//       setState(() { _isLoading = false; });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return _isLoading? Center(child: CircularProgressIndicator()) : Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.green[900],
//         title: PageTitleHomePage(),
//         actions: <Widget>[
//           FlatButton(
//             child: Text(
//               "Log Out",
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 18.0,
//               ),
//             ),
//             onPressed: () {
//               sharedPreferences.clear();
//               Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
//             },
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: <Widget>[
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: <Widget>[
//                 Container(
//                   width: 150.0,
//                   child: TextField(
//                     textAlign: TextAlign.left,
//                     decoration: InputDecoration(
//                       labelText: "Starting"
//                     ),
//                   ),
//                   alignment: Alignment(10, 12),
//                 ),
//                 Container(
//                   width: 150.0,
//                   child: TextField(
//                     textAlign: TextAlign.left,
//                     decoration: InputDecoration(
//                       labelText: "Destination"
//                     ),
//                   ),
//                   alignment: Alignment(10, 24),
//                 ),
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: <Widget>[
//                 FlatButton(
//                   child: Text(
//                     "Search",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18.0,
//                     ),
//                   ),
//                   color: Colors.green[900],
//                   onPressed: () {
//                     setState(() {
//                       this.stateCard = "done";
//                     });    
//                   },
//                 ),
//               ],
//             ),
//             Container(
//               child: stateCard == "done" ? BusDetails(uid: uid) : Text(""),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
