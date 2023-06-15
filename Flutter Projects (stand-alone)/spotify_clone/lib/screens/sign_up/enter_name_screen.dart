import 'package:flutter/material.dart';
import 'package:spotify_clone/components/button_submit.dart';
import 'package:spotify_clone/entities/User.dart';
import 'package:spotify_clone/utilities/show_snackbar.dart';

class EnterNameScreen extends StatelessWidget {
  const EnterNameScreen({
    super.key,
  });

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
          child: SpotifyTextInput(),
        ),
      ),
    );
  }
}

///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////

class SpotifyTextInput extends StatefulWidget {
  const SpotifyTextInput({
    super.key,
  });

  @override
  State<SpotifyTextInput> createState() => _SpotifyTextInputState();
}

class _SpotifyTextInputState extends State<SpotifyTextInput> {
  late final TextEditingController _textEditingController;

  final Color validInputColor = const Color.fromARGB(255, 30, 215, 96);
  final Color invalidInputColor = Colors.red;
  late String errorMsg = "";
  bool validInput = false;

  bool permission1 = false;
  bool permission2 = false;

  List isNameValid(String name) {
    bool answer = true;
    String msg = "";
    if (name.isEmpty) {
      msg = "Your name can't be empty";
      return [false, msg];
    }

    // check if it has any special characters
    if (name.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      msg = "Your name can't contain special characters";
      answer = answer && false;
    }
    // check if number of names is >= 1
    if (name.split(" ").length < 2) {
      // if 1 name ---> (Fname), if 2 names ---> (Fname,Lname), else ---> (Fname+Mname, Lname)
      msg = "Your name needs to be at least 2 words long";
      answer = answer && false;
    }
    return [answer, msg];
  }

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _textEditingController.addListener(() {
      String current = _textEditingController.text;
      print("------------------------------- $current");
      List arr = isNameValid(current);
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
              "What's your name?",
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
            hintText: "First Last",
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
            helperMaxLines: 2,
            helperText: "This appears on your Spotify profile",
            helperStyle: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontFamily: "Avenir Next",
              fontWeight: FontWeight.w700,
            ),
          ),
          onChanged: (string) {},
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Divider(color: Colors.white),
        ),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
              'By tapping on "Create Account", you agree to the Spotify Terms of Use.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontFamily: "Avenir Next",
                fontWeight: FontWeight.w700,
              )),
        ),
        const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text(
              'Terms of Use',
              style: TextStyle(
                color: Color.fromARGB(255, 30, 215, 96),
                fontSize: 10,
                fontFamily: "Avenir Next",
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'To learn more about how Spotify collects, uses, shares and protects your personal data, please see the Spootify Privacy Policy.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontFamily: "Avenir Next",
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              'Privacy Policy',
              style: TextStyle(
                color: Color.fromARGB(255, 30, 215, 96),
                fontSize: 10,
                fontFamily: "Avenir Next",
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Expanded(
                flex: 6,
                child: Text(
                  'Please send me news and offers from Spotify',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontFamily: "Avenir Next",
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Checkbox(
                  shape: const CircleBorder(),
                  side: const BorderSide(color: Colors.white),
                  activeColor: const Color.fromARGB(255, 30, 215, 96),
                  checkColor: Colors.white,
                  value: permission1,
                  onChanged: (bool? value) {
                    setState(() => permission1 = value!);
                  },
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Expanded(
                flex: 6,
                child: Text(
                  'Share my registration data with Spotify\'s content providers for marketing purposes.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontFamily: "Avenir Next",
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Checkbox(
                  shape: const CircleBorder(),
                  side: const BorderSide(color: Colors.white),
                  activeColor: const Color.fromARGB(255, 30, 215, 96),
                  checkColor: Colors.white,
                  value: permission2,
                  onChanged: (bool? value) {
                    setState(() => permission2 = value!);
                  },
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 50,
            bottom: 20,
            left: 20,
            right: 20,
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: SubmitButton(
              title: "Create an account",
              backGroundColor: Colors.white,
              titleColor: Colors.black,
              onPressed: () {
                // ignore: unused_local_variable
                final val = _textEditingController.text;

                if (validInput == false) {
                  setState(() => validInput = false);
                  showSnackBar(context, errorMsg);
                } else {
                  // OR JUST SAVE IT TO PROVIDER/SHARED PREFERENCES
                  // Navigator.of(context).push(
                  //   createRouteTo(
                  //     const EnterGenderScreen(),
                  //   ),
                  // );
                }
              },
            ),
          ),
        )
      ],
    );
  }
}
