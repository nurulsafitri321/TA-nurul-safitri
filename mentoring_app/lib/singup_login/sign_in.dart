import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mentoring_app/api/my_api.dart';
import 'package:mentoring_app/models/user_model.dart';
import 'package:mentoring_app/models/user_provider.dart';
import 'package:mentoring_app/singup_login/sign_up.dart';
import 'package:mentoring_app/welcome/main_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:email_validator/email_validator.dart';
import 'package:provider/provider.dart';


class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController textController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  late Future<void> _loginFuture;

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

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      var email = emailController.text;
      var password = textController.text;

      var data = {
        'email': email,
        'password': password,
      };

      var res = await CallApi().postData(data, 'login');
      var body = json.decode(res.body);
      print(body); // Untuk debugging, melihat response dari server

      if (body['success'] != null && body['success'] == true) {
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        localStorage.setString('token', body['token']);
        localStorage.setString('user', json.encode(body['user']));

        final user = UserModel.fromJson(body['user']);
        Provider.of<UserProvider>(context, listen: false).setUser(user);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MainPage(),
          ),
        );
      } else {
        _showMsg(body['message'] ?? 'Login failed');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white, // Warna hijau soft
      body: SingleChildScrollView(
        child: Container(
          height: height,
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: _formKey,
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
                SizedBox(height: height * 0.05),
                Center(
                  child: Column(
                    children: [
                      Image.asset("img/logo.png", height: 100), // Gambar logo
                      SizedBox(height: 20),
                      Text(
                        "Silahkan Login Ikhwah !",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 51, 148, 91)),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.05),
                TextInput(
                  textString: "Email",
                  textController: emailController,
                  hint: "Email",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email tidak boleh kosong';
                    } else if (!EmailValidator.validate(value)) {
                      return 'Email tidak valid';
                    }
                    return null;
                  },
                ),
                SizedBox(height: height * 0.03),
                TextInput(
                  textString: "Password",
                  textController: textController,
                  hint: "Password",
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password tidak boleh kosong';
                    } else if (value.length < 6) {
                      return 'Password harus terdiri dari minimal 6 karakter';
                    }
                    return null;
                  },
                ),
                SizedBox(height: height * 0.05),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _loginFuture = _login();
                    });
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromARGB(255, 51, 148, 91),
                    ),
                    child: Center(
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Belum punya akun? ", style: TextStyle(fontSize: 16)),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
                      },
                      child: Text("Register", style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 51, 148, 91), fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
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
  final String? Function(String?)? validator;

  TextInput({
    Key? key,
    required this.textString,
    required this.textController,
    required this.hint,
    this.obscureText = false,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Color(0xFF000000)),
      cursorColor: Color(0xFF9b9b9b),
      controller: textController,
      keyboardType: TextInputType.text,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: this.hint,
        hintStyle: TextStyle(
          color: Color(0xFF9b9b9b),
          fontSize: 15,
          fontWeight: FontWeight.normal,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Color(0xFF9b9b9b)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Color(0xFF51c6a0)),
        ),
      ),
      validator: validator,
    );
  }
}
