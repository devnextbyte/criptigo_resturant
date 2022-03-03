import 'package:flutter/material.dart';
import '../../util/snippets.dart';

PreferredSize criptigoAppBar({bool withBack = true, String title}) =>
    PreferredSize(
      preferredSize: Size.fromHeight(90),
      child: CriptigoAppBar(withBack: withBack, title: title),
    );

class CriptigoAppBar extends StatelessWidget {
  final bool withBack;
  final String title;

  const CriptigoAppBar({Key key, this.withBack = false, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width / 12 * 8;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 32,
          child: withBack
              ? IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).primaryColor,
                    size: 32,
                  ),
                  onPressed: () => pop(context))
              : SizedBox(),
        ),
        Container(
          width: width,
          height: 56,
          padding: EdgeInsets.fromLTRB(width / 6, 06, width / 6, 06),
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(24))),
          child: title != null
              ? Text(
                  title,
                  style: Theme.of(context).textTheme.headline5.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                )
              : Image.asset(
                  "assets/images/logo.png",
                  height: 56,
                ),
        ),
        SizedBox(width: 32),
      ],
    );
  }
}
