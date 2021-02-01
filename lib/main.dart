import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paymentCalcApp/payment_calculator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: PaymentCalculator(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            FlatButton(
              child: Text("Payment CALCULATOR"),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PaymentCalculator()));
              },
            ),
            FlatButton(
              child: Text("Affordability CALCULATOR"),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PaymentCalculator()));
              },
            ),
            FlatButton(
              child: Text("Refinance CALCULATOR"),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PaymentCalculator()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
