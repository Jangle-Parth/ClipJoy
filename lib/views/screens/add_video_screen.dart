import 'package:flutter/material.dart';

class AddVideoScreen extends StatelessWidget {
  const AddVideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: InkWell(
        onTap: () {},
        child: Container(
          width: 190,
          height: 50,
          decoration: const BoxDecoration(),
          child: const Center(
            child: Text(
              "Add Video",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      )),
    );
  }
}
