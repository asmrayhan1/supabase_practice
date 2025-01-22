import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supabase_project/screen/profile/profile_screen.dart';

import '../login/login_screen.dart';
import '../service/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final authServer = AuthService();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //final register = ref.watch(registerProvider);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 100),
              Center(child: Text("Create an account", style: TextStyle(color: Colors.black, fontSize: 28, fontWeight: FontWeight.w800),)),
              Center(child: Text("Connect with your friends today!", style: TextStyle(color: Colors.black, fontSize: 20),)),
              SizedBox(height: 50),
              TextField(
                controller: _emailController,
                maxLines: 1,
                maxLength: 40,
                decoration: InputDecoration(
                  counter: Offstage(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),  // Rounded corners
                  ),
                  hintText: "Email",
                  hintStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                ),
                style: TextStyle (
                    fontSize: 20
                ),
              ),
              SizedBox(height: 30),
              TextField(
                controller: _passwordController,
                maxLines: 1,
                maxLength: 40,
                decoration: InputDecoration(
                  counter: Offstage(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),  // Rounded corners
                  ),
                  hintText: "Password",
                  hintStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                ),
                style: TextStyle (
                    fontSize: 20
                ),
              ),
              SizedBox(height: 30),
              TextField(
                controller: _confirmPasswordController,
                maxLines: 1,
                maxLength: 40,
                decoration: InputDecoration(
                  counter: Offstage(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),  // Rounded corners
                  ),
                  hintText: "Confirm Password",
                  hintStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                ),
                style: TextStyle (
                    fontSize: 20
                ),
              ),
              SizedBox(height: 50),
              GestureDetector(
                onTap: ()async{
                  try {
                    if (_emailController.text.trim().isNotEmpty && _passwordController.text.trim().isNotEmpty && _passwordController.text.trim() == _confirmPasswordController.text.trim()){
                      await authServer.signUpWIthEmailPassword(
                          _emailController.text.trim(), _passwordController.text.trim()
                      );
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
                    } else {
                      print("Invalid Input");
                    }
                  } catch (e){
                    print(e);
                  }
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),  // Corrected: Use `borderRadius` instead of `border`
                    color: Colors.blue,
                  ),
                  child: Center(child: Text("Sign Up", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 23, color: Colors.white))),
                ),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),),
                  SizedBox(width: 5),
                  GestureDetector(
                      onTap: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                      },
                      child: Text("Login", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20, color: Colors.deepPurple),)
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
