import 'package:criptigo/repo/app_repo.dart';
import 'package:criptigo/util/snippets.dart';
import 'package:flutter/material.dart';

class EnterPinView extends StatelessWidget {
  final pinController = TextEditingController();

  final void Function() onApproved;

  EnterPinView({Key key, @required this.onApproved}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Text("Security Check",
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            .copyWith(color: Theme.of(context).primaryColor)),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: pinController,
                    obscureText: true,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: "Enter your pin"),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      if (pinController.text !=
                          await AppRepo.instance.getPin()) {
                        snack(context, "Invalid PIN");
                        return;
                      } else {
                        onApproved();
                      }
                    },
                    child: Text("SUBMIT"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
