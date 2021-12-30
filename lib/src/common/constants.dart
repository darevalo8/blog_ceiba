import 'package:flutter/material.dart';


const String apiUrl = "jsonplaceholder.typicode.com";

String getEnvironment(){

  return apiUrl;
}


Color hexToColor(String code) {
  return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}