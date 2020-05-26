import 'package:shared_preferences/shared_preferences.dart';
import 'package:transport_booking_system_passenger_mobile/models/apiResponse.dart';
import 'package:transport_booking_system_passenger_mobile/models/userData.dart';
import 'package:transport_booking_system_passenger_mobile/views/shared_widgets/page_widget.dart';
import 'package:transport_booking_system_passenger_mobile/models/newUserRegister.dart';
import 'package:flutter/material.dart';
import 'package:transport_booking_system_passenger_mobile/controllers/authController.dart';
import 'package:transport_booking_system_passenger_mobile/views/pages/home.dart';
import 'package:string_validator/string_validator.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

enum AuthMode { LOGIN, SIGNUP, PassengerUI }

class _LoginPageState extends State<LoginPage> {

  final AuthController _auth = AuthController();
  final _formKey = GlobalKey<FormState>();
  APIResponse<UserData> _apiResponseLogin;
  APIResponse<String> _apiResponseRegister;
  String errorMessage = '';

  String firstName = '';
  String secondName = '';
  String phoneNumber = '';
  String email = '';
  String password ='';

  double screenHeight;
  bool _isLoading = false;

  NewUserRegister newUserModel; 
  AuthMode _authMode = AuthMode.LOGIN;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            LowerHalf(),
            UpperHalf(),
            _authMode == AuthMode.LOGIN
                ? loginCard(context)
                : singUpCard(context),
            PageTitleAuthPage()
          ],
        ),
      ),
    );
  }

  Widget loginCard(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: screenHeight / 4),
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Your Email",
                        labelStyle: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      validator: (val) => isEmail(val) ?  null : 'Enter a valid email' ,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      obscureText:true,
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(fontWeight: FontWeight.bold), 
                      ),
                      validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        MaterialButton(
                          onPressed: () {},
                          child: Text("Forgot Password ?"),
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        FlatButton(
                          child: Text("Login"),
                          color: Colors.green[900],
                          textColor: Colors.white,
                          padding: EdgeInsets.only(left: 38, right: 38, top: 15, bottom: 15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)
                          ),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) { // validate the form based on the current state according to the conditions given in each TextFormField
                              setState(() {
                                _isLoading = true;
                              });
                              _apiResponseLogin = await _auth.signInPassenger(email,password); // if form is valid sign in the user
                              SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                              setState(() {
                                _isLoading = false;
                              });
                              if(_apiResponseLogin.error){
                                setState(() {
                                  errorMessage = _apiResponseLogin.errorMessage;
                                });
                                print(errorMessage);
                              } else {
                                setState(() {
                                  sharedPreferences.setString("token", _apiResponseLogin.data.token); // cache user data
                                  sharedPreferences.setString("uid", _apiResponseLogin.data.uid); 
                                });
                                String message = _apiResponseLogin.data.message;
                                print (message);
                                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home())); // navigate to the home page if the user correctly signs in
                              }
                            }
                          },
                        ),
                      ],  
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text (
                      errorMessage,
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.red[900],
                      ),
                    ),
                    // show the loading widget if the data is loading
                    _isLoading ? Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.green[900]),)) : SizedBox(),      
                  ],
                ),
              ),
            ),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Text(
              "Don't have an account ?",
              style: TextStyle(color: Colors.grey),
            ),
            FlatButton(
              child: Text("Create Account"),
              onPressed: () {
                setState(() {
                  _formKey.currentState.reset();
                  _authMode = AuthMode.SIGNUP;
                });
              },
              textColor: Colors.black87,
            )
          ],
        )
      ],
    );
  }

  Widget singUpCard(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: screenHeight / 5),
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Form(
                  key: _formKey,
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Create Account",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "First Name", 
                        labelStyle: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      validator: (val) => val.isEmpty ? 'Enter your First Name' : null,
                      onChanged: (val) {
                        setState(() => firstName = val);
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Second Name", 
                        labelStyle: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      validator: (val) => val.isEmpty ? 'Enter your Second Name' : null,
                      onChanged: (val) {
                        setState(() => secondName = val);
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Your Email",
                        labelStyle: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      validator: (val) => isEmail(val) ? null : 'Enter a valid email',
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Phone Number  Ex:07xxxxxxxx",
                        labelStyle: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      validator: (val) => (isNumeric(val) && (val.length == 10)) ? null : 'Enter a valid phone number',
                      onChanged: (val) {
                        setState(() => phoneNumber = val);
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      obscureText:true,
                      decoration: InputDecoration(
                        labelText: "Password", 
                        labelStyle: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Password must be at least 6 characters long",
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                          child: Container(),
                        ),
                        FlatButton(
                          child: Text("Sign Up"),
                          color: Colors.green[900],
                          textColor: Colors.white,
                          padding: EdgeInsets.only(left: 38, right: 38, top: 15, bottom: 15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)
                          ),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              newUserModel = new NewUserRegister(
                                email: email,
                                password: password,
                                firstName: firstName,
                                secondName: secondName,
                                phoneNumber: phoneNumber,
                              );
                              setState(() {
                                _isLoading = true;
                              });
                              _apiResponseRegister = await _auth.registerPassenger(newUserModel);
                              setState(() {
                                _isLoading = false;
                              });
                              
                              if(_apiResponseRegister.error){
                                setState(() {
                                  errorMessage = _apiResponseRegister.errorMessage;
                                });
                                print(errorMessage);
                                showAlertDialog(
                                  context,
                                  errorMessage,
                                  "Alert"
                                );
                              } else {
                                String message = _apiResponseRegister.data;
                                print (message);
                                errorMessage=" ";
                                showAlertDialog(
                                  context,
                                  message,
                                  "Success"
                                );
                                setState(() {
                                  _authMode = AuthMode.LOGIN;
                                });
                              }
                            }
                          }
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text (
                      errorMessage,
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.red[900],
                      ),
                    ),
                    // show the loading widget if the data is loading
                    _isLoading ? Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.green[900]),)) : SizedBox(),
                  ],
                ),
              ),
            ),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Text(
              "Already have an account?",
              style: TextStyle(color: Colors.grey),
            ),
            FlatButton(
              onPressed: () {
                setState(() {
                  _formKey.currentState.reset();
                  _authMode = AuthMode.LOGIN;
                });
              },
              textColor: Colors.black87,
              child: Text("Login"),
            )
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: FlatButton(
            child: Text(
              "Terms & Conditions",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  showAlertDialog(BuildContext context, String message, String title) {
    // set up the button
    Widget okButton = FlatButton(child: Text("OK"), onPressed: () => Navigator.pop(context));

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}
