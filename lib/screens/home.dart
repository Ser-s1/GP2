import 'package:final_projict/screens/login.dart';
import 'package:final_projict/screens/registration.dart';
import 'package:final_projict/control/api.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Home> {
  @override
  Widget build(BuildContext context) {

    var screenWidth = MediaQuery.sizeOf(context).width;
    var screenHeight = MediaQuery.sizeOf(context).height;
    return Scaffold(
      
     body: 
     Container(
            decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('lib/assets/back1.jpg'),
            fit: BoxFit.cover, 
              ),
            ),
            child:
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Willcom To realstat App",style: TextStyle(color: Colors.white,fontSize: 34),),
                Row( 
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Center( 
                   child:ElevatedButton(onPressed:(){ 
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Registration())); 
                  }, child: Icon(Icons.app_registration)),
                    ),
                  Center(
                    child: ElevatedButton(onPressed:(){ 
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Login())); 
                    }, child: Icon(Icons.login)),
                  ),
                ]
                ),
              ],
            ),        
        )
    );    
    
  
  }
}