import 'package:flutter/material.dart';
import 'package:world_time/model/world_time_model.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({super.key});

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  List<WorldTime> locations = [
    WorldTime('London', 'uk.png', 'Europe/London'),
    WorldTime('Athens', 'greece.png', 'Europe/Berlin'),
    WorldTime('Cairo', 'egypt.png', 'Africa/Cairo'),
    WorldTime('Nairobi', 'kenya.png', 'Africa/Nairobi'),
    WorldTime('Chicago', 'usa.png', 'America/Chicago'),
    WorldTime('New York', 'usa.png', 'America/New_York'),
    WorldTime('Seoul', 'south_korea.png', 'Asia/Seoul'),
    WorldTime('Jakarta', 'indonesia.png', 'Asia/Jakarta'),
    WorldTime("Tehran", "iran.png", "Iran")
  ];

  @override
  Widget build(BuildContext context) {
    Map? data = ModalRoute.of(context)?.settings.arguments as Map?;
    bool isDay = data?["isDay"];

    return Scaffold(
      backgroundColor: isDay ? Colors.deepPurple[300] : Colors.indigo.shade900,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor:
            isDay ? Colors.deepPurple[300] : Colors.indigo.shade900,
        title:
            const Text("Edit Location", style: TextStyle(color: Colors.white)),
      ),
      body: ListView.builder(
          itemCount: locations.length,
          itemBuilder: (context, index) {
            var location = locations[index];
            return Container(
              padding: const EdgeInsets.all(2),
              margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 2),
              child: Card(
                child: ListTile(
                  onTap: () {
                    updateTime(context, location);
                  },
                  tileColor:
                      isDay ? Colors.deepPurple[300] : Colors.indigo.shade700,
                  title: Text(location.location,
                      style: TextStyle(
                          color: isDay ? Colors.black : Colors.white)),
                  leading: CircleAvatar(
                    backgroundImage: AssetImage("images/${location.flag}"),
                  ),
                ),
              ),
            );
          }),
    );
  }

  void updateTime(BuildContext context, WorldTime worldTime) async {
    var responseTime = await worldTime.getTime();
    if (context.mounted) {
      Navigator.pop(context, {
        "location": worldTime.location,
        "flag": worldTime.flag,
        "isDay": worldTime.isDay,
        "time": responseTime
      });
    }
  }
}
