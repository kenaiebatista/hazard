import 'package:flutter/material.dart';

class CardForm extends StatefulWidget {
  const CardForm({super.key});

  @override
  State<CardForm> createState() => CardFormState();
}

class CardFormState extends State<CardForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(64),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.lightBlueAccent), borderRadius: BorderRadius.circular(15)
      ),
    );
  }
}
