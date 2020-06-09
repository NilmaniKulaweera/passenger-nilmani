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
      body: Container(
        child: FlatButton(
          child: Text('try again'),
          onPressed: () {
            Navigator.of(context).pop();
          }
        ),
      ),
    );
  }
}