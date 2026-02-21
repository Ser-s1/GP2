import 'package:flutter/material.dart';

extension Nav on BuildContext{
void push(BuildContext context,Widget target){
    Navigator.push(context,MaterialPageRoute(builder: (context) {
      return target;
    },));
  }

void pushAndDelete(BuildContext context, Widget target) {
  Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => target),
    (route) => false, 
  );
}
}