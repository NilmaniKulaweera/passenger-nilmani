import 'package:flutter/material.dart';

class PaymentSuccessPage extends StatelessWidget {
  final String payerID;
  final String paymentID;
  PaymentSuccessPage({this.payerID, this.paymentID});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Success page"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Text('payer ID - $payerID'),
            Text('payment ID - $paymentID'),
            FlatButton(
              child: Text('try again'),
              onPressed: () {
                Navigator.of(context).pop();
              }
            ),
            FlatButton(
              child: Text('cancel'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              }
            )
          ],
        ),
      ),
    );
  }
}