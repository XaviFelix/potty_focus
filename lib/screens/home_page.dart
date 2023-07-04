import 'package:flutter/material.dart';
import 'package:potty_focus/widget/timer_widget.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        backgroundColor: Colors.deepPurple,
        body: Column(
            children: [
              SizedBox(height: 50,),
              MyTimerWidget()
            ]
        ),
      ),
    );
  }
}