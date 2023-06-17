import 'package:flutter/material.dart';
import 'package:spotify_clone/components/button_submit.dart';
import 'package:spotify_clone/screens/sign_up/enter_password_screen.dart';
import 'package:spotify_clone/utilities/show_snackbar.dart';

class EnterEmailScreen extends StatelessWidget {
  const EnterEmailScreen({
    super.key,
  });

  static const String routeName = "/sign_up_email_screen";

  @override
  Widget build(BuildContext context) {
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
          child: SpotifyEmailInput(),
        ),
      ),
    );
  }
}

///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////

class SpotifyEmailInput extends StatefulWidget {
  const SpotifyEmailInput({
    super.key,
  });

  @override
  State<SpotifyEmailInput> createState() => _SpotifyEmailInputState();
}

class _SpotifyEmailInputState extends State<SpotifyEmailInput> {
  late final TextEditingController _textEditingController;

  final Color validInputColor = const Color.fromARGB(255, 30, 215, 96);
  final Color invalidInputColor = Colors.red;
  String currentInput = "";
  bool validInput = false;
  String errorMsg = "Please Enter a valid email address";

  List isEmailValid(String email) {
    bool answer = true;
    String msg = "Please enter a valid email address";
    if (email.isEmpty) {
      answer = answer && false;
      msg = "Please enter an email address";
      return [answer, msg];
    }

    bool regexCheck = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.com$")
        .hasMatch(email);
    // bool regexCheck2 = RegExp(
    //         r"/^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.com/")
    //     .hasMatch(email);

    if (regexCheck == false) {
      answer = answer && false;
      msg = "Please enter a valid email address";
    }

    return [answer, msg];
  }

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _textEditingController.addListener(
      () {
        String current = _textEditingController.text;

        List arr = isEmailValid(current);
        bool valid = arr[0];
        String msg = arr[1];

        if (valid) {
          setState(() => validInput = true);
        } else {
          setState(() {
            errorMsg = msg;
            validInput = false;
          });
        }
        currentInput = current;
      },
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(
              top: 10,
              bottom: 4,
            ),
            child: Text(
              "What's your email?",
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
          autofocus: false,
          keyboardType: TextInputType.emailAddress,
          controller: _textEditingController,
          style: const TextStyle(
            color: Colors.white,
          ),
          decoration: InputDecoration(
            suffixIcon: (validInput == true)
                ? Icon(Icons.check, color: validInputColor)
                : null,
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
                color:
                    (validInput == true) ? validInputColor : invalidInputColor,
                width: 2.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color:
                    (validInput == true) ? validInputColor : invalidInputColor,
                width: 2.0,
              ),
            ),
            fillColor: const Color.fromRGBO(119, 119, 119, 1.0),
            filled: true,
            helperText: "You'll need to confirm this email later",
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
              onPressed: () {
                if (validInput == false) {
                  showSnackBar(context, errorMsg);
                } else {
                  // OR JUST SAVE IT TO PROVIDER/SHARED PREFERENCES

                  dynamic data = {"email": currentInput};
                  // dynamic data = {"email": val};

                  print(
                      "------------------------------- Next page is ${EnterPasswordScreen.routeName}");
                  Navigator.of(context).pushNamed(EnterPasswordScreen.routeName,
                      arguments: data);
                }
              },
            ))
      ],
    );
  }
}
