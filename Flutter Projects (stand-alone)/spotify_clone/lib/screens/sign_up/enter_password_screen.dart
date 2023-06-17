// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:spotify_clone/components/button_submit.dart';
import 'package:spotify_clone/entities/User.dart';
import 'package:spotify_clone/screens/sign_up/enter_gender_screen.dart';
import 'package:spotify_clone/services/spotify_services.dart';
import 'package:spotify_clone/utilities/show_snackbar.dart';

class EnterPasswordScreen extends StatelessWidget {
  const EnterPasswordScreen({
    super.key,
  });

  static const String routeName = "/sign_up_password_screen";

  @override
  Widget build(BuildContext context) {
    print(
        "------------------------------- received data from ${EnterPasswordScreen.routeName} ----- ${ModalRoute.of(context)?.settings}");
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color.fromARGB(166, 27, 26, 28),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          leadingWidth: 70,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            color: Colors.white,
            onPressed: () {
              print("------------------------------- Back");
              Navigator.of(context).pop();
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          title: const Text(
            "Create account",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: "Avenir Next",
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: SpotifyPasswordInput(),
        ),
      ),
    );
  }
}

///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////

class SpotifyPasswordInput extends StatefulWidget {
  const SpotifyPasswordInput({
    super.key,
  });

  @override
  State<SpotifyPasswordInput> createState() => _SpotifyPasswordInputState();
}

class _SpotifyPasswordInputState extends State<SpotifyPasswordInput> {
  late final TextEditingController _textEditingController;

  final Color validInputColor = const Color.fromARGB(255, 30, 215, 96);
  final Color invalidInputColor = Colors.red;
  String currentInput = "";
  bool validInput = false;
  bool passwordVisible = false;
  String errorMsg = "Please enter a password";

  List isPasswordValid(String password) {
    bool answer = true;
    String msg = "";

    // check if it has at least 8 characters
    if (password.length < 8) {
      answer = answer && false;
      msg = "Password must be at least 8 characters long";
    }

    // check if it has any digits in it
    if (!password.contains(RegExp(r'[0-9]'))) {
      answer = answer && false;
      msg = "Password must contain at least 1 digit";
    }

    // check if it has any special characters
    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      answer = answer && false;
      msg = "Password must contain at least 1 special character";
    }

    // check if it has any uppercase letters
    if (!password.contains(RegExp(r'[A-Z]'))) {
      answer = answer && false;
      msg = "Password must contain at least 1 uppercase character";
    }

    // check if it has any lowercase letters
    if (!password.contains(RegExp(r'[a-z]'))) {
      answer = answer && false;
      msg = "Password must contain at least 1 lowercase character";
    }

    return [answer, msg];
  }

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _textEditingController.addListener(() {
      String current = _textEditingController.text;

      List arr = isPasswordValid(current);

      bool valid = arr[0];
      String msg = arr[1];

      if (valid) {
        setState(() => validInput = true);
      } else {
        setState(() {
          validInput = false;
          errorMsg = msg;
        });
      }
      currentInput = current;
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  late SpotifyUser x;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(
              top: 10,
              bottom: 4,
            ),
            child: Text(
              "Create a password",
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: "Avenir Next",
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        TextField(
          obscureText: !passwordVisible,
          obscuringCharacter: "●",
          autofocus: false,
          keyboardType: TextInputType.emailAddress,
          controller: _textEditingController,
          style: const TextStyle(
            color: Colors.white,
          ),
          decoration: InputDecoration(
            suffixIcon: IconButton(
              splashColor: Colors.transparent,
              icon: Icon(
                (passwordVisible) ? Icons.visibility : Icons.visibility_off,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() => passwordVisible = !passwordVisible);
              },
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 10,
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
                width: 2.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: (validInput) ? validInputColor : invalidInputColor,
                width: 2.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: (validInput) ? validInputColor : invalidInputColor,
                width: 2.0,
              ),
            ),
            fillColor: const Color.fromRGBO(119, 119, 119, 1.0),
            filled: true,
            helperMaxLines: 2,
            helperText:
                "Use at least 8 characters with at least 1 uppercase character, 1 lowercase character and 1 special character",
            helperStyle: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontFamily: "Avenir Next",
              fontWeight: FontWeight.w700,
            ),
          ),
          onChanged: (string) {},
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 50,
            bottom: 20,
            left: 20,
            right: 20,
          ),
          child: SubmitButton(
            title: "Next",
            onPressed: () async {
              // ignore: unused_local_variable
              final val = _textEditingController.text;

              if (val.isEmpty) {
                setState(() => validInput = false);
                showSnackBar(context, "Please enter a valid password");
              } else {
                final password = _textEditingController.text;

                if (validInput == false) {
                  showSnackBar(context, errorMsg);
                } else {
                  final encPass =
                      await SpotifyServices.encryptPassword(password);
                  // await SpotifyServices.decryptPassword(encryptedPassword);

                  dynamic data = ModalRoute.of(context)?.settings.arguments;
                  data = {
                    ...data,
                    "password": encPass,
                  };
                  Navigator.of(context)
                      .pushNamed(EnterGenderScreen.routeName, arguments: data); 
                }
              }
            },
          ),
        )
      ],
    );
  }
}
