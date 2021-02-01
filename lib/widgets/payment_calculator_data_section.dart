import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:paymentCalcApp/data/data_model.dart';
import 'package:paymentCalcApp/data/payment_calculator_data.dart';

List<PieChartSectionData> getSections(int touched, bool isMortageSelected) {
  PaymentCalculationData data = Get.find();

  List<PieChartSectionData> pieChartData;
  pieChartData = data.data
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
  isMortageSelected ? null : pieChartData.removeAt(3);

  return pieChartData;
}
