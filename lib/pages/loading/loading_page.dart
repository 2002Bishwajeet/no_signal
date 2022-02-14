import 'package:flutter/material.dart';

/// [LoadingPage]
/// A normal Page with [CircularProgressIndicator] in the center.
///
///
class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
