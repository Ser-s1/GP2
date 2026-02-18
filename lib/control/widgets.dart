import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String hint;
  final TextEditingController Controller;
  final bool isObscure;

  const TextFieldWidget({
    super.key,
    required this.hint,
    required this.Controller,
    this.isObscure = false,
  });

  @override
  Widget build(BuildContext context) {
    
    var screenWidth = MediaQuery.sizeOf(context).width;
    var screenHeight = MediaQuery.sizeOf(context).height;

    return Container(
                  height: screenHeight*0.09,
                  width: screenWidth*0.7,
                  decoration: BoxDecoration(
                    boxShadow: [ BoxShadow(
                      offset: Offset(5,5),
                      blurRadius: 4,)
                    ],
                    color: const Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.all(Radius.circular(12))
                  ),
                  child: TextField(
                    controller: Controller,
                    obscureText: isObscure,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hint:Center(
                        child:
                        Text("$hint"))
                    ),
                    ),
                
        );
  }
}