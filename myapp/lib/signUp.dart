// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myapp/homepage.dart';
import 'package:myapp/login.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class SignUp extends StatefulWidget {
  static const String path = "signup";
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  Map _userData = {};

  void toast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      backgroundColor: Colors.black,
      textColor: Colors.white,
    );
  }

  void _snackBar(text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.red, fontFamily: "Raleway"),
    )));
  }

  void signInwithFacebook() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();

    final UserMetadata = await FacebookAuth.instance.getUserData();
    final AccessToken accessToken = loginResult.accessToken!;
    _userData = UserMetadata;
    final OAuthCredential oAuthCredential =
        await FacebookAuthProvider.credential(accessToken.token);

    final result =
        await FirebaseAuth.instance.signInWithCredential(oAuthCredential);

    Navigator.pushNamed(context, HomePage.path);
  }

  /*void signInwithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance
          .login(permissions: (['email', 'public_profile']));
      final token = result.accessToken!.token;
      final graphResponse = await http.get(Uri.parse(
          'https://graph.facebook.com/'
          'v2.12/me?fields=name,first_name,last_name,email&access_token=${token}'));
      try {
        final AuthCredential facebookCredential =
            FacebookAuthProvider.credential(result.accessToken!.token);
        final userCredential = await FirebaseAuth.instance
            .signInWithCredential(facebookCredential);
        Navigator.pushNamed(context, HomePage.path);
      } catch (e) {}
    } catch (e) {}
  }*/

  Future signInGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? gooleAuth =
        await googleUser!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: gooleAuth!.accessToken,
      idToken: gooleAuth.idToken,
    );
    final result = await FirebaseAuth.instance.signInWithCredential(credential);

    final user = result.user;

    if (user != null) {
      final route = MaterialPageRoute(
          builder: (_) => HomePage(
                user: user,
              ));
      Navigator.push(context, route);
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Color.fromARGB(255, 255, 255, 255)));
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 28.0,
                  bottom: 14,
                ),
                child: Center(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: Icon(Icons.arrow_back)),
                          Container(
                            decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                color: Color.fromARGB(255, 94, 182, 229),
                              )),
                            ),
                            child: Text(
                              "SIGNUP",
                              style: TextStyle(
                                fontFamily: "Raleway",
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Image.asset(
                "assets/images/3.png",
                width: MediaQuery.of(context).size.width * 1.0,
                height: MediaQuery.of(context).size.width * 0.7,
                fit: BoxFit.contain,
              ),
            ],
          ),
          Column(
            children: [
              Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 52.0,
                      right: 52.0,
                    ),
                    child: Column(
                      children: [
                        Material(
                          elevation: 12,
                          shadowColor: Color.fromARGB(255, 43, 99, 61),
                          color: Colors.transparent,
                          shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                color: Colors.transparent,
                              )),
                          child: TextFormField(
                            controller: _emailController,
                            validator: (e) {
                              if (e!.isEmpty) {
                                return "Field must not be empty!";
                              } else if (!e.contains("@gmail.com")) {
                                return "Enter a valid email!";
                              }
                              return null;
                            },
                            style: TextStyle(
                              letterSpacing: 1.7,
                              color: Color.fromARGB(255, 94, 182, 229),
                              fontFamily: "Raleway",
                            ),
                            cursorColor: Color.fromARGB(255, 108, 244, 54),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(16),
                              filled: true,
                              fillColor: Color.fromARGB(255, 250, 253, 236),

                              prefixIcon: Icon(
                                Icons.person,
                                color: Color.fromARGB(255, 94, 182, 229),
                              ),
                              suffixIcon: Icon(
                                Icons.mail,
                                color: Color.fromARGB(255, 94, 182, 229),
                              ),
                              hintText: "Email",
                              errorStyle: TextStyle(
                                fontFamily: "Raleway",
                              ),
                              hintStyle: TextStyle(
                                color: Color.fromARGB(255, 94, 182, 229),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              // suffixIcon: ,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Card(
                          elevation: 12,
                          color: Colors.transparent,
                          shadowColor: Color.fromARGB(255, 43, 99, 61),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          child: TextFormField(
                            controller: _passwordController,
                            validator: (e) {
                              if (e!.isEmpty) {
                                return "Field must not be empty!";
                              } else if (e.length < 8) {
                                return "Password should be in 8 characters!";
                              } else if (e.contains(RegExp(r'(\w+)'))) {}
                              return null;
                            },
                            obscureText: _obscureText,
                            obscuringCharacter: "◉",
                            style: TextStyle(
                              letterSpacing: 1.7,
                              color: Color.fromARGB(255, 94, 182, 229),
                              fontFamily: "Raleway",
                            ),
                            cursorColor: Color.fromARGB(255, 108, 244, 54),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color.fromARGB(255, 250, 253, 236),
                              contentPadding: EdgeInsets.all(16),

                              prefixIcon: Icon(
                                Icons.lock,
                                color: Color.fromARGB(255, 94, 182, 229),
                              ),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                  icon: Icon(
                                    _obscureText
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Color.fromARGB(255, 94, 182, 229),
                                  )),
                              hintText: "Password",
                              errorStyle: TextStyle(
                                fontFamily: "Raleway",
                              ),
                              hintStyle: TextStyle(
                                color: Color.fromARGB(255, 94, 182, 229),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              // suffixIcon: ,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 94, 182, 229),
                            elevation: 12,
                            shadowColor: Color.fromARGB(255, 43, 99, 61),
                            minimumSize: Size(290, 45),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              try {
                                UserCredential userCredential =
                                    await FirebaseAuth.instance
                                        .createUserWithEmailAndPassword(
                                            email: _emailController.text,
                                            password: _passwordController.text);

                                toast("Successfully created");
                                Navigator.of(context).pushNamed(LoginPage.path);
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'weak-password') {
                                  _snackBar("The password provied is too weak");
                                } else if (e.code == 'email-already-in-use') {
                                  _snackBar(
                                      "The account already exists for that email");
                                }
                              } catch (e) {
                                _snackBar("Email is invalid or already taken");
                              }
                            }
                          },
                          child: Text(
                            "SIGNUP",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Raleway",
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an Account?",
                              style: TextStyle(
                                fontFamily: "Raleway",
                                color: Color.fromARGB(255, 144, 141, 141),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, LoginPage.path);
                              },
                              child: Text(
                                "Sign In",
                                style: TextStyle(
                                    fontFamily: "Raleway",
                                    color: Color.fromARGB(255, 94, 182, 229),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 120,
                              height: 0.5,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 144, 141, 141),
                              ),
                            ),
                            SizedBox(width: 5),
                            Text(
                              "OR",
                              style: TextStyle(
                                  fontFamily: "Raleway",
                                  color: Color.fromARGB(255, 94, 182, 229),
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 5),
                            Container(
                              width: 120,
                              height: 0.5,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 144, 141, 141),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              borderRadius: BorderRadius.circular(60),
                              onTap: () {
                                // signInFacebook();
                                signInwithFacebook();
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      width: 0.5,
                                      color: Color.fromARGB(255, 144, 141, 141),
                                    )),
                                child: Image.asset(
                                  "assets/images/fb.png",
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                            InkWell(
                              borderRadius: BorderRadius.circular(60),
                              onTap: () {},
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      width: 0.5,
                                      color: Color.fromARGB(255, 144, 141, 141),
                                    )),
                                child: Image.asset(
                                  "assets/images/twitter.png",
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                            InkWell(
                              borderRadius: BorderRadius.circular(60),
                              onTap: () {
                                signInGoogle();
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      width: 0.5,
                                      color: Color.fromARGB(255, 144, 141, 141),
                                    )),
                                child: Image.asset(
                                  "assets/images/google.png",
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
              Image.asset(
                "assets/images/d2.png",
                width: 900,
                height: 93,
                fit: BoxFit.fill,
              ),
            ],
          )
        ],
      ),
    );
  }
}
