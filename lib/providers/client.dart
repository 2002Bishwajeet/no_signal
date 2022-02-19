import 'package:appwrite/appwrite.dart';
import 'package:dart_appwrite/dart_appwrite.dart' as appwrite;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:no_signal/utils/api.dart';

//  So this is the most important step. Otherwise everystep you done - you would
//  Thinking that it's waste

//  So I have created a client provider which returns a client object. Here ref is
//  something that if you want to consume another provider inside provider
//  Don't worrry its optional but I will show you one example where you can use it

//  getting back to CLient. So main things that you need  is the endpoint
//  projectId and selfsignedStatus (defaults to false)

//  About this endpoint remeber this is different for everyone and localhost
//  does not work in emulators and phone devices.
//  So how to get this address?
//  Goto your terminal and type
//  ipconfig
//  and copy the ipv4 address (in my case it was Wireless Lan WiFi, yours could
//  ethernet too)
//then suffix it with the portnumber

//  Okay if you are unsure that thing you copied is right or wrong
//  here's a small tip to debug
//  If I were you I would goto my phone's browser and type the custom Endpoint
//  in the url bar and see if it works.
//  if you get a signIn panel then voila it works. Now DON'T TOUCH IT.

final clientProvider = Provider<Client>((ref) {
  return Client()
      .setEndpoint(ApiInfo.url) // Your Appwrite Endpoint
      .setProject(ApiInfo.projectId) // Your project ID
      .setSelfSigned(
          status:
              true); // For self signed certificates, only use for development
});

/// [dartClientProvider]
/// This provides a [appwrite.Client] object from `dart_appwrite` package.
/// Since the names of both classes are the same, we are using `as` to the
/// server client package
/// Just provide an secret key with all the neccessary permissions and it's ready
final dartclientProvider = Provider<appwrite.Client>((ref) {
  return appwrite.Client()
      .setEndpoint(ApiInfo.url)
      .setProject(ApiInfo.projectId)
      .setKey(ApiInfo.secretKey)
      .setSelfSigned(status: true);
});
