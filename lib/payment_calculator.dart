import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:paymentCalcApp/data/payment_calculator_data.dart';
import 'package:paymentCalcApp/widgets/indicator_widget.dart';
import 'package:paymentCalcApp/widgets/payment_calculator_data_section.dart';

class PaymentCalculator extends StatefulWidget {
  @override
  PaymentCalculatorState createState() => PaymentCalculatorState();
}

class PaymentCalculatorState extends State<PaymentCalculator> {
  PaymentCalculationData _paymentCalculationData =
      Get.put(PaymentCalculationData());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<PaymentCalculationData>(
      builder: (_paymentCalculationData) => Scaffold(
        backgroundColor: Color(0xff162345),
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          centerTitle: true,
          automaticallyImplyLeading: true,
          title: Text("Payment Calculator"),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          height: size.height,
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildPieData(),
              _paymentCalculationData.showSimpleSlider
                  ? simpleSliders()
                  : showAdvancedInputs()
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPieData() {
    // PaymentCalculationData data = Get.find();
    return GetBuilder<PaymentCalculationData>(builder: (data) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 40,
          ),
          Container(
            height: 260,
            child: Stack(
              alignment: Alignment.center,
              children: [
                PieChart(PieChartData(
                    pieTouchData:
                        PieTouchData(touchCallback: (pieTouchResponse) {
                      setState(() {
                        if (pieTouchResponse.touchInput is FlLongPressEnd ||
                            pieTouchResponse.touchInput is FlPanEnd) {
                          data.touchedIndex = -1;
                        } else {
                          print(pieTouchResponse.touchedSectionIndex);
                          data.touchedIndex =
                              pieTouchResponse.touchedSectionIndex;
                        }
                      });
                    }),
                    sections:
                        getSections(data.touchedIndex, data.isMortageSelected),
                    borderData: FlBorderData(show: false),
                    sectionsSpace: 0,
                    centerSpaceRadius: 60)),
                Text(
                  "\$${data.totalValue}",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            children: [
              Wrap(
                spacing: 20,
                runSpacing: 10,
                children: [
                  IndicatorWidget(
                      color: data.data[0].color, name: data.data[0].name),
                  IndicatorWidget(
                      color: data.data[1].color, name: data.data[1].name),
                  _paymentCalculationData.hoaDuesInput == 0
                      ? IndicatorWidget(
                          color: data.data[2].color, name: data.data[2].name)
                      : IndicatorWidget(
                          color: data.data[4].color, name: data.data[4].name),
                  IndicatorWidget(
                      color: data.data[3].color, name: data.data[3].name)
                ],
              ),
            ],
          ),
        ],
      );
    });
  }

  Widget simpleSliders() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Price: \$${_paymentCalculationData.priceInput}",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              Slider(
                min: 30000,
                max: 10000000,
                value: _paymentCalculationData.priceInput.toDouble(),
                onChanged: (data) {
                  _paymentCalculationData.changePriceInput(data.toInt());
                },
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Down Payment: ${_paymentCalculationData.downPaymentInput}%",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              Slider(
                min: 0,
                max: 40,
                value: _paymentCalculationData.downPaymentInput > 40
                    ? 40
                    : _paymentCalculationData.downPaymentInput,
                onChanged: (data) {
                  _paymentCalculationData
                      .changeDownpaymentInput(data.toPrecision(1));
                },
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Interest Rate: ${_paymentCalculationData.interestRateInput}%",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              Slider(
                min: 0,
                max: 12,
                value: _paymentCalculationData.interestRateInput,
                onChanged: (data) {
                  _paymentCalculationData
                      .changeInterestInput(data.toPrecision(1));
                },
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: FlatButton(
                  onPressed: () {
                    _paymentCalculationData.changeInputType();
                  },
                  child: Text(
                    "Show Advanced Input",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.blueAccent,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget showAdvancedInputs() {
    TextEditingController priceInputController = TextEditingController();
    TextEditingController downPaymentInputController = TextEditingController();
    TextEditingController interestInputController = TextEditingController();
    TextEditingController propertyTaxInputController = TextEditingController();
    TextEditingController homeOwnerInsuranceController =
        TextEditingController();
    TextEditingController hoaDuesInputController = TextEditingController();

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Price",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                Text(
                  "\$${_paymentCalculationData.priceInput}",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
            onPressed: () {
              return Get.defaultDialog(
                  title: "Input price value",
                  textConfirm: "Ok",
                  textCancel: "Cancel",
                  confirmTextColor: Colors.white,
                  cancelTextColor: Colors.red,
                  onCancel: () {
                    Get.back();
                  },
                  onConfirm: () {
                    int value = int.parse(priceInputController.text);
                    if (value < 30000 || value > 10000000) {
                      Get.snackbar("Title",
                          "The price should be between 30000 and 10000000",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.white,
                          colorText: Colors.black);
                    } else {
                      _paymentCalculationData.changePriceInput(value);
                      Get.back();
                    }
                  },
                  content: Row(
                    children: [
                      Icon(Icons.attach_money),
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: priceInputController,
                          decoration: new InputDecoration(),
                        ),
                      ),
                    ],
                  ));
            },
          ),

          //TODO: DOWN PAYMENT
          TextButton(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "DownPayment",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                Text(
                  "${_paymentCalculationData.downPaymentInput} %",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
            onPressed: () {
              return Get.defaultDialog(
                  title: "Downpayment percent value",
                  textConfirm: "Ok",
                  textCancel: "Cancel",
                  confirmTextColor: Colors.white,
                  cancelTextColor: Colors.red,
                  onCancel: () {
                    Get.back();
                  },
                  onConfirm: () {
                    double value =
                        double.parse(downPaymentInputController.text);
                    if (value < 0 || value > 100) {
                      Get.snackbar("Input errror",
                          "Please give percent between 0 and 100",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.white,
                          colorText: Colors.black);
                    } else {
                      _paymentCalculationData.changeDownpaymentInput(value);
                      Get.back();
                    }
                  },
                  content: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: downPaymentInputController,
                          decoration: new InputDecoration(),
                        ),
                      ),
                      Text(
                        "%",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ));
            },
          ),

