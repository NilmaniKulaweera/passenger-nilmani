import 'package:flutter/material.dart';

class PaymentFailurePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        title: Text(
          'Payment Failure',
          style: TextStyle(
            color: Colors.white
          ),
        )
      ),
      body: SingleChildScrollView(
        child: Card(
          margin: EdgeInsets.fromLTRB(20, 40, 20, 40),
          color: Colors.grey[100],
          child: Column(
            children: <Widget>[
              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                  child: Text(
                    "Payment was not successful",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.green[900],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              FlatButton(
                child: Text(
                  "Try Again",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
                color: Colors.green[900],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                }
              ),
              SizedBox(
                height: 15.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}