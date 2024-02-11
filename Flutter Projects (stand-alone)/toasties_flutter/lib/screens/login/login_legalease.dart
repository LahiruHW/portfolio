import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:toasties_flutter/common/providers/state_provider.dart';

/// Login page for LegalEase User Accounts, does not validate password for obvious reasons
class LoginLegalEase extends StatefulWidget {
  const LoginLegalEase({
    super.key,
  });

  @override
  State<LoginLegalEase> createState() => _LoginLegalEaseState();
}

class _LoginLegalEaseState extends State<LoginLegalEase> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();

  String emailText = "";
  String passwordText = "";

  bool isPasswordHidden = true;
  bool isEmailValid = false;
  final emailRegex = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  /// validate email address
  String? validateEmail(value) {
    String? retVal = "";
    if (value.isEmpty) {
      retVal = "Please enter an email address";
    } else if (!emailRegex.hasMatch(value)) {
      retVal = "invalid email address";
    } else {
      retVal = null;
    }
    return retVal;
  }

  void _getEmailValidStatus(value) {
    bool retVal = false;
    final result = validateEmail(value);
    retVal = result == null ? true : false;
    isEmailValid = retVal;
  }

  _togglePasswordVisibility() {
    setState(() => isPasswordHidden = !isPasswordHidden);
  }

  @override
  void initState() {
    super.initState();

    _emailController.addListener(() {
      _getEmailValidStatus(_emailController.text);
      emailText = _emailController.text;
      setState(() {});
    });

    _pwdController.addListener(() {
      setState(() => passwordText = _pwdController.text);
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _pwdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<ToastieStateProvider>(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "LegalEase",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontSize: 40),
            ),
            Text(
              "Enter your LegalEase account details below",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 25),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Email",
                    // textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  TextFormField(
                    controller: _emailController,
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: Colors.black),
                    decoration: InputDecoration(
                      // fillColor: Colors.transparent,
                      suffixIcon: isEmailValid
                          ? const Icon(Icons.check, color: Colors.green)
                          : null,
                    ),
                    maxLines: 1,
                    minLines: 1,
                    keyboardType: TextInputType.emailAddress,
                    validator: validateEmail,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "Password",
                    // textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  TextFormField(
                    controller: _pwdController,
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: Colors.black),
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(
                          isPasswordHidden
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: _togglePasswordVisibility,
                        color: Colors.black,
                      ),
                    ),
                    obscureText: isPasswordHidden,
                    obscuringCharacter: "●",
                    maxLines: 1,
                    minLines: 1,
                  ),
                  const SizedBox(height: 30),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor:
                            Theme.of(context).colorScheme.onPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text("Login"),
                      onPressed: () async {
                        final authProvider = Provider.of<ToastieStateProvider>(
                            context,
                            listen: false);

                        await authProvider
                            .signInWithEmailAndPassword(emailText, passwordText)
                            .then(
                          (value) {
                            Future.delayed(
                              const Duration(milliseconds: 1500),
                              () => GoRouter.of(context).go("/home"),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            authProvider.user != null
                ? Text(
                    "User ------- ${authProvider.user!.uid}",
                    style: Theme.of(context).textTheme.bodyMedium,
                  )
                : Text(
                    "User is currently signed out!",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
          ],
        ),
      ),
    );
  }
}
