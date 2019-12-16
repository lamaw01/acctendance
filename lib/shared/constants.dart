import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  isDense: true,
  fillColor: Colors.white,
  filled: true,
  hintText: 'Email',
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2.0)
  ),
  focusedBorder: OutlineInputBorder(
     borderSide: BorderSide(color: Colors.green, width: 2.0)
  )
  );