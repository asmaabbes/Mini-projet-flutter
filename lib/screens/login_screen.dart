
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:iconsax/iconsax.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  final VoidCallback showSignUpPage;
  const Login({Key? key, required this.showSignUpPage}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  bool _passwordVisible = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future signIn() async {
    try {
      if (_formKey.currentState!.validate()) {
        FirebaseAuth auth = FirebaseAuth.instance;
        await auth.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        ScaffoldMessenger.of(context).showSnackBar(
           const  SnackBar(
              content: Text("Connected..."),
            ),
          );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Error'),
            content: Text('${e.message}'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: const Text('Ok'),
              )
            ],
          ),
        );
      } else if (e.code == 'wrong-password') {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Error'),
            content: Text('${e.message}'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: const Text('Ok'),
              )
            ],
          ),
        );
      }
    }
  }

  
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }
  

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        body: SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Container(
              height: 350,
              child: Stack(children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Image.asset(
                    'assets/images/logoEnovaRobotics.png',
                    height: 400,
                  ),
                ),
              ]),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              cursorColor: Colors.black,
              controller: _emailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter email';
                }
                return null;
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(0.0),
                labelText: 'Email',
                hintText: 'e-mail',
                labelStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                ),
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14.0,
                ),
                prefixIcon: const Icon(
                  Iconsax.user,
                  color: Colors.black,
                  size: 18,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                floatingLabelStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black, width: 1.5),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              obscureText: !_passwordVisible,
              cursorColor: Colors.black,
              controller: _passwordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter password';
                }
                return null;
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(0.0),
                suffixIcon:  IconButton(
                  icon:Icon(_passwordVisible ? Icons.visibility:Icons.visibility_off,),
                   onPressed: _toggle,
                   color: Colors.grey,
                   ),
                labelText: 'Password',
                hintText: 'Password',
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14.0,
                ),
                labelStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                ),
                prefixIcon: const Icon(
                  Iconsax.key,
                  color: Colors.black,
                  size: 18,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                floatingLabelStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black, width: 1.5),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            MaterialButton(
              onPressed: signIn,
              height: 45,
              color: const Color.fromARGB(255, 92, 91, 91),
              child: Text(
                "Login",
                style: const TextStyle(color: Colors.white, fontSize: 16.0),
              ),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Don\'t have an account?',
                  style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400),
                ),
                TextButton(
                  onPressed: widget.showSignUpPage,
                  child: const Text(
                    'Sign up',
                    style: TextStyle(
                        color: Color.fromARGB(255, 25, 181, 155),
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    )));
  }
}
