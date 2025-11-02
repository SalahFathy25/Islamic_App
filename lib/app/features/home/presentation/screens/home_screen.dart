import 'package:flutter/material.dart';
import 'package:islamic_app/app/features/home/presentation/widgets/home_bottom_nav_bar.dart';
import 'package:islamic_app/app/features/home/presentation/widgets/home_appbar.dart';
import 'package:islamic_app/app/features/home/presentation/widgets/home_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [HomeAppbar(), HomeBody()]),
      ),
      bottomNavigationBar: HomeBottomNavBar(),
    );
  }
}
