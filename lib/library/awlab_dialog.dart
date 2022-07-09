import 'package:flutter/material.dart';
import 'package:koffiesoft_test/config/colors.dart';
import 'package:koffiesoft_test/library/awlab_text.dart';
import 'package:nb_utils/nb_utils.dart';

class AWLabDialog {
  static Future<bool> awlabMaterialDialog({
    @required BuildContext? context,
    Color? headerBackgroundColor,
    bool? showHeaderIcon,
    IconData? headerIcon,
    String? title,
    String? message,
    String? confirmButtonText,
    Color? confirmButtonColor,
    VoidCallback? onConfirm,
    bool? showCancelButton,
    String? cancelButtonText,
    Color? cancelButtonColor,
    bool? barrierDismissible,
    VoidCallback? onCancel,
    Function? onDismiss,
  }) {
    showCancelButton ??= false;
    bool showTextTitle = title != null;
    bool showTextMessages = message != null;

    ButtonStyle styleButton({
      @required Color? primaryColor,
      @required Color? defaultColor,
    }) {
      return ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        primary: primaryColor ?? defaultColor,
        alignment: Alignment.center,
        fixedSize: const Size(100, 30),
        elevation: 2,
      );
    }

    TextStyle buttonTextStyle = const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );

    return showDialog(
      context: context!,
      barrierDismissible: barrierDismissible ?? false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            // ignore: unnecessary_statements
            if (showCancelButton!) {
              onCancel;
            } else {
              onConfirm;
            }

            return false;
          },
          child: Dialog(
            backgroundColor: Colors.transparent,
            child: SizedBox(
              width: 160,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                color: Colors.white,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Wrap(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(20),
                      width: double.infinity,
                      color: headerBackgroundColor ?? Colors.blue[700],
                      child: Column(
                        children: <Widget>[
                          10.height.visible(showHeaderIcon ?? true),
                          CircleAvatar(
                            backgroundColor: Colors.black.withAlpha(30),
                            radius: 35,
                            child: Icon(
                              headerIcon ?? Icons.help_outline,
                              color: Colors.white,
                              size: 50,
                            ),
                          ).visible(showHeaderIcon ?? true),
                          10.height.visible(showTextTitle),
                          Text(
                            title ?? '',
                            style: AWLabText.title(context)?.copyWith(
                              color: Colors.white,
                            ),
                          ).visible(showTextTitle),
                          10.height,
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      width: double.infinity,
                      child: Column(
                        children: <Widget>[
                          Text(
                            showTextMessages ? message : '',
                            textAlign: TextAlign.center,
                            style: AWLabText.subhead(context)?.copyWith(
                              color: AppColors.grey_60,
                            ),
                          ).visible(showTextMessages),
                          20.height.visible(showTextMessages),
                          Row(
                            mainAxisAlignment: showCancelButton!
                                ? MainAxisAlignment.spaceAround
                                : MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                style: styleButton(
                                  primaryColor: cancelButtonColor,
                                  defaultColor: Colors.red[400],
                                ),
                                onPressed: onCancel,
                                child: Text(
                                  cancelButtonText ?? "Batal",
                                  style: buttonTextStyle,
                                ),
                              ).visible(showCancelButton),
                              ElevatedButton(
                                style: styleButton(
                                  primaryColor: confirmButtonColor,
                                  defaultColor: Theme.of(context).primaryColor,
                                ),
                                onPressed: onConfirm,
                                child: Text(
                                  confirmButtonText ?? "Oke",
                                  style: buttonTextStyle,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    ).then((val) => (onDismiss != null ? onDismiss(val) : null));
  }
}
