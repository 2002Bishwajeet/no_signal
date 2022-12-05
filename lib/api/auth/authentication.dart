import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:flutter/foundation.dart';

///  We have created a class named [Authentication] which contains all
///  the methods that we need to perform the authentication process.
///  ofc You are free to use any name you want
class Authentication {
  ///  [Client] is a class provided by the Appwrite SDK.
  ///  It is used to communicate with the Appwrite API.
  ///  We will be receiving this object from the constructor
  final Client client;

  ///  [Account] is also a class provided by the Appwrite SDK.
  ///  It is to access the all the account related methods. like get account
  ///  or create account , update account etc
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

  //  In older version appwrite SDK 1.0.2 , we used to get response as the output
  //  and we had to manually add them into our custom models.
  //  But fear not we are using the latest appwrite sdk version 2.0.2
  //  This returns proper models so yup, it made your life a little easier.
  //  When I started this project I had manually implemented those models
  //  But this blog uses latest version of appwrite so we are going to skip that part

  ///  This is a function [getAccount] which will return a [User] object containing the data
  ///  of the user if the user is authenticated. Otherwise it will throw an exception
  ///  SO we don't want the program to stop in between so we are returning NULL if
  ///  it throws exception

  ///  To know more about User Model `Ctrl+click` or `command + click`
  ///  on User to go to the User model
  ///  It's a nice practice to see these stuffs and explore them
  Future<models.Account?> getAccount() async {
    try {
      return await account.get();
    } on AppwriteException catch (e) {
      log(e.toString());
      return null;
    }
  }

  // A function to login the user with email and password
  Future<void> login(String email, String password) async {
    ///  here account is the object of Account class and create session
    ///  is a method of Account class which signs in the current user.
    ///  We are using try catch block so that if there is any error we can
    ///  show the user a proper message
    ///  if the try is successful we would be actually checking which type of
    ///  data we are receving from the server
    ///  if you don't want to see you can comment it out.
    ///  nevermind I did that for you😉
    /// var data = await account.createSession(email: email, password: password);
    try {
      //
      await account.createEmailSession(email: email, password: password);
      //
    } on Exception catch (e) {
      //
      debugPrint('Logged Error\n${e.toString()}');
    }
  }

  ///  A function to signup the user with email and password
  Future<void> signUp(String email, String password) async {
    //  In this create method is used to signup the user using
    //  email and password
    //  keep in mind it only registers a user and doesn't signin
    //  So you need to signin after registration
    //  in That case what I did if the function is successful
    //  I try to signIn using .whenComplete()
    //  this is a function provided by the Future class
    //  to perform an operation when its completed
    try {
      //
      await account.create(
        email: email,
        password: password,
        userId: 'unique()',
      );
      // We will creating a userId as the email id(UNIQUE)

      await account.createEmailSession(email: email, password: password);
      //
    } on Exception catch (e) {
      //
      debugPrint('Logged Error\n${e.toString()}');
    }
  }

  ///  A function to logout the current user
  Future<void> logout() async {
    ///  Delete session is the method to logout the user
    ///  it expects sessionID but by passing 'current' it redirects to
    ///  current loggedIn user in this application
    try {
      //
      await account.deleteSession(sessionId: 'current');
      //
    } on Exception catch (e) {
      //
      debugPrint('Logged Error\n${e.toString()}');
    }
  }
}
