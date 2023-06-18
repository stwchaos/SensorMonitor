import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String> sensorData = [];

  @override
  void initState() {
    super.initState();
    startSensorMonitoring();
  }

  void startSensorMonitoring() {
    accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        sensorData.add('Acelerômetro: x=${event.x.toStringAsFixed(2)}, y=${event.y.toStringAsFixed(2)}, z=${event.z.toStringAsFixed(2)}');
      });
    });

    gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        sensorData.add('Giroscópio: x=${event.x.toStringAsFixed(2)}, y=${event.y.toStringAsFixed(2)}, z=${event.z.toStringAsFixed(2)}');
      });
    });

    magnetometerEvents.listen((MagnetometerEvent event) {
      setState(() {
        sensorData.add('Magnetômetro: x=${event.x.toStringAsFixed(2)}, y=${event.y.toStringAsFixed(2)}, z=${event.z.toStringAsFixed(2)}');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Monitor de Sensores',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.orange,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Monitor de Sensores'),
          centerTitle: true,
          leading: Icon(Icons.track_changes),
        ),
        body: ListView.builder(
          itemCount: sensorData.length,
          itemBuilder: (context, index) {
            String sensorReading = sensorData[index];
            IconData sensorIcon = Icons.error; // Ícone padrão caso nenhuma condição seja atendida
            Color sensorColor = Colors.grey; // Cor padrão caso nenhuma condição seja atendida

            if (sensorReading.contains('Acelerômetro')) {
              sensorIcon = Icons.arrow_upward;
              sensorColor = Colors.blue;
            } else if (sensorReading.contains('Giroscópio')) {
              sensorIcon = Icons.rotate_right;
              sensorColor = Colors.green;
            } else if (sensorReading.contains('Magnetômetro')) {
              sensorIcon = Icons.compass_calibration;
              sensorColor = Colors.orange;
            }

            return ListTile(
              leading: Icon(sensorIcon, color: sensorColor),
              title: Text(
                sensorReading,
                style: TextStyle(
                  color: sensorColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
