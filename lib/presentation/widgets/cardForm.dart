import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:hazard/presentation/providers/auth_provider.dart';
import 'package:hazard/presentation/screens/login/login_screen.dart';
import 'package:hazard/presentation/widgets/appIcon.dart';
import 'package:hazard/presentation/widgets/textFieldUtil.dart';
import 'package:provider/provider.dart';


class CardForm extends StatefulWidget {
  const CardForm({super.key});

  @override
  State<CardForm> createState() => CardFormState();
}

class CardFormState extends State<CardForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _nomeController = TextEditingController();
  final _confirmarSenhaController = TextEditingController();

  void _submit(bool isCadastro) {
    if (!_formKey.currentState!.validate()) return;

    if (isCadastro) return;

    final success = context.read<AuthProvider>().login(
      _emailController.text,
      _senhaController.text,
    );

    if (success) {
      context.go('/stock');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email ou senha incorretos.')),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _senhaController.dispose();
    _nomeController.dispose();
    _confirmarSenhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<StateChange>(context);
    final isCadastro = state.change;

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 550),
      child: Container(
        margin: const EdgeInsets.all(64),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(-15658620), width: 1.5),
          borderRadius: BorderRadius.circular(15),
        ),
        child: AnimatedSize(
          duration: const Duration(milliseconds: 450),
          curve: Curves.easeInOut,
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                spacing: 16,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Stack(
                    children: [
                      Align(alignment: Alignment.centerLeft, child: MainIcon()),
                      Positioned.fill(
                        child: Center(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              AnimatedOpacity(
                                opacity: isCadastro ? 0.0 : 1.0,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                                child: const Text(
                                  'Bem Vindo!',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              AnimatedOpacity(
                                opacity: isCadastro ? 1.0 : 0.0,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                                child: const Text(
                                  'Cadastre-se',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  AnimatedCrossFade(
                    duration: const Duration(milliseconds: 450),
                    firstCurve: Curves.easeInOut,
                    secondCurve: Curves.easeInOut,
                    sizeCurve: Curves.easeInOut,
                    crossFadeState: isCadastro ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                    firstChild: TextFieldUtil(
                      label: 'Nome',
                      controller: _nomeController,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Informe o nome';
                        return null;
                      },
                    ),
                    secondChild: const SizedBox(width: double.infinity),
                  ),
                  TextFieldUtil(
                    label: 'Email',
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return 'Informe o email';
                      if (!value.contains('@')) return 'Email inválido';
                      return null;
                    },
                  ),
                  TextFieldUtil(
                    label: 'Senha',
                    controller: _senhaController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return 'Informe a senha';
                      if (value.length < 6) return 'Mínimo 6 caracteres';
                      return null;
                    },
                  ),
                  AnimatedCrossFade(
                    duration: const Duration(milliseconds: 450),
                    firstCurve: Curves.easeInOut,
                    secondCurve: Curves.easeInOut,
                    sizeCurve: Curves.easeInOut,
                    crossFadeState: isCadastro ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                    firstChild: TextFieldUtil(
                      label: 'Confirmar Senha',
                      controller: _confirmarSenhaController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Confirme a senha';
                        if (value != _senhaController.text) return 'Senhas não coincidem';
                        return null;
                      },
                    ),
                    secondChild: const SizedBox(width: double.infinity),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onTap: () => _submit(isCadastro),
                      child: Ink(
                        height: 40,
                        width: 200,
                        decoration: BoxDecoration(
                          color: const Color(-15658620),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 750),
                            child: Text(
                              isCadastro ? 'Cadastrar' : 'Entrar',
                              key: ValueKey(isCadastro),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => state.change = !state.change,
                    child: Ink(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 750),
                        child: Text(
                          isCadastro ? 'Já tenho uma conta' : 'Cadastre-se',
                          key: ValueKey(isCadastro),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