          //TODO: INTEREST RATE
          TextButton(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Interest Rate",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                Text(
                  "${_paymentCalculationData.interestRateInput} %",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
            onPressed: () {
              return Get.defaultDialog(
                  title: "Input Interest percent",
                  textConfirm: "Ok",
                  textCancel: "Cancel",
                  confirmTextColor: Colors.white,
                  cancelTextColor: Colors.red,
                  onCancel: () {
                    Get.back();
                  },
                  onConfirm: () {
                    double value = double.parse(interestInputController.text);
                    if (value < 0 || value > 100) {
                      Get.snackbar("Input errror",
                          "Please give percent between 0 and 100",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.white,
                          colorText: Colors.black);
                    } else {
                      _paymentCalculationData.changeInterestInput(value);
                      Get.back();
                    }
                  },
                  content: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: interestInputController,
                          decoration: new InputDecoration(),
                        ),
                      ),
                      Text(
                        "%",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ));
            },
          ),

          //TODO: PROPERTY TAXES
          TextButton(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Property Taxes",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                Text(
                  "${_paymentCalculationData.propertyTaxInput} %",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
            onPressed: () {
              return Get.defaultDialog(
                  title: "Property Tax Input ",
                  textConfirm: "Ok",
                  textCancel: "Cancel",
                  confirmTextColor: Colors.white,
                  cancelTextColor: Colors.red,
                  onCancel: () {
                    Get.back();
                  },
                  onConfirm: () {
                    double value =
                        double.parse(propertyTaxInputController.text);
                    if (value < 0 || value > 100) {
                      Get.snackbar("Input errror",
                          "Please give percent between 0 and 100",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.white,
                          colorText: Colors.black);
                    } else {
                      _paymentCalculationData.changePropertyTaxInput(value);
                      Get.back();
                    }
                  },
                  content: Row(
                    children: [
                      Icon(Icons.attach_money),
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: propertyTaxInputController,
                          decoration: new InputDecoration(),
                        ),
                      ),
                    ],
                  ));
            },
          ),

          //TOD0: HOMEOWNERS INSURANCE
          TextButton(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Homeowners Insurance",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                Text(
                  "\$${_paymentCalculationData.homeOwnerInsuranceInput}/yr",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
            onPressed: () {
              return Get.defaultDialog(
                  title: "Input homeowner value",
                  textConfirm: "Ok",
                  textCancel: "Cancel",
                  confirmTextColor: Colors.white,
                  cancelTextColor: Colors.red,
                  onCancel: () {
                    Get.back();
                  },
                  onConfirm: () {
                    int value = int.parse(homeOwnerInsuranceController.text);
                    if (value < 0 || value > 100000) {
                      Get.snackbar(
                          "Title", "The input should be between 0 and 100000",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.white,
                          colorText: Colors.black);
                    } else {
                      _paymentCalculationData.changeHomeInsInput(value);
                      Get.back();
                    }
                  },
                  content: Row(
                    children: [
                      Icon(Icons.attach_money),
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: homeOwnerInsuranceController,
                          decoration: new InputDecoration(),
                        ),
                      ),
                      Text("/yr")
                    ],
                  ));
            },
          ),

          //TODO: HOA DUES
          TextButton(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "HOA Dues",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                Text(
                  "${_paymentCalculationData.hoaDuesInput}/month",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
            onPressed: () {
              return Get.defaultDialog(
                  title: "Input HOA dues",
                  textConfirm: "Ok",
                  textCancel: "Cancel",
                  confirmTextColor: Colors.white,
                  cancelTextColor: Colors.red,
                  onCancel: () {
                    Get.back();
                  },
                  onConfirm: () {
                    int value = int.parse(hoaDuesInputController.text);
                    if (value < 0 || value > 10000) {
                      Get.snackbar(
                          "Title", "The value should be between 0 and 10000",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.white,
                          colorText: Colors.black);
                    } else {
                      _paymentCalculationData.changeHoaDuesInput(value);
                      Get.back();
                    }
                  },
                  content: Row(
                    children: [
                      Icon(Icons.attach_money),
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: hoaDuesInputController,
                          decoration: new InputDecoration(),
                        ),
                      ),
                      Text("/month")
                    ],
                  ));
            },
          ),

          //TODO: LOAN TERMS
          TextButton(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Loan Term",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                Text(
                  "\$${_paymentCalculationData.loanTermPeriod} years",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
            onPressed: () {
              return Get.defaultDialog(
                  barrierDismissible: true,
                  title: "Loan Term",
                  confirmTextColor: Colors.white,
                  cancelTextColor: Colors.red,
                  content: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("30 years"),
                          Radio(
                            value: 30,
                            groupValue: _paymentCalculationData.loanTermPeriod,
                            onChanged: (value) {
                              _paymentCalculationData.loanTermPeriod = value;
                              _paymentCalculationData.reCalculateValues();
                              Get.back(closeOverlays: true);
                            },
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("20 years"),
                          Radio(
                            value: 20,
                            groupValue: _paymentCalculationData.loanTermPeriod,
                            onChanged: (value) {
                              _paymentCalculationData.loanTermPeriod = value;
                              _paymentCalculationData.reCalculateValues();
                              Get.back(closeOverlays: true);
                            },
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("10 years"),
                          Radio(
                            value: 10,
                            groupValue: _paymentCalculationData.loanTermPeriod,
                            onChanged: (value) {
                              _paymentCalculationData.loanTermPeriod = value;
                              _paymentCalculationData.reCalculateValues();
                              Get.back(closeOverlays: true);
                            },
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("5 years"),
                          Radio(
                            value: 5,
                            groupValue: _paymentCalculationData.loanTermPeriod,
                            onChanged: (value) {
                              _paymentCalculationData.loanTermPeriod = value;
                              _paymentCalculationData.reCalculateValues();
                              Get.back(closeOverlays: true);
                            },
                          )
                        ],
                      ),
                    ],
                  ));
            },
          ),

          Center(
            child: FlatButton(
              onPressed: () {
                _paymentCalculationData.changeInputType();
              },
              child: Text(
                "Show Simple Input",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.blueAccent,
            ),
          ),
        ],
      ),
    );
  }
}
