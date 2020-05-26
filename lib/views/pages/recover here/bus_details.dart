// import 'package:flutter/material.dart';

// class BusDetails extends StatefulWidget {
//   final String uid;
//   BusDetails({this.uid});

//   @override
//   _BusDetailsState createState() => _BusDetailsState();
// }

// class _BusDetailsState extends State<BusDetails> {

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.all(20.0),
//       child: Column(
//         children: <Widget>[
//           Card(
//             child:Column(
//               children: <Widget>[
//                 ListTile(
//                   title: Text(
//                     'KSK Travels',
//                     style: TextStyle(fontSize: 18.0),
//                   ),
//                 ),
//                 ListTile(
//                   title: Text(
//                     '6.00 AM - 9.00 AM',
//                     style: TextStyle(fontSize: 16.0),
//                   ),
//                   subtitle: Text(
//                     'luxury',
//                     style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 ListTile(
//                   title: Text(
//                     'Bus Number: NA-4521',
//                     style: TextStyle(fontSize: 15.0),
//                   ),
//                   subtitle: Text(
//                     'Route-1',
//                     style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 ListTile(
//                   title: Text(
//                     'LKR 350',
//                     style: TextStyle(fontSize: 15.0),
//                   ),
//                 ),
//                 FlatButton(
//                   child: Text("View Seats"),
//                   color: Colors.green[900],
//                   textColor: Colors.white,
//                   padding: EdgeInsets.only(left: 38, right: 38, top: 15, bottom: 15),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
//                   onPressed: () {},
//                 ),
//               ], 
//             ),
//           ),
//           Card(
//             child: Column(
//               children: <Widget>[
//                 ListTile(
//                   title: Text(
//                     'AB Travels',
//                     style: TextStyle(fontSize: 18.0),
//                   ),
//                 ),
//                 ListTile(
//                   title: Text(
//                     '7.00 AM - 11.00 AM',
//                     style: TextStyle(fontSize: 16.0),
//                   ),
//                   subtitle: Text(
//                     'semi-luxury',
//                     style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 ListTile(
//                   title: Text(
//                     'Bus Number: N/A',
//                     style: TextStyle(fontSize: 15.0),
//                   ),
//                   subtitle: Text(
//                     'Route-8',
//                     style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 ListTile(
//                   title: Text(
//                     'LKR 260',
//                     style: TextStyle(fontSize: 15.0),
//                   ),
//                 ),
//                 FlatButton(
//                   child: Text("View Seats"),
//                   color: Colors.green[900],
//                   textColor: Colors.white,
//                   padding: EdgeInsets.only(left: 38, right: 38, top: 15, bottom: 15),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
//                   onPressed: () {},
//                 ),
//               ],
//             ),
//           ),
//           Card(
//             child: Column(
//               children: <Widget>[
//                 ListTile(
//                   title: Text(
//                     'Hiru Tours',
//                     style: TextStyle(fontSize: 18.0),
//                   ),
//                 ),
//                 ListTile(
//                   title: Text(
//                     '8.00 AM - 2.00 PM',
//                     style: TextStyle(fontSize: 16.0),
//                   ),
//                   subtitle: Text(
//                     'semi-luxury',
//                     style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 ListTile(
//                   title: Text(
//                     'Bus Number: NC-9438',
//                     style: TextStyle(fontSize: 15.0),
//                   ),
//                   subtitle: Text(
//                     'Route-16',
//                     style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 ListTile(
//                   title: Text(
//                     'LKR 320',
//                     style: TextStyle(fontSize: 15.0),
//                   ),
//                 ),
//                 FlatButton(
//                   child: Text("View Seats"),
//                   color: Colors.green[900],
//                   textColor: Colors.white,
//                   padding: EdgeInsets.only(left: 38, right: 38, top: 15, bottom: 15),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
//                   onPressed: () {},
//                 ),
//               ],    
//             ),
//           ),
//         ],
//       ), 
//     );
//   } 
// }
