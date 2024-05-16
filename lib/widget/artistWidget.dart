import 'package:flutter/material.dart';

Widget artistWidget(index) {
  return Container(
    height: 200,
    width: 100,
    margin: const EdgeInsets.all(10),
    child: Column(
      children: [
        // Avatar
        Container(
          height: 100,
          width: 100,
          child: const CircleAvatar(
            backgroundImage: AssetImage("assets/img/mtp.png"),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: const Text(
            "MTP",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          height: 26,
          width: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
          margin: const EdgeInsets.only(top: 5),
          child: const Center(
            child: Text(
              "Follow",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    ),
  );
}
