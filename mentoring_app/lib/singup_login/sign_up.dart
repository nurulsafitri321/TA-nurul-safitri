import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mentoring_app/api/my_api.dart';
import 'package:mentoring_app/components/text_widget.dart';
import 'package:mentoring_app/singup_login/sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  _showMsg(msg) {
    final snackBar = SnackBar(
      backgroundColor: Color.fromARGB(255, 51, 148, 91),
      content: Text(msg),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  _register() async {
    var data = {
      'name': nameController.text,
      'email': emailController.text,
      'password': passwordController.text,
      'password_confirmation': confirmPasswordController.text,
    };

    var res = await CallApi().postData(data, 'register');
    var body = json.decode(res.body);
    print(body);  // Untuk debugging, melihat response dari server

    if (body['success'] != null && body['success'] == true) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', body['token']);
      localStorage.setString('user', json.encode(body['user']));
      Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (context) => SignIn(),
        ),
      );
    } else {
      _showMsg(body['message'] ?? 'Registration failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFFffffff),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 30, right: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.1),
              Container(
                padding: const EdgeInsets.only(left: 0, right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                      icon: Icon(Icons.arrow_back_ios, color: Color.fromARGB(255, 51, 148, 91)),
                      onPressed: () => Navigator.of(context, rootNavigator: true).pop(context),
                    )
                  ],
                ),
              ),
              SizedBox(height: height * 0.01),
              TextWidget(text: "Create Account", fontSize: 26, isUnderLine: false),
              TextWidget(text: "to Get Started", fontSize: 26, isUnderLine: false),
              SizedBox(height: height * 0.1),
              TextInput(textString: "Name", textController: nameController, hint: "Name"),
              SizedBox(height: height * 0.05),
              TextInput(textString: "Email", textController: emailController, hint: "Email"),
              SizedBox(height: height * 0.05),
              TextInput(textString: "Password", textController: passwordController, hint: "Password", obscureText: true),
              SizedBox(height: height * 0.05),
              TextInput(textString: "Confirm Password", textController: confirmPasswordController, hint: "Confirm Password", obscureText: true),
              SizedBox(height: height * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(text: "Sign Up", fontSize: 22, isUnderLine: false),
                  GestureDetector(
                    onTap: () {
                      _register();
                    },
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 51, 148, 91),
                      ),
                      child: Icon(Icons.arrow_forward, color: Colors.white, size: 30),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: TextWidget(text: "Sign in", fontSize: 16, isUnderLine: true),
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

class TextInput extends StatelessWidget {
  final String textString;
  final TextEditingController textController;
  final String hint;
  final bool obscureText;

  TextInput({
    Key? key,
    required this.textString,
    required this.textController,
    required this.hint,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: Color(0xFF000000)),
      cursorColor: Color(0xFF9b9b9b),
      controller: textController,
      keyboardType: TextInputType.text,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: this.textString,
        hintStyle: TextStyle(
          color: Color(0xFF9b9b9b),
          fontSize: 15,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
