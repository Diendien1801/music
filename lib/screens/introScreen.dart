import 'package:flutter/material.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.black,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 50),
                    child: Text(
                      'Melody',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  Container(
                    child: Image(
                      image: AssetImage('assets/img/melody.png'),
                      color: Colors.white,
                      height: 100,
                      width: 100,
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
