import 'package:shintaapp/constant/route_constants.dart';
import 'package:shintaapp/helper/dbhelper.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int totalIncome = 0;
  int totalExpense = 0;

  @override
  void initState() {
    super.initState();
    _fetchTotalIncomeAndExpense();
  }

  Future<void> _fetchTotalIncomeAndExpense() async {
    // Initialize your DBHelper
    final dbHelper = DbHelper();

    // Fetch the total income and total expense
    final income = await dbHelper.getTotalIncome();
    final expense = await dbHelper.getTotalExpense();

    setState(() {
      totalIncome = income;
      totalExpense = expense;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchTotalIncomeAndExpense(); // Refresh data when navigating back
  }

  @override
  Widget build(BuildContext context) {
    // final userProvider = Provider.of<UserProvider>(context);
    // final user = userProvider.user;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Center(
            child: Column(
          children: [
            Text("Total Pengeluaran: \Rp $totalExpense"),
            Text("Total Pemasukan: \Rp $totalIncome"),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: LineChart(LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(show: false),
                  borderData: FlBorderData(
                      show: true,
                      border: Border.all(color: Colors.black, width: 1)),
                  minX: 0,
                  maxX: 7,
                  minY: 0,
                  maxY: 1000,
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        FlSpot(0, 200),
                        FlSpot(1, 150),
                        FlSpot(2, 450),
                        FlSpot(3, 300),
                        FlSpot(4, 600),
                        FlSpot(5, 500),
                        FlSpot(6, 800),
                        FlSpot(7, 1000),
                      ],
                      isCurved: true,
                      color: Colors.deepPurple,
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(show: false),
                    )
                  ])),
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    NavButton(
                        imagePath: 'assets/images/pemasukan_shinta.jpeg',
                        label: "Tambah Pemasukan",
                        onTap: () {
                          Navigator.pushNamed(context, addIncomeRoute);
                        }),
                    NavButton(
                        imagePath: 'assets/images/pengeluaran_shinta.jpeg',
                        label: "Tambah Pengeluaran",
                        onTap: () {
                          Navigator.pushNamed(context, addExpenseRoute);
                        }),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    NavButton(
                        imagePath: 'assets/images/cash_shinta.jpg',
                        label: "Detail Cash Flow",
                        onTap: () {
                          Navigator.pushNamed(context, detailCashFlowRoute);
                        }),
                    NavButton(
                        imagePath: 'assets/images/setting_shinta.jpg',
                        label: "Pengaturan",
                        onTap: () {
                          Navigator.pushNamed(context, '/settings');
                        }),
                  ],
                ),
              ],
            )
          ],
        )),
      ),
    );
  }
}

class NavButton extends StatelessWidget {
  final String imagePath;
  final String label;
  final VoidCallback onTap;

  const NavButton(
      {required this.imagePath, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Image.asset(
            imagePath,
            width: 50,
            height: 50,
          ),
          SizedBox(height: 10),
          Text(label),
        ],
      ),
    );
  }
}
