import 'package:flutter/material.dart';

class IndicatorWidget extends StatelessWidget {
  final String name;
  final Color color;
  final double width;

  const IndicatorWidget({Key key, this.name, this.color, this.width})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Color(0xff212E4E), borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.pie_chart_rounded,
            color: color,
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            "$name",
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
