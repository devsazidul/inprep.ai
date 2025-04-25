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
      title = 'Content Accuracy';
      percentage = 75;
      change = '+5%';
      changeColor = Color(0xff34C759);
    } else if (index == 1) {
      title = 'Behavioural Cue';
      percentage = 60;
      change = '-10%';
      changeColor = Colors.red;
    } else if (index == 2) {
      title = 'Articulation Clarity';
      percentage = 85;
      change = '+15%';
      changeColor = Color(0xff34C759);
    } else if (index == 3) {
      title = 'Inprep Score';
      percentage = 80;
      change = 'Stable';
      changeColor = Colors.black;
    } else if (index == 4) {
      title = 'Problem Solving';
      percentage = 85;
      change = '+15%';
      changeColor = Color(0xff34C759);
    }

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(11.0),
        child:
            index ==
                    4 // Apply custom layout for index 4
                ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Title and percentage in the center
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff212121),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '$percentage%',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff3A4c67),
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                    // Add the graph for Problem Solving here inside Flexible
                    Flexible(
                      child: SizedBox(
                        height:
                            MediaQuery.of(context).size.height *
                            0.1, // Fixed height for the graph
                        child: SfCartesianChart(
                          primaryXAxis: CategoryAxis(isVisible: false),
                          primaryYAxis: NumericAxis(isVisible: false),
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
                    ),
                    const SizedBox(
                      height: 20,
                    ), // Space between graph and change text
                    // Change text positioned at the bottom-left
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          change,
                          style: TextStyle(
                            fontSize: 13,
                            color: changeColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
                : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title Text with responsive font size
                    Text(
                      title,
                      style: TextStyle(
                        fontSize:
                            MediaQuery.of(context).size.width *
                            0.038, // Adjust font size based on screen width
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff212121),
                      ),
                    ),
                    // Percentage Text with responsive font size
                    Text(
                      '$percentage%',
                      style: TextStyle(
                        fontSize:
                            MediaQuery.of(context).size.width *
                            0.030, // Adjust font size based on screen width
                        fontWeight: FontWeight.bold,
                        color: const Color(0xff3A4c67),
                      ),
                    ),
                    const SizedBox(height: 6),
                    // Responsive chart height
                    SizedBox(
                      height:
                          MediaQuery.of(context).size.height *
                          0.0998, // Adjust chart height based on screen height
                      child: SfCartesianChart(
                        primaryXAxis: CategoryAxis(isVisible: false),
                        primaryYAxis: NumericAxis(isVisible: false),
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
                    // Change Text with responsive font size and color change
                    Text(
                      change,
                      style: TextStyle(
                        fontSize:
                            MediaQuery.of(context).size.width *
                            0.030, // Adjust font size based on screen width
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
