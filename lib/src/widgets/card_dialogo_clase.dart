import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
/// Dialogo
class Dialogo {
  static Future<void> alert(BuildContext context,
      {String title,
      String body,
      String onText = 'Aceptar',
      VoidCallback onOk}) async {
    showCupertinoDialog(
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
            title: title != null ? Text(title) : null,
            content: body != null ? Text(body) : null,
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text(onText),
                onPressed: () {
                  Navigator.pop(context);
                  if (onOk != null) {
                    onOk();
                  }
                },
              )
            ],
          );
        });
  }
/// confirmar es un metodo que retorna un _future_ de tipo bool requiere de los siguientes parametros
/// * BuildContext context
/// * String title
/// * String body,
/// * String confirmText = 'Aceptar',
/// * String cancelText = 'Cancelar',
  static Future<bool> confirmar(
    BuildContext context, {
    String title,
    String body,
    String confirmText = 'Aceptar',
    String cancelText = 'Cancelar',
  }) async {
    final Completer<bool> c = Completer();
    showCupertinoModalPopup(
        context: context,
        builder: (_) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            alignment: Alignment.bottomCenter,
            color: Colors.transparent,
            child: CupertinoActionSheet(
              title: title != null ? Text(title,style: TextStyle(color: Colors.black,fontSize: 20)) : null,
              message: body != null ? Text(body,style: TextStyle(fontSize: 19),) : null,
              actions: <Widget>[
                CupertinoActionSheetAction(
                  onPressed: (){
                    Navigator.pop(context);
                    c.complete(true);
                  },
                  child: Text(
                    confirmText,
                    style: TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 20,
                        fontWeight: FontWeight.w300),
                  )),
              ],
              cancelButton: CupertinoActionSheetAction(
                  onPressed: (){
                    Navigator.pop(context);
                    c.complete(false);
                  },
                  child: Text(
                    cancelText,
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                        fontWeight: FontWeight.w300),
                  )),
            ),
          );
        });

    return c.future;    
  }
}
