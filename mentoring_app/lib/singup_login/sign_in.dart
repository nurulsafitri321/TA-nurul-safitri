import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mentoring_app/api/my_api.dart';
import 'package:mentoring_app/components/text_widget.dart';
import 'package:mentoring_app/pages/article_page.dart';
import 'package:mentoring_app/singup_login/sign_up.dart';
import 'package:mentoring_app/welcome/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController textController = TextEditingController();
  TextEditingController emailController = TextEditingController();

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

  _login() async {
    var data = {
      'email': emailController.text,
      'password': textController.text,
    };

    var res = await CallApi().postData(data, 'login');
    var body = json.decode(res.body);
    print(body); // Untuk debugging, melihat response dari server

    if (body['success'] != null && body['success'] == true) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', body['token']);
      localStorage.setString('user', json.encode(body['user']));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ArticlePage(),
        ),
      );
    } else {
      _showMsg(body['message'] ?? 'Login failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFFffffff),
      body: SingleChildScrollView(
        child: Container(
          height: height,
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
              SizedBox(height: height * 0.1),
              TextWidget(text: "Here to Get", fontSize: 26, isUnderLine: false),
              TextWidget(text: "Welcomed !", fontSize: 26, isUnderLine: false),
              SizedBox(height: height * 0.1),
              TextInput(textString: "Email", textController: emailController, hint: "Email"),
              SizedBox(height: height * 0.05),
              TextInput(textString: "Password", textController: textController, hint: "Password", obscureText: true),
              SizedBox(height: height * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(text: "Sign in", fontSize: 22, isUnderLine: false),
                  GestureDetector(
                    onTap: () {
                      _login();
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
              SizedBox(height: height * 0.1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
                    },
                    child: TextWidget(text: "Sign up", fontSize: 16, isUnderLine: true),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: TextWidget(text: "Forgot Password", fontSize: 16, isUnderLine: true),
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
