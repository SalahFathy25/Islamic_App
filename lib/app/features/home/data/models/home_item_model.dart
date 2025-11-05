import 'package:flutter/material.dart';
import 'package:islamic_app/app/core/routes/routes.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../core/utils/app_strings.dart';

class HomeItemModel {
  final String title;
  final Widget image;
  final String nextScreen;

  HomeItemModel({
    required this.title,
    required this.image,
    required this.nextScreen,
  });
}

final List<HomeItemModel> shortcutItems = [
  HomeItemModel(
    image: Assets.images.homeImages.quranImage.image(),
    title: AppStrings.quranTitle,
    nextScreen: Routes.quranScreen,
  ),
  HomeItemModel(
    image: Assets.images.homeImages.prayerImage.image(),
    title: AppStrings.prayerTitle,
    nextScreen: Routes.homeScreen,
  ),
  HomeItemModel(
    image: Assets.images.homeImages.azkaarImage.image(),
    title: AppStrings.azkaarTitle,
    nextScreen: Routes.homeScreen,
  ),
  HomeItemModel(
    image: Assets.images.homeImages.zakaahImage.image(),
    title: AppStrings.zakaahTitle,
    nextScreen: Routes.homeScreen,
  ),
  HomeItemModel(
    image: Assets.images.homeImages.hagImage.image(),
    title: AppStrings.hagTitle,
    nextScreen: Routes.homeScreen,
  ),
];

final List<HomeItemModel> doaasItems = [
  HomeItemModel(
    image: Assets.images.homeImages.duaaMotauafiImage.image(),
    title: AppStrings.doaaForDeathTitle,
    nextScreen: Routes.homeScreen,
  ),
  HomeItemModel(
    image: Assets.images.homeImages.doaaOutOfHomeImage.image(),
    title: AppStrings.doaaForGoOutTitle,
    nextScreen: Routes.homeScreen,
  ),
  HomeItemModel(
    image: Assets.images.homeImages.doaaArafaImage.image(),
    title: AppStrings.doaaForArafaaTitle,
    nextScreen: Routes.homeScreen,
  ),
  HomeItemModel(
    image: Assets.images.homeImages.doaaFridayImage.image(),
    title: AppStrings.doaaForFridayTitle,
    nextScreen: Routes.homeScreen,
  ),
  HomeItemModel(
    image: Assets.images.homeImages.doaaSafarImage.image(),
    title: AppStrings.doaaForTravelTitle,
    nextScreen: Routes.homeScreen,
  ),
  HomeItemModel(
    image: Assets.images.homeImages.doaaShefaaImage.image(),
    title: AppStrings.doaaForHealthTitle,
    nextScreen: Routes.homeScreen,
  ),
];
