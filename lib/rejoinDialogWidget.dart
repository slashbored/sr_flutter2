import 'textStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'generated/l10n.dart';

Widget rejoinDialog(BuildContext context, String jsonstring)  {
  return SimpleDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      title: Text(
          S.of(context).rejoin,
          textAlign: TextAlign.center,
          style: normalStyle
      ),
      children: <Widget>[
        Row(
          children: <Widget>[
            SimpleDialogOption(
              child: Text(
                "👍🏻",
                textAlign: TextAlign.center,
                style: normalStyle,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            SimpleDialogOption(
              child: Text(
                "👎🏻 ",
                textAlign: TextAlign.center,
                style: normalStyle,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        )
      ]
  );
}