import 'package:flutter/material.dart';
import 'package:hazard/presentation/widgets/cardForm.dart';
import 'package:hazard/presentation/widgets/leftPanel.dart';
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
            body: Center(
              child: Row(
                children: [
                  Expanded(child: LeftPanel()),
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return SingleChildScrollView(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(minHeight: constraints.maxHeight),
                            child: Center(child: CardForm()),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
