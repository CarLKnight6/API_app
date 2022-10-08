import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';

class AppConfig {
  String api_BASEURL = 'https://api-001.emberspec.com';

  ParticleOptions particles = const ParticleOptions(
    // image: Image.asset('assets/images/bg1.jpg'),
    baseColor: Color.fromARGB(255, 199, 130, 228),
    spawnOpacity: 0.0,
    opacityChangeRate: 0.25,
    minOpacity: 0.1,
    maxOpacity: 0.4,
    particleCount: 70,
    spawnMaxRadius: 15.0,
    spawnMaxSpeed: 100.0,
    spawnMinSpeed: 30,
    spawnMinRadius: 7.0,
  );
}
