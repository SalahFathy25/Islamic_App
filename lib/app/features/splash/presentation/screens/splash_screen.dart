import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:islamic_app/gen/assets.gen.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../home/presentation/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String routeName = '/splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AudioPlayer player = AudioPlayer();
  bool isMuted = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await player.setSource(
        AssetSource(Assets.sounds.splashAudio.replaceFirst('assets/', '')),
      );
      await player.setVolume(1.0);
      await player.resume();
    });

    Future.delayed(const Duration(seconds: 15), () {
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    });
  }

  Future<void> _toggleSound() async {
    if (isMuted) {
      await player.setVolume(1.0);
    } else {
      await player.setVolume(0.0);
    }

    setState(() {
      isMuted = !isMuted;
    });
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: Stack(
        children: [
          Positioned(
            right: 0.0,
            left: 0.0,
            bottom: 0.0,
            top: 20.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Assets.images.a.image(),
                Assets.images.icons.appIcon.svg(),
              ],
            ),
          ),
          Positioned(
            right: 16,
            bottom: 40,
            child: GestureDetector(
              onTap: _toggleSound,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.white2,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Icon(
                    isMuted ? Icons.volume_off : Icons.volume_up,
                    color: AppColors.mainColor,
                    size: 30,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
