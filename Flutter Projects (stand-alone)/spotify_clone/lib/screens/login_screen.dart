// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify_clone/components/button_submit.dart';
import 'package:spotify_clone/providers/global_state_provider.dart';
import 'package:spotify_clone/screens/sign_up/select_artists_screen.dart';
import 'package:spotify_clone/services/spotify_services.dart';
import 'package:spotify_clone/utilities/show_snackbar.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    super.key,
  });

  static const String routeName = "/login_screen";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: const Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color.fromARGB(166, 27, 26, 28),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LoginInput(),
            ],
          ),
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

class LoginInput extends StatefulWidget {
  const LoginInput({
    super.key,
  });

  @override
  State<LoginInput> createState() => _LoginInputState();
}

class _LoginInputState extends State<LoginInput> {
  late final TextEditingController _textEditingController1;
  late final TextEditingController _textEditingController2;

  String currentEmailInput = "";
  String currentPasswordInput = "";
  bool passwordVisible = false;

  bool loading = false;

  @override
  void initState() {
    super.initState();
    _textEditingController1 = TextEditingController();
    _textEditingController1.addListener(() {
      String current = _textEditingController1.text;
      currentEmailInput = current;
    });
    _textEditingController2 = TextEditingController();
    _textEditingController2.addListener(() {
      String current = _textEditingController2.text;
      currentPasswordInput = current;
    });
  }

  @override
  void dispose() {
    _textEditingController1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SpotifyUserStateProvider>(
      builder: (context, userSettingsModel, child) {
        return Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  "Email",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontFamily: "Avenir Next",
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            TextField(
              autofocus: false,
              keyboardType: TextInputType.emailAddress,
              controller: _textEditingController1,
              style: const TextStyle(
                color: Colors.white,
              ),
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 10,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent, width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent, width: 2.0),
                ),
                fillColor: Color.fromRGBO(119, 119, 119, 1.0),
                filled: true,
              ),
              onChanged: (string) {},
            ),
            const SizedBox(height: 40),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  "Password",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
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
              controller: _textEditingController2,
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
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent, width: 2.0),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent, width: 2.0),
                ),
                fillColor: const Color.fromRGBO(119, 119, 119, 1.0),
                filled: true,
              ),
              onChanged: (string) {},
            ),
            const SizedBox(height: 40),
            SubmitButton(
              title: loading == true ? "Logging in..." : "Log in",
              backGroundColor: loading ? Colors.grey : Colors.white,
              titleColor: Colors.black,
              onPressed: loading == true
                  ? null
                  : () async {
                      setState(() => loading = true);

                      bool isValidUser = await SpotifyServices.verifyUser(
                          currentEmailInput, currentPasswordInput);

                      if (isValidUser) {
                        Future.delayed(
                          const Duration(seconds: 3),
                          () async {
                            showSnackBar(context, "Valid user",
                                barColor: Colors.green);
                            setState(() => loading = false);

                            // get the user from the database and setup the data model
                            final thisUser = await SpotifyServices.getUserByDetails(
                                currentEmailInput, currentPasswordInput);

                            userSettingsModel.setCurrentUser(thisUser);
                            userSettingsModel.setCurrentUserSettings(thisUser.settings);

                            Navigator.of(context).pushNamed(SelectArtistScreen.routeName);
                          },
                        );
                      } else {
                        Future.delayed(
                          const Duration(seconds: 2),
                          () {
                            showSnackBar(context, "Invalid Email or Password");
                            setState(() => loading = false);
                          },
                        );
                      }
                    },
            ),
          ],
        );
      },
    );
  }
}
