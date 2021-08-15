import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_riverpod_api/providers.dart';

class CarUI extends ConsumerWidget {
  const CarUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final carState = watch(carStateNotifierProvider);
    final carNotifier = watch(carStateNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text("State Notifier"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Speed : ' + carState.speed!.toDouble().toString(),
              style: TextStyle(fontSize: 32),
            ),
            SizedBox(height: 20),
            Text(
              'Doors : ' + carState.doors!.toDouble().toString(),
              style: TextStyle(fontSize: 32),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  press: () {
                    carNotifier.increaseSpeed();
                  },
                  title: 'Increase 5+',
                ),
                SizedBox(width: 20),
                CustomButton(
                  title: 'Brake 30-',
                  press: () {
                    carNotifier.brakeSpeed();
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            Slider(
              value: carState.doors!.toDouble(),
              max: 5,
              onChanged: (value) {
                //  print(value);
                carNotifier.setDoors(value.toInt());
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key, required this.press, required this.title})
      : super(key: key);
  final VoidCallback press;
  final String title;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(title),
      onPressed: press,
      style: ElevatedButton.styleFrom(
        shape: StadiumBorder(),
        textStyle: TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }
}
