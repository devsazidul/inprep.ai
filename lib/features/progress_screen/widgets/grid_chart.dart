import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CardWidget extends StatelessWidget {
  final int index;

  const CardWidget({required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    String title = '';
    double percentage = 0;
    String change = '';
    Color changeColor = Color(0xff1E6540);

    if (index == 0) {
      title = 'Content Quality';
      percentage = 75;
      change = '+5%';
      changeColor = Colors.green;
    } else if (index == 1) {
      title = 'Body Language';
      percentage = 60;
      change = '-10%';
      changeColor = Colors.red;
    } else if (index == 2) {
      title = 'Speech Clarity';
      percentage = 85;
      change = '+15%';
      changeColor = Colors.green;
    } else if (index == 3) {
      title = 'Confidence';
      percentage = 80;
      change = 'Stable';
      changeColor = Colors.black;
    }
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),),
      elevation: 5,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(11.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xff212121),
              ),
            ),
            Text(
              '$percentage%',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xff3A4c67),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.096,
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(
                  isVisible: false, 
                ),
                primaryYAxis: NumericAxis(
                  isVisible: false, 
                ),
                plotAreaBorderWidth: 0, 
                series: <CartesianSeries<ChartData, String>>[
                  LineSeries<ChartData, String>(
                    dataSource: getData(),
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y,
                    color: Colors.green,
                    width: 2,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              change,
              style: TextStyle(
                fontSize: 13,
                color: changeColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<ChartData> getData() {
    return [
      ChartData('Week 1', 60),
      ChartData('Week 2', 70),
      ChartData('Week 3', 75),
      ChartData('Week 4', 80),
    ];
  }
}

class ChartData {
  final String x;
  final double y;

  ChartData(this.x, this.y);
}