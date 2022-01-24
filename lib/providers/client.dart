import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dart_appwrite/dart_appwrite.dart' as appwrite;

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
// here's a small tip to debug
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
          '985baaa640bdabeb06c3f11f966fcc5ceab4f16740f5d48ff62e694060119f2213f3489d53cd2108c4a3af27c96d12114dfc137bbfabc3cc35a54550b516f1c359620fadfd4c4511842c89713fcabe234d880741185ef00e8583cfd33f75b90f47bccda97ee9391c5fb80d08bdc339c35dead255db522309bba4979b762a1332')
      .setSelfSigned(status: true);
});
