import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:no_signal/Pages/HomePage.dart';
import 'package:no_signal/Pages/LoginPages/LoginPage.dart';
import 'package:no_signal/Pages/LoginPages/SignUpPage.dart';

//  We have created a class named Authentication which contains all
//  the methods that we need to perform the authentication process.
//  ofc You are free to use any name you want
class Authentication {
  //  Client is a class provided by the Appwrite SDK.
  //  It is used to communicate with the Appwrite API.
  //  We will be receving this object from the constructor
  final Client client;

  //  Account is also a class provided by the Appwrite SDK.
  //  It is to access the all the account related methods. like get account
  //  or create account , update account etc
  late Account account;
  //  late keyowrd due to Null Safety
  //  to know more about Null Safety visit https://dart.dev/null-safety/understanding-null-safety

  //  We have created a constructor which will initialize the account object
  //  Account class requires an object of Client.
  //  I have decided to make a client object in the provider itself so you will
  // see that soon
  Authentication(this.client) {
    account = Account(client);
  }

  //  Time for some functions now
  //  Since all the functions will be asynchronous we will be using Future
  //  cause you know there is a future involved. you don't know what are you expecting

  //  There isn't much difference between the two versions.
  //  Only now instead of dynamic data you get a proper class objects

  //  When I started this project I had manually implemented those models

  Future<User?> getAccount() async => await account.get();

  // A function to login the user with email and password
  Future<void> login(
      String email, String password, BuildContext context) async {
    try {
      //  here account is the object of Account class and create session
      //  is a method of Account class which signs in the current user.
      //  We are using try catch block so that if there is any error we can
      //  show the user a proper message
      //  if the try is successful we would be actually checking which type of
      //  data we are receving from the server
      //  if you don't want to see you can comment it out.
      //  nevermind I did that for you😉
      // var data = await account.createSession(email: email, password: password);
      await account.createSession(email: email, password: password);
      // print(data);
      await Navigator.pushReplacementNamed(context, HomePage.routename);
    } catch (e) {
      print(e);
      await showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: Text('Error Occured'),
                content: Text(e.toString()),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Ok"))
                ],
              ));
    }
  }

  //  A function to signup the user with email and password
  Future<void> signUp(
      String email, String password, BuildContext context) async {
    try {
      //  In this create method is used to signup the user using
      //  email and password
      //  keep in mind it only registers a user and doesn't signin
      //  So you need to signin after registration
      //  in That case what I did if the function is successful
      //  I try to signIn using .whenComplete()
      //  this is a function provided by the Future class
      //  to perform an operation when its completed
      await account
          .create(email: email, password: password)
          .whenComplete(() async {
        await account.createSession(email: email, password: password);
      });

      await Navigator.pushReplacementNamed(
          context, CreateAccountPage.routeName);
    } catch (e) {
      print(e);
      await showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: Text('Error Occured'),
                content: Text(e.toString()),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Ok"))
                ],
              ));
    }
  }

  //  A function to signout the user
  Future<void> logout(BuildContext context) async {
    try {
      //  Delete session is the method to logout the user
      //  it expects sessionID but by passing 'current' it redirects to
      //  current loggedIn user in this application
      await account.deleteSession(sessionId: 'current');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Logged out Successfully"),
      ));
      await Navigator.of(context).pushReplacementNamed(LoginPage.routename);
    } catch (e) {
      print(e);
      await showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: Text('Something went wrong'),
                content: Text(e.toString()),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Ok"))
                ],
              ));
    }
  }
}
