import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

BoxDecoration backGroundDecoration = BoxDecoration(
  image: DecorationImage(
    image: AssetImage('assets/cocktailbackground.jpg'),
    fit: BoxFit.cover,
    colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.225), BlendMode.lighten)
  )
);