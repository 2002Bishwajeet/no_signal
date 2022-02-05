import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:no_signal/providers/client.dart';

import '../api/auth/authentication.dart';

//  So this is where we defined auth providers

//  Let's have a look at authProvider
//  you will notice I am consuming another provider within a provider
//  and its totally ok, there aren't performance issues to this
//  this authProvider provides an Object of class Authentication
final authProvider = Provider<Authentication>((ref) {
  return Authentication(ref.watch(clientProvider));
});

//  This is a future Provider which ofc involves a future
//  we are accessing getAccount here which will either return a User object
//  if it's logged In and null if it's not
final userProvider = FutureProvider<User?>((ref) async {
  return Authentication(ref.watch(clientProvider)).getAccount();
});

//  This is a state provider which is a bit different from the other providers
// I would be using this provider to keep the data of the user which is logged in
//  and I can access this data anywhere within the context. Like to show some details
//  of the user like name and email or to access its unique Id for other purposes
//  Keep in mind this User Class is provided by the appwrite sdk
final userLoggedProvider = StateProvider<User?>((ref) {
  return null;
});

//  This is also another state provider. Pardon me for giving bad names. Couldn't think
//  of new unique ones at that time.
//  So this  is a provider which decides which widget to show, either welcome screen
//  or Home Screen
//  so think of this like a switch. If the user is logged in show one screen
//  otherwise show other screen
final userLoggedInProvider = StateProvider<bool?>((ref) {
  return null;
});
