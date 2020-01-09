import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  labelText: 'Email',
  isDense: true,
  fillColor: Colors.white,
  filled: true,
  hintText: '',
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2.0)
  ),
  focusedBorder: OutlineInputBorder(
     borderSide: BorderSide(color: Colors.orange, width: 2.0)
  )
  );