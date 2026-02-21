import 'package:flutter/material.dart';
import 'package:final_projict/control/control.dart';
import 'package:final_projict/control/widgets.dart';
import 'package:final_projict/control/Button.dart';
import 'package:final_projict/screens/login.dart';
import 'package:final_projict/screens/home.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => RegistrationState();
}

final emailController = TextEditingController();
final passwordController = TextEditingController();



class RegistrationState extends State<Registration> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.sizeOf(context).width;
    var screenHeight = MediaQuery.sizeOf(context).height;
    return Scaffold(

      body:Container(
            decoration: BoxDecoration(
            image: DecorationImage(
            image: AssetImage('lib/assets/back2.png'),
            fit: BoxFit.cover, 
              ),
            ),  
            child:Center(
              child:Container(
                width: screenWidth*0.8,
                height: screenHeight*0.45,
                decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/assets/image2.png'),
                  fit: BoxFit.cover,),
                borderRadius: BorderRadius.all(Radius.elliptical(12, 12))
                ),
                child: 
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      TextFieldWidget(hint: "Email", Controller: emailController),

                      TextFieldWidget(
                        hint: "Password",
                         Controller: passwordController,
                         isObscure: true,
                         ),

                ElevatedButton(
                  onPressed: () async{
                    try{
                    await Database().signUp(
                    email: emailController.text,
                    password: passwordController.text,
                    );
                    if (context.mounted) {
                      context.pushAndDelete(context, Login());
                    }
                    }catch(e){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Error during registration"))
                      );
                  }
                  },
                  child: Text("Sign up"),
                ),
                TextButton(
                  onPressed: () {
                    context.pushAndDelete(context, Login());
                  },
                  child: Text("have an account? login"),
                ),
                TextButton(
                  onPressed: () async {
                    context.pushAndDelete(context, Home());
                  },
                  child: Text("Home page"),
              ),
                    ],
                  ),
              )
            )
      )
    );
  }
}