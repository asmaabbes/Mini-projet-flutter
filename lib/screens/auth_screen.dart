
import 'package:application_enova_robotics/Screens/login_page.dart';
import 'package:application_enova_robotics/screens/signup_screen.dart';
import 'package:flutter/material.dart';

class Auth extends StatefulWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  State<Auth> createState() => _AuthState();
}
class _AuthState extends State<Auth> {
  bool showLoginPage = true;
  
  void toggleScreens(){
    setState(() {
      showLoginPage =! showLoginPage;
    });
  }
  @override
  Widget build(BuildContext context) {

    if(showLoginPage){
      return Login(showSignUpPage: toggleScreens);
    }else{
      return SignUp(showLoginPage: toggleScreens);
    }
    
  }
}