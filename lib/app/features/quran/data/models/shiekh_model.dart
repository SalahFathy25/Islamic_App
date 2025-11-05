import 'package:flutter/material.dart';
import 'package:islamic_app/gen/assets.gen.dart';

class ShiekhModel {
  final String name;
  final Widget image;

  ShiekhModel({required this.name, required this.image});
}

List<ShiekhModel> shiekhList = [
  ShiekhModel(
    name: 'الشيخ خالد الجليل',
    image: Assets.images.sheikhs.khaledElgaleel.image(),
  ),
  ShiekhModel(
    name: 'الشيخ خالد الجليل',
    image: Assets.images.sheikhs.khaledElgaleel.image(),
  ),
  ShiekhModel(
    name: 'الشيخ خالد الجليل',
    image: Assets.images.sheikhs.khaledElgaleel.image(),
  ),
  ShiekhModel(
    name: 'الشيخ خالد الجليل',
    image: Assets.images.sheikhs.khaledElgaleel.image(),
  ),
];
