import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hazard/core/utils/responsive.dart';
import 'package:hazard/l10n/app_localizations.dart';
import 'package:hazard/presentation/providers/auth_provider.dart';
import 'package:hazard/presentation/screens/login/login_screen.dart';
import 'package:hazard/presentation/widgets/app_icon.dart';
import 'package:hazard/presentation/widgets/app_text_field_widget.dart';
import 'package:provider/provider.dart';

class CardForm extends StatefulWidget {
  const CardForm({super.key});

  @override
  State<CardForm> createState() => CardFormState();
}

class CardFormState extends State<CardForm> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  Future<void> _submit(bool isRegistering, AppLocalizations l10n) async {
    if (!_formKey.currentState!.validate()) return;

    final authProvider = context.read<AuthProvider>();
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (isRegistering) {
      try {
        await authProvider.register(
          name: _nameController.text.trim(),
          email: email,
          password: password,
        );
      } catch (_) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.loginErrorEmailAlreadyRegistered)),
          );
        }
        return;
      }
    }

    final success = await authProvider.login(email, password);

    if (success) {
      if (mounted) context.go('/stock');
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.loginErrorInvalidCredentials)),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final state = Provider.of<StateChange>(context);
    final isRegistering = state.change;

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 550),
      child: Container(
        margin: context.isMobile
            ? const EdgeInsets.symmetric(horizontal: 16, vertical: 24)
            : const EdgeInsets.all(64),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Theme.of(context).primaryColor, width: 1.5),
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Align(alignment: Alignment.centerLeft, child: MainIcon()),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: (!isRegistering)
                            ? AnimatedOpacity(
                                opacity: isRegistering ? 0.0 : 1.0,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                                child: Text(
                                  l10n.loginWelcome,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            : AnimatedOpacity(
                                opacity: isRegistering ? 1.0 : 0.0,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                                child: Text(
                                  l10n.loginRegisterTitle,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
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
                    crossFadeState: isRegistering
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    firstChild: Padding(
                      padding: const EdgeInsets.only(top: 6.0, bottom: 0),
                      child: TextFieldWidget(
                        label: l10n.loginFieldName,
                        controller: _nameController,
                        isMandatory: true,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (!isRegistering) return null;
                          if (value == null || value.isEmpty) {
                            return l10n.loginValidatorNameRequired;
                          }
                          return null;
                        },
                      ),
                    ),
                    secondChild: const SizedBox(width: double.infinity),
                  ),
                  TextFieldWidget(
                    label: l10n.loginFieldEmail,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    isMandatory: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return l10n.loginValidatorEmailRequired;
                      }
                      if (!value.contains('@'))
                        return l10n.loginValidatorEmailInvalid;
                      return null;
                    },
                  ),
                  TextFieldWidget(
                    label: l10n.loginFieldPassword,
                    controller: _passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    isMandatory: false,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return l10n.loginValidatorPasswordRequired;
                      }
                      if (value.length < 6)
                        return l10n.loginValidatorPasswordMinLength;
                      return null;
                    },
                  ),
                  AnimatedCrossFade(
                    duration: const Duration(milliseconds: 450),
                    firstCurve: Curves.easeInOut,
                    secondCurve: Curves.easeInOut,
                    sizeCurve: Curves.easeInOut,
                    crossFadeState: isRegistering
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    firstChild: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: TextFieldWidget(
                        label: l10n.loginFieldConfirmPassword,
                        controller: _confirmPasswordController,
                        isMandatory: true,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        validator: (value) {
                          if (!isRegistering) return null;
                          if (value == null || value.isEmpty) {
                            return l10n.loginValidatorConfirmPasswordRequired;
                          }
                          if (value != _passwordController.text) {
                            return l10n.loginValidatorPasswordMismatch;
                          }
                          return null;
                        },
                      ),
                    ),
                    secondChild: const SizedBox(width: double.infinity),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onTap: () => _submit(isRegistering, l10n),
                      child: Ink(
                        height: 40,
                        width: 200,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 750),
                            child: Text(
                              isRegistering
                                  ? l10n.loginButtonRegister
                                  : l10n.loginButtonSignIn,
                              key: ValueKey(isRegistering),
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
                          isRegistering
                              ? l10n.loginLinkHaveAccount
                              : l10n.loginLinkRegister,
                          key: ValueKey(isRegistering),
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
