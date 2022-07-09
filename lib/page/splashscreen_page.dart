import 'package:flutter/material.dart';
import 'package:koffiesoft_test/config/contant.dart';
import 'package:koffiesoft_test/library/awlab_text.dart';
import 'package:koffiesoft_test/library/awlab_tools.dart';
import 'package:nb_utils/nb_utils.dart';

class SplashScreenPage extends StatelessWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: context.width(),
        height: context.height(),
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              width: 100,
              height: 100,
              child: Image.asset(
                AWLabTools.getAssets(Constant.APP_LOGO),
                fit: BoxFit.cover,
              ),
            ),
            10.height,
            Text(
              Constant.APP_NAME,
              style: AWLabText.headline(context)!.copyWith(
                color: Theme.of(context).textTheme.headline1!.color,
                fontWeight: FontWeight.w600,
              ),
            ),
            20.height,
            SizedBox(
              height: 5,
              width: 80,
              child: LinearProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor),
                backgroundColor: Colors.grey[300],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
