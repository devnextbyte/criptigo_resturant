import 'package:flutter/material.dart';

class DashButton extends StatelessWidget {
  final String icon;
  final String label;
  final void Function() onTap;

  DashButton(this.icon, this.label, this.onTap);

  @override
  Widget build(BuildContext context) {
    return getDashButton(context, icon, label, onTap);
  }

  Widget getDashButton(
      BuildContext context, String icon, String label, void Function() onTap) {
    final refWidth = MediaQuery.of(context).size.width / 5;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Stack(
            children: [
              Row(children: [
                Image.asset(
                  "assets/images/elipse.png",
                  width: refWidth,
                ),
                SizedBox(width: refWidth)
              ]),
              Positioned(
                right: 16,
                top: 16,
                child: Image.asset(icon, width: refWidth),
              ),
              Positioned(
                right: 16,
                bottom: 16,
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
