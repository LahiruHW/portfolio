import 'package:flutter/material.dart';
import 'package:spotify_clone/components/button_submit.dart';
import 'package:spotify_clone/screens/sign_up/enter_name_screen.dart';



class SelectArtistScreen extends StatelessWidget {
  const SelectArtistScreen({
    super.key,
  });

  static const String routeName = "/sign_up_select-artist_screen";

  @override
  Widget build(BuildContext context) {
    print(
        "------------------------------- received data from ${EnterNameScreen.routeName} ----- ${ModalRoute.of(context)?.settings}");
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
            "Choose 3 or more artists you like",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: "Avenir Next",
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Container(


          
          child: SubmitButton(
            onPressed: () {

              print("------------------------------- Continue");

              // get the current user 
              

            }, title: 'Continue',
          ),
            



          ),
        ),
      ),
    );
  }
}