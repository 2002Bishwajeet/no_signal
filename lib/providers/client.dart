import 'package:appwrite/appwrite.dart';
import 'package:dart_appwrite/dart_appwrite.dart' as appwrite;
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      .setEndpoint('http://192.168.1.26:5000/v1') // Your Appwrite Endpoint
      .setProject('nosignal') // Your project ID
      .setSelfSigned(
          status:
              true); // For self signed certificates, only use for development
});

final dartclientProvider = Provider<appwrite.Client>((ref) {
  return appwrite.Client()
      .setEndpoint('http://192.168.1.26:5000/v1')
      .setProject('nosignal')
      .setKey(
          'ee9f0be7efc2c08572ac32ed4c8a7aa88fd0d3005c04f3f49e163484c430a07ce4ee53949779167eff564b19f4cf55ffd623f3e0083708eaa7b7ea1e81e9771fc5ac33f8e8315a094013560caf8195961466843456f0672aca3a12104b9cf71f109da2a4b4269ea17163970970ee6ba34e00aa953d44783a66d1df56ca50ae21')
      .setSelfSigned(status: true);
});
