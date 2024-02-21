import 'dart:io';

import 'package:flutter/material.dart';
import 'package:world_time/pages/choose_location.dart';
import 'package:world_time/pages/home.dart';
import 'package:world_time/pages/loading.dart';

import 'model/my_http_overrides.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(MaterialApp(
    routes: {
      "/": (context) => const Loading(),
      "/location": (context) => const ChooseLocation(),
      "/home": (context) => const Home()
    },
  ));
}
