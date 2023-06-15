import 'package:flutter/material.dart';
import 'package:spotify_clone/components/button_submit.dart';
import 'package:spotify_clone/screens/sign_up/enter_name_screen.dart';
import 'package:spotify_clone/utilities/create_route.dart';

class EnterGenderScreen extends StatelessWidget {
  const EnterGenderScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
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
  final Color validInputColor = const Color.fromARGB(255, 30, 215, 96);
  final Color invalidInputColor = Colors.red;
  String dropDownVal = "M";

  final dropDownTextStyle = const TextStyle(
    // color: Colors.white,
    fontSize: 16,
    fontFamily: "Avenir Next",
    fontWeight: FontWeight.w700,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(
              top: 10,
              bottom: 15,
            ),
            child: Text(
              "What's your gender?",
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
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: const Color.fromRGBO(119, 119, 119, 1.0),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              value: dropDownVal,
              // style: dropDownTextStyle,
              isExpanded: true,
              items: const [
                DropdownMenuItem(value: "M", child: Text("Male", style: TextStyle(fontFamily: "Avenir Next"))),
                DropdownMenuItem(value: "F", child: Text("Female", style: TextStyle(fontFamily: "Avenir Next"))),
                DropdownMenuItem(value: "X", child: Text("Other", style: TextStyle(fontFamily: "Avenir Next"))),
                // DropdownMenuItem(value: "M", child: Text("Male")),
                // DropdownMenuItem(value: "F", child: Text("Female")),
                // DropdownMenuItem(value: "X", child: Text("Other")),
              ],
              onChanged: (object) {
                setState(() => dropDownVal = object.toString());
                // also take the value and store it in the Shared pref/provider
              },
            ),
          ),
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

                Navigator.of(context).push(
                  createRouteTo(
                    const EnterNameScreen(),
                  ),
                );

              },
            ))
      ],
    );
  }
}
