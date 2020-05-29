import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transport_booking_system_passenger_mobile/views/pages/auth.dart';
import 'package:transport_booking_system_passenger_mobile/views/shared_widgets/page_widget.dart';
import 'package:transport_booking_system_passenger_mobile/views/pages/route_details.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SharedPreferences sharedPreferences;
  String uid;
  String token;
  bool _isLoading = true;
  final _formKey = GlobalKey<FormState>();

  String startingDestination = '';
  String endingDestination = '';
  String journeyDate = DateTime.now().toString();

  DateTime selectedDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101)
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        journeyDate = selectedDate.toString();
      });
  }

  @override
  void initState() {
    checkLoginStatus();
    super.initState();
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") == null) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => LoginPage()
      )); // if user is not logged in navigate to sign in page
    } else {
      setState(() {
        _isLoading = true;
      });
      uid = sharedPreferences.getString("uid");
      token = sharedPreferences.getString("token");
      print(uid);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading ? Center(child: CircularProgressIndicator()) : Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        title: PageTitleHomePage(),
        actions: <Widget>[
          FlatButton(
            child: Text(
              "Log Out",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
            onPressed: () {
              sharedPreferences.clear();
              // shoule make changes to shared preference
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => LoginPage())
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Card(
          margin: EdgeInsets.all(15.0),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Starting Destination",
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    validator: (val) => val.isEmpty ? 'Enter starting destination' : null,
                    onChanged: (val) {
                      setState(() => startingDestination = val);
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment(0, 0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "Ending Destination ",
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      validator: (val) => val.isEmpty ? 'Enter ending destination' : null,
                      onChanged: (val) {
                        setState(() => endingDestination = val);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      RaisedButton(
                        onPressed: () => _selectDate(context),
                        child: Text('Select date'),
                      ),
                      Text("${selectedDate.toLocal()}".split(' ')[0]),
                      SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      FlatButton(
                        child: Text(
                          "Find Buses",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        ),
                        color: Colors.green[700],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)
                        ),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => RouteDetails(
                                uid: uid,
                                token: token,
                                startingDestination: startingDestination,
                                endingDestination: endingDestination,
                                journeyDate: journeyDate,
                              )
                            ));
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
