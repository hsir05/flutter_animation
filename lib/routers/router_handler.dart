import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import '../index_page.dart';
import '../pages/opacity_page.dart';
import '../pages/radius_page.dart';
import '../pages/size_pages.dart';
import '../pages/translation_page.dart';
import '../pages/curves_page.dart';
import '../pages/threeD_page.dart';
import '../pages/card_page.dart';
import '../pages/six_page.dart';
import '../pages/chart_page.dart';
import '../pages/chart2_page.dart';


Handler homeHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>>params) {
  return IndexPage();
});

Handler opacityHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>>params) {
  return OpacityPage();
});

Handler radiusHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>>params) {
  return RadiusPage();
});

Handler sizeHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>>params) {
  return SizePage();
});

Handler translationPageHandle = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>>params) {
  return TranslationPage();
});

Handler curvesPageHandle = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>>params) {
  return CurvesPage();
});

Handler threeDPageHandle = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>>params) {
  return ThreeDPage();
});



Handler cardPageHandle = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>>params) {
  return CardPage();
});

Handler sixPageHandle = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>>params) {
  return SixPage();
});

Handler chartPageHandle = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>>params) {
  return ChartPage();
});

Handler chart2PageHandle = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>>params) {
  return Chart2Page();
});