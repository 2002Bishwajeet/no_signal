import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:no_signal/Pages/login/login_page.dart';

// I like to define elements and color in a seperate file so that's the custom themes file
import 'package:no_signal/themes.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //  Introduction Screen is actually a package that I have used from Pub.dev
    // Link for the Inroduction Screen: https://pub.dev/packages/introduction_screen

    return IntroductionScreen(
      isTopSafeArea: true, // Safe Area to avoid overlaps with the status bar
      showDoneButton: true,
      done: Text('Done', style: TextStyle(color: NoSignalTheme.whiteShade1)),

      // OnDone takes an anonymous function. So when all the slides are completed
      //we are navigating the user to Login Page
      onDone: () =>
          Navigator.of(context).pushReplacementNamed(LoginPage.routename),
      next: Text('Next', style: TextStyle(color: NoSignalTheme.whiteShade1)),

      // A skip button to skip those pages(some prefer some doesn't)
      showSkipButton: true,
      skip: Text('Skip', style: TextStyle(color: NoSignalTheme.whiteShade1)),
      showNextButton: true,

      // Same here, if the user skips - redirects to loginPage
      onSkip: () =>
          Navigator.of(context).pushReplacementNamed(LoginPage.routename),

      // Now pages expect a list of PageViewModel
      // That's what we have added here
      pages: [
        PageViewModel(
          image: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.contain,
            height: 200,
          ),
          body: "Freedom talk to any person with assured privacy",
          title: "Welcome To No Signal",
        ),
        PageViewModel(
          image: Lottie.asset("assets/lottieassets/chat.json"),
          body: "Send text, images, videos and even documents to your friends",
          title: "Chat with your friends",
        ),
        PageViewModel(
          image: Lottie.asset("assets/lottieassets/server.json"),
          body:
              "Appwrite is an Open-Source self-hosted solution that provides developers with a set of easy-to-use and integrate REST APIs to manage their core backend needs.",
          title: "AppWrite used as a Backend Service",
        ),
      ],
    );
  }
}
