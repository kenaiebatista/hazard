import 'package:flutter/material.dart';
import 'package:hazard/presentation/widgets/card_form.dart';
import 'package:hazard/presentation/widgets/login_panel.dart';
import 'package:provider/provider.dart';

class StateChange extends ChangeNotifier {
  bool _change = false;

  bool get change => _change;

  set change(bool value) {
    _change = value;
    notifyListeners();
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StateChange(),
      child: Consumer<StateChange>(
        builder: (_, state, _) {
          return Scaffold(
            body: Stack(
              children: [
                const Positioned.fill(child: LeftPanel()),
                Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: CardForm(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
