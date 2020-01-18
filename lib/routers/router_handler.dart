import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import '../index_page.dart';
import '../pages/opacity_page.dart';
import '../pages/radius_page.dart';
import '../pages/size_pages.dart';
import '../pages/translation_page.dart';
import '../pages/curves_page.dart';
import '../pages/fourD_page.dart';

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

Handler fourDPageHandle = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>>params) {
  return FourDPage();
});