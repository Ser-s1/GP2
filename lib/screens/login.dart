import 'package:final_projict/screens/home.dart';
import 'package:final_projict/screens/home_login.dart';
import 'package:flutter/material.dart';
import 'package:final_projict/control/control.dart';
import 'package:final_projict/screens/registration.dart';
import 'package:final_projict/control/widgets.dart';
import 'package:final_projict/control/Button.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => LoginState();
}

final emailController = TextEditingController();
final passwordController = TextEditingController();

class LoginState extends State<Login> {
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

              TextFieldWidget(hint: "Email", Controller: emailController),

              TextFieldWidget(
                hint: "Password",
                 Controller: passwordController,
                 isObscure: true,
                 ),
                
               ElevatedButton(
                onPressed: () async {
                  try{
                   await Database().login(
                    email: emailController.text,
                    password: passwordController.text,
                  );
                    if (context.mounted) {
                      context.push(context, HomeLogin());
                    }
                  }catch(e){
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(e.toString()))
                      );
                  }
                }, 
                child: Text("login")
              ),
              TextButton(
                  onPressed: () async {
                    context.pushAndDelete(context, Registration());
                  },
                  child: Text("don't have an account? signup"),
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