import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:music_app/model/song.dart';
import 'package:music_app/screens/introScreen.dart';
import 'package:music_app/screens/playlistScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  
  LoginScreen({
    Key? key,
    
  }) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isChecked = false;
  @override
  Widget build(BuildContext context1) {
    return Material(
        child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.black,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //head
              Container(
                margin: EdgeInsets.only(bottom: 30),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => IntroScreen(),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(
                            top: 50, left: 20, bottom: 20),
                        child: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                    Container(
                      width: 300,
                      margin:
                          const EdgeInsets.only(top: 50, left: 20, bottom: 20),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Username',
                    hintStyle: TextStyle(color: Colors.white60),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: TextStyle(color: Colors.white60),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                child: Row(
                  children: [
                    Checkbox(
                      value: _isChecked,
                      onChanged: (value) => {
                        setState(() {
                          _isChecked = value!;
                        })
                      },
                      activeColor: Colors.white,
                      checkColor: Colors.black,
                    ),
                    const Text(
                      'I accept Privacy Pocily + Terms of Services',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context1,
                    MaterialPageRoute(
                      builder: (context1) =>
                          PlaylistScreen(),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(top: 30),
                  width: 300,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30, left: 96),
                child: Row(
                  children: [
                    Container(
                      height: 1,
                      width: 100,
                      color: Colors.white,
                    ),
                    Container(
                      child: Text(
                        ' OR ',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Container(
                      height: 1,
                      width: 100,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Image(
                        image: AssetImage('assets/img/google.png'),
                        height: 30,
                        width: 30,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30, left: 20),
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Image(
                        image: AssetImage('assets/img/facebook.png'),
                        height: 30,
                        width: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
