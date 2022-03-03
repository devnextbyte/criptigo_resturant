import 'package:flutter/material.dart';

Future<T> push<T>(BuildContext context, Widget child) =>
    Navigator.of(context).push<T>(MaterialPageRoute(builder: (_) => child));

void replace(BuildContext context, Widget child) => Navigator.of(context)
    .pushReplacement(MaterialPageRoute(builder: (_) => child));

void pop(BuildContext context) => Navigator.of(context).pop();
void popToDashboard(BuildContext context) => Navigator.of(context).popUntil((route) => route.isFirst);

void snack(BuildContext context, String message, {bool info = false}) =>
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: info ? Colors.green : Colors.red,
      content: Text(
        message,
        style: Theme.of(context).textTheme.bodyText1.copyWith(
              color: Colors.white,
            ),
      ),
    ));
