import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../../../home/presentation/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String routeName = '/splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AudioPlayer _player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _playSound();

    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    });
  }

  Future<void> _playSound() async {
    await _player.setVolume(1.0);
    // await _player.play(AssetSource('sounds/intro.mp3'));
  }

  Future<void> _muteSound() async {
    await _player.setVolume(0.0);
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(
              "Splash Screen",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.add)),
          ],
        ),
      ),
    );
  }
}
