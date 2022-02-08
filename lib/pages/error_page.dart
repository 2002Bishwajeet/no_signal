import 'package:flutter/material.dart';

/// [ErrorPage]
/// A widget that displays an error message.
///
class ErrorPage extends StatelessWidget {
  final Object error;
  final StackTrace? trace;
  const ErrorPage({
    Key? key,
    required this.error,
    this.trace,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(error.toString()),
      ),
    );
  }
}
