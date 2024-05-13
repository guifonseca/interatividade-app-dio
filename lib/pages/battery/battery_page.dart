import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class BatteryPage extends StatefulWidget {
  const BatteryPage({super.key});

  @override
  State<BatteryPage> createState() => _BatteryPageState();
}

class _BatteryPageState extends State<BatteryPage> {
  var battery = Battery();
  int statusBateria = 0;

  @override
  void initState() {
    super.initState();
    initPage();
    battery.onBatteryStateChanged.listen((BatteryState state) {
      print(state);
    });
  }

  void initPage() async {
    statusBateria = await battery.batteryLevel;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Status da Bateria: $statusBateria.0%"),
      ),
      body: Center(
        child: LinearPercentIndicator(
          width: MediaQuery.of(context).size.width,
          lineHeight: 20.0,
          percent: statusBateria / 100,
          animation: true,
          animationDuration: 2000,
          backgroundColor: Colors.grey,
          progressColor: Colors.blue,
          center: Text(
            "$statusBateria.0%",
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    ));
  }
}
