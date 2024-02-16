import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map? data;

  @override
  Widget build(BuildContext context) {
    data ??= ModalRoute.of(context)?.settings.arguments as Map?;
    bool isDay = (data?["isDay"] as bool);
    String backgroundImage = (data?["isDay"] as bool) ? "day.png" : "night.png";

    return Scaffold(
      backgroundColor: isDay ? Colors.blue : Colors.indigo.shade900,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/$backgroundImage"),
                  fit: BoxFit.cover)),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(0, 64, 0, 0),
                child: OutlinedButton.icon(
                  onPressed: () async {
                    dynamic time = await Navigator.pushNamed(
                        context, "/location",
                        arguments: {"isDay": isDay});
                    print(time);
                    setState(() {
                      data = {
                        "location": time["location"],
                        "flag": time["flag"],
                        "isDay": time["isDay"],
                        "time": time["time"]
                      };
                    });
                  },
                  icon: Icon(Icons.edit_location,
                      color: isDay ? Colors.black : Colors.white),
                  label: Text("edit location",
                      style: TextStyle(
                          color: isDay ? Colors.black : Colors.white)),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(24, 16, 0, 16),
                          child: Text(
                            "Location",
                            style: TextStyle(
                                fontSize: 18,
                                letterSpacing: 2.5,
                                color: isDay ? Colors.black : Colors.white),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(24, 16, 0, 16),
                          child: Text(
                            "Time",
                            style: TextStyle(
                                fontSize: 18,
                                letterSpacing: 2.5,
                                color: isDay ? Colors.black : Colors.white),
                          ),
                        )
                      ]),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 16, 0, 16),
                        child: Text(data?["location"] ?? "Location not found",
                            style: TextStyle(
                                fontSize: 20,
                                letterSpacing: 2.5,
                                fontWeight: FontWeight.bold,
                                color: isDay ? Colors.black : Colors.white)),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 16, 0, 16),
                        child: Text(data?["time"] ?? "Location not found",
                            style: TextStyle(
                                fontSize: 18,
                                letterSpacing: 2.5,
                                color: isDay ? Colors.black : Colors.white)),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
