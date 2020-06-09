import 'dart:core';
import 'package:flutter/material.dart';
import 'package:transport_booking_system_passenger_mobile/controllers/PaypalServices.dart';
import 'package:transport_booking_system_passenger_mobile/controllers/authController.dart';
import 'package:transport_booking_system_passenger_mobile/models/apiResponse.dart';
import 'package:transport_booking_system_passenger_mobile/models/busTripData.dart';
import 'package:transport_booking_system_passenger_mobile/views/pages/payment_failure.dart';
import 'package:transport_booking_system_passenger_mobile/views/pages/payment_success.dart';
import 'package:webview_flutter/webview_flutter.dart';


class PaypalPayment extends StatefulWidget {
  final String uid;
  final String token;
  final String startingDestination;
  final String endingDestination;
  final BusTripData trip;
  final List<int> selectedSeatNumbers;
  final int totalPrice;
  PaypalPayment({this.uid, this.token, this.startingDestination, this.endingDestination, this.trip, this.selectedSeatNumbers, this.totalPrice});

  @override
  State<StatefulWidget> createState() {
    return PaypalPaymentState();
  }
}

class PaypalPaymentState extends State<PaypalPayment> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String checkoutUrl;
  String executeUrl;
  String accessToken;
  PaypalServices services = PaypalServices();

  Map<dynamic,dynamic> defaultCurrency = {"symbol": "USD ", "decimalDigits": 2, "symbolBeforeTheNumber": true, "currency": "USD"};

  bool isEnableShipping = false;
  bool isEnableAddress = false;

  String returnURL = 'return.example.com';
  String cancelURL= 'cancel.example.com';

  final AuthController _auth = AuthController();
  APIResponse<double> _apiResponse;
  String errorMessage;
  double currencyConvertFactor;
  double priceInUSD;
  String stringValue;
  double priceInUSD2Decimals;
  bool _isLoading;

  void getUSDfromLKR() async {
    setState(() { _isLoading = true; });
    _apiResponse = await _auth.convertLKRtoUSD();
    setState(() { 
      if (_apiResponse.error){
        _isLoading = false; 
        errorMessage = _apiResponse.errorMessage;
      } else {
        _isLoading = false; 
        currencyConvertFactor = _apiResponse.data;
        print ('currencyConvertFactor - $currencyConvertFactor');
        priceInUSD = widget.totalPrice * currencyConvertFactor;
        print ('priceInUSD - $priceInUSD');
        stringValue = priceInUSD.toStringAsFixed(2); 
        priceInUSD2Decimals = double.parse(stringValue);
  
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getUSDfromLKR();
    Future.delayed(Duration.zero, () async {
      try {
        accessToken = await services.getAccessToken();

        final transactions = getOrderParams();
        final res = await services.createPaypalPayment(transactions, accessToken);
        if (res != null) {
          setState(() {
            checkoutUrl = res["approvalUrl"];
            executeUrl = res["executeUrl"];
          });
        }
      } catch (e) {
        print('exception: '+e.toString());
        final snackBar = SnackBar(
          content: Text(e.toString()),
          duration: Duration(seconds: 10),
          action: SnackBarAction(
            label: 'Close',
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => PaymentFailurePage())
              );
            },
          ),
        );
        _scaffoldKey.currentState.showSnackBar(snackBar);
      }
    });
  }

  Map<String, dynamic> getOrderParams() {
    // checkout invoice details
    Map<String, dynamic> temp = {
      "intent": "sale",
      "payer": {"payment_method": "paypal"},
      "application_context":{"shipping_preference":"NO_SHIPPING"},
      "transactions": [
        {
          "amount": {
            "total": priceInUSD2Decimals,
            "currency": defaultCurrency["currency"],
          },
          "description": "The payment transaction description.",
          "payment_options": {
            "allowed_payment_method": "INSTANT_FUNDING_SOURCE"
          },
        }
      ],
      "redirect_urls": {
        "return_url": returnURL,
        "cancel_url": cancelURL
      }
    };
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    print(checkoutUrl);
    if (checkoutUrl != null) {
      return _isLoading? Center(child: CircularProgressIndicator()) : Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[900],
          title: Text(
            'Pay Amount',
            style: TextStyle(
              color: Colors.white
            ),
          )
        ),
        body: WebView(
          initialUrl: checkoutUrl,
          javascriptMode: JavascriptMode.unrestricted,
          navigationDelegate: (NavigationRequest request) {
            if (request.url.contains(returnURL)) {
              final uri = Uri.parse(request.url);
              final payerID = uri.queryParameters['PayerID'];
              final paymentID = uri.queryParameters['paymentId'];
              print(uri);
              print ('return  $returnURL');
              
              if (payerID != null) {
                services
                  .executePayment(executeUrl, payerID, accessToken)
                  .then((id) {
                    Navigator.of(context).pop();
                  });
              } else {
                Navigator.of(context).pop();
              }
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => PaymentSuccessPage(
                  uid: widget.uid,
                  token: widget.token,
                  startingDestination: widget.startingDestination,
                  endingDestination: widget.endingDestination,
                  trip: widget.trip,
                  selectedSeatNumbers: widget.selectedSeatNumbers,
                  totalPrice: widget.totalPrice,
                  payerID: payerID, 
                  paymentID: paymentID
                ))
              );
            }
            if (request.url.contains(cancelURL)) {
              print ('cancel  $cancelURL');
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => PaymentFailurePage())
              );
            }
            return NavigationDecision.navigate;
          },
        ),
      );
    } else {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          backgroundColor: Colors.black12,
          elevation: 0.0,
        ),
        body: Center(child: Container(child: CircularProgressIndicator())),
      );
    }
  }
}