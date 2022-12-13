import 'package:flutter/material.dart';
import 'package:invoice_generator/Home.dart';
import 'package:invoice_generator/SpalshScreen.dart';
import 'Preview.dart';

void main()
{
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/' : (context) => Spalsh(),
        'Home' : (context) => Home(),
        'Preview' : (context) => Preview(),
      },
    )
  );
}