import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supabase_project/auth/register/register_screen.dart';
import 'package:supabase_project/auth/service/auth_service.dart';
import 'package:supabase_project/screen/profile/profile_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final authServer = AuthService();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //final login = ref.watch(loginProvider);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 100),
              Center(child: Text("Hi, Welcome Back!", style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.w800),)),
              SizedBox(height: 60),
              Row(
                children: [
                  SizedBox(width: 5),
                  Text("Email", style: TextStyle(color: Colors.black, fontSize: 20,)),
                ],
              ),
              SizedBox(height: 5),
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
              Row(
                children: [
                  SizedBox(width: 5),
                  Text("Password", style: TextStyle(color: Colors.black, fontSize: 20,)),
                ],
              ),
              SizedBox(height: 5),
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
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.check_box_outlined, size: 29,),
                      SizedBox(width: 3),
                      Text("Remember me", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),),
                    ],
                  ),
                  Text("Forgot Password?", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20, color: Colors.red),),
                ],
              ),
              SizedBox(height: 50),
              GestureDetector(
                onTap: () async {
                  try {
                    if (_emailController.text.trim().isNotEmpty && _passwordController.text.trim().isNotEmpty){
                      await authServer.signInWIthEmailPassword(
                          _emailController.text.trim(), _passwordController.text.trim()
                      );
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
                    } else {
                      print("Invalid Input");
                    }
                  } catch (e){
                    print(e);
                  }
                  print("Login Button Working");
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),  // Corrected: Use `borderRadius` instead of `border`
                    color: Colors.blue,
                  ),
                  child: Center(child: Text("Login", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 23, color: Colors.white))),
                ),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),),
                  SizedBox(width: 5),
                  GestureDetector(
                      onTap: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RegisterScreen()));
                      },
                      child: Text("Sign Up", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20, color: Colors.deepPurple),)
                  ),
                ],
              ),
              //Text("${_emailController.text}", style: TextStyle(fontSize: 40),),
            ],
          ),
        ),
      ),
    );
  }
}
