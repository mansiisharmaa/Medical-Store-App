import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:medical_store/orderItemModel.dart';
import 'package:medical_store/orderItem_dao.dart';

class Sales extends StatefulWidget {
  const Sales({super.key});

  @override
  State<Sales> createState() => _SalesState();
}

class _SalesState extends State<Sales> {
  List<Orderitemmodel> itemList = [];

  @override
  void initState() {
    super.initState();
    getMedicienItem();
  }

  void getMedicienItem() async {
    itemList = await OrderitemDao().getitem();
    setState(() {});
  }

  Map<String, double> groupSalesByMonth() {
    Map<String, double> monthlySales = {};

    for (var item in itemList) {
      if (item.date == null) continue;
      DateTime date = DateTime.parse(
        item.date!,
      ); // make sure date is in yyyy-MM-dd format

      String monthKey =
          "${date!.year}-${date!.month.toString().padLeft(2, '0')}";
      double sale = (item.quantity ?? 0) * (item.price ?? 0.0);
      monthlySales[monthKey] = (monthlySales[monthKey] ?? 0) + sale;
    }

    return monthlySales;
  }

  List<BarChartGroupData> generateBarData() {
    final groupedSales = groupSalesByMonth();
    final sortedKeys = groupedSales.keys.toList()..sort(); // sort by month
    int index = 0;

    return sortedKeys.map((key) {
      final bar = BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: groupedSales[key]!,
            color: Colors.deepPurple,
            width: 20,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      );
      index++;
      return bar;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Medicine Sales Bar Chart")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: itemList.isEmpty
            ? Center(child: CircularProgressIndicator())
            : BarChart(
                BarChartData(
                  barGroups: generateBarData(),
                  borderData: FlBorderData(show: false),
                  gridData: FlGridData(show: true),
                  titlesData: FlTitlesData(
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 10,
                        reservedSize: 42,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          final sortedKeys = groupSalesByMonth().keys.toList()
                            ..sort();
                          int index = value.toInt();

                          if (index >= 0 && index < sortedKeys.length) {
                            String date = sortedKeys[index];
                            DateTime parsed = DateTime.parse("$date-01");
                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                "${_monthName(parsed.month)}",
                                style: TextStyle(fontSize: 10),
                              ),
                            );
                          }
                          return Text('');
                        },
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}

String _monthName(int month) {
  const months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec",
  ];
  return months[month - 1];
}
