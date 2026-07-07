import 'package:flutter/material.dart';

class MainIcon extends StatelessWidget {
  const MainIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container( decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Color(-15658620),),
      height: 36,
      width: 38,
      child: Center(
        child: Text(
          'P',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
    );
  }
}
