import 'package:flutter/material.dart';
import 'package:final_projict/control/control.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => RegistrationState();
}

final emailController = TextEditingController();
final passwordController = TextEditingController();
final registerControl = RegisterControl();
final authControl = AuthControl();

class RegistrationState extends State<Registration> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.sizeOf(context).width;
    var screenHeight = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
      ),
      body:Container(
            decoration: BoxDecoration(
            image: DecorationImage(
            image: AssetImage('lib/assets/back1.jpg'),
            fit: BoxFit.cover, 
              ),
            ),        child:Center(
          child:Container(
            width: screenWidth*0.8,
            height: screenHeight*0.3,
            decoration: BoxDecoration(
            color: Colors.brown,
            borderRadius: BorderRadius.all(Radius.elliptical(12, 12))
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: screenHeight*0.09,
                  width: screenWidth*0.7,
                  decoration: BoxDecoration(
                    boxShadow: [ BoxShadow(
                      offset: Offset(5,5),
                      blurRadius: 4,)
                    ],
                    color: Colors.amber,
                    borderRadius: BorderRadius.all(Radius.circular(12))
                  ),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hint:Center(
                        child:
                        Container(
                        child:Text("اكتب ايميلك"))
                      )
                    ),),
                ),
                Container(
                  height: screenHeight*0.09,
                  width: screenWidth*0.7,
                  decoration: BoxDecoration(
                    boxShadow: [ BoxShadow(
                      offset: Offset(5,5),
                      blurRadius: 4,)
                    ],
                    color: Colors.amber,
                    borderRadius: BorderRadius.all(Radius.circular(12))
                  ),
                  child: TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hint:Center(
                        child:
                        Container(
                        child:Text("الرمز السري"))
                      )
                    ),)
                ),
                ElevatedButton(onPressed: ()async{
                  await registerControl.createAccount(
                    emailController.text, 
                    passwordController.text
                    );
                }, child: Text("Registr"))
              ],
            ),
            )
      )
      )
    );
  }
}