// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:get/state_manager.dart';
// import 'data_model.dart';

// class AffordabilityCalculationData extends GetxController {
//   List<Data> data = List<Data>();
//   int touchedIndex;

//   bool showSimpleSlider = false;

//   bool isMortageSelected = false;
//   int totalValue = 0;

//   int incomeInput = 30000;
//   double downPaymentInput = 0;
//   int monthlyDebtInupt = 0;
//   double interestRateInput = 10;
//   int incomeTaxInput = 0;
//   int propertyTaxInput = 0;
//   int homeOwnerInsuranceInput = 0;
//   int hoaDuesInput = 0;
//   int loanTermPeriod = 30;

//   int downPaymentAmount = 0;
//   double homeInsamount = 0;
//   double principalAndVatAmount = 0;
//   double taxAmount = 0;
//   double mortageInsAmount = 0;

//   @override
//   void onInit() {
//     addData();
//     reCalculateValues();
//     super.onInit();
//   }

//   void addData() {
//     data = [
//       Data(color: Color(0xffF64785), name: "Home Ins", value: homeInsamount),
//       Data(
//           color: Color(0xffFFAB52),
//           name: "Principal & Int",
//           value: principalAndVatAmount),
//       Data(color: Color(0xff20DBB4), name: "Taxes", value: taxAmount),
//       Data(
//           color: Color(0xff584BF5),
//           name: "Mortages ins",
//           value: mortageInsAmount),
//     ];
//     update();
//   }

//   changePriceInput(int input) {
//     priceInput = input;
//     reCalculateValues();
//     update();
//   }

//   changeDownpaymentInput(double input) {
//     downPaymentInput = input;
//     reCalculateValues();
//   }

//   changeInterestInput(double input) {
//     interestRateInput = input;
//     reCalculateValues();
//   }

//   changePropertyTaxInput(double input) {
//     propertyTaxInput = input;
//     reCalculateValues();
//   }

//   changeHomeInsInput(int input) {
//     homeOwnerInsuranceInput = input;
//     reCalculateValues();
//   }

//   reCalculateValues() {
//     calculateMortages();
//     calculateTax();
//     calculateHomeOwnerIns();
//     calcaulateTotal();
//     update();
//   }

//   calculateMortages() {
//     downPaymentAmount = (priceInput * (downPaymentInput / 100)).toInt();
//     int l = priceInput - downPaymentAmount;
//     int n = loanTermPeriod * 12;

//     if (interestRateInput != 0) {
//       double c = interestRateInput / 1200;

//       double powerVal = pow(1 + c, n);
//       double val1 = l * c * powerVal;
//       double val2 = powerVal - 1;
//       principalAndVatAmount = (val1 / val2);

//       print("The value is  $homeInsamount");
//     } else {
//       principalAndVatAmount = l / n;
//     }
//     data[1].value = double.parse((principalAndVatAmount).toStringAsFixed(1));
//     // update();
//   }

//   calculateTax() {
//     int annualTaxAmount = (priceInput * (propertyTaxInput / 100)).toInt();
//     taxAmount = annualTaxAmount / 12;
//     data[2].value = double.parse((taxAmount).toStringAsFixed(1));
//     // update();
//   }

//   calculateHomeOwnerIns() {
//     homeInsamount = homeOwnerInsuranceInput / 12;
//     data[0].value = double.parse((homeInsamount).toStringAsFixed(1));
//   }

//   calcaulateTotal() {
//     double totalSumValue =
//         homeInsamount + taxAmount + principalAndVatAmount + mortageInsAmount;
//     totalValue = totalSumValue.toInt();
//   }

//   changeInputType() {
//     showSimpleSlider = !showSimpleSlider;
//     update();
//   }
// }
