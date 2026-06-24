import 'package:flutter/material.dart';
import 'package:hazard/presentation/widgets/sideBar.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({super.key});

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SideBar(),);
  }
}
