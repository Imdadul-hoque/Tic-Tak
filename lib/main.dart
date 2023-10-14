
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/game_page.dart';

void main() {
  runApp(const MyApp());
}
class  extends StatelessWidget {
  const ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
return MaterialApp(
title: 'Flutter Demo',
debugShowCheckedModeBanner: false,
theme: ThemeData(

primarySwatch: Colors.blue,
),
home: GamePage(

),
);
  }
}


