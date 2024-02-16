import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:world_time/model/world_time_model.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }

  void setupWorldTime() async {
    WorldTime worldTime = WorldTime("Tehran", "iran.png", "Iran");
    var responseTime = await worldTime.getTime();
    if (context.mounted) {
      Navigator.pushReplacementNamed(context, "/home", arguments: {
        "location": worldTime.location,
        "flag": worldTime.flag,
        "isDay": worldTime.isDay,
        "time": responseTime
      });
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.deepPurple[300],
        body: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Loading...",
                style: TextStyle(
                    color: Colors.white, fontSize: 18, letterSpacing: 2)),
            SpinKitFadingCircle(
              color: Colors.white,
              size: 50,
            ),
          ],
        ),
      );
}
