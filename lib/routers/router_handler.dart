import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import '../index_page.dart';


Handler homeHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>>params) {
  return IndexPage();
});

