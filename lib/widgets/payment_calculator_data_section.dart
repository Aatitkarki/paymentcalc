import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:paymentCalcApp/data/data_model.dart';
import 'package:paymentCalcApp/data/payment_calculator_data.dart';

List<PieChartSectionData> getSections(int touched, bool isMortageSelected) {
  PaymentCalculationData paymentCalculationData = Get.find();

  List<PieChartSectionData> pieChartData;
  List<Data> pieRawData = List<Data>();
  // pieRawData = paymentCalculationData.data;
  if (paymentCalculationData.mortageInsAmount > 1) {
    pieRawData.add(paymentCalculationData.data[3]);
  }
  if (paymentCalculationData.principalAndVatAmount > 1) {
    pieRawData.add(paymentCalculationData.data[1]);
  }
  if (paymentCalculationData.homeInsamount > 1) {
    pieRawData.add(paymentCalculationData.data[0]);
  }
  if (paymentCalculationData.hoaDuesInput > 0) {
    pieRawData.add(paymentCalculationData.data[4]);
  } else if (paymentCalculationData.taxAmount > 1) {
    pieRawData.add(paymentCalculationData.data[2]);
  }

  // if (paymentCalculationData.mortageInsAmount < 1) {
  //   pieRawData.removeWhere((item) => item.name == 'Mortages ins');
  // }
  // if (paymentCalculationData.homeInsamount < 1) {
  //   pieRawData.removeWhere((item) => item.name == 'Home Ins');
  // }
  // if (paymentCalculationData.taxAmount < 1) {
  //   pieRawData.removeWhere((item) => item.name == 'Taxes');
  // }
  // if (paymentCalculationData.principalAndVatAmount < 1) {
  //   pieRawData.removeWhere((item) => item.name == 'Principal & Int');
  // }

  pieChartData = pieRawData
      .asMap()
      .map<int, PieChartSectionData>((index, data) {
        final isTouched = index == touched;
        double fontSize = isTouched ? 20 : 16;
        double radius = isTouched ? 90 : 70;
        final value = PieChartSectionData(
            color: data.color,
            value: data.value.toPrecision(1),
            radius: radius,
            title: "\$${data.value}",
            titleStyle:
                TextStyle(fontSize: fontSize, color: Color(0xffffffff)));
        return MapEntry(index, value);
      })
      .values
      .toList();

  return pieChartData;
}
