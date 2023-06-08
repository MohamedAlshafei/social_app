

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


String? uId ='';

Future<bool?> showToast({
    required String text,
    required ToastState state
  })=> Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0,
    );


  enum ToastState{success, error, warning}


  Color? chooseToastColor(ToastState state){
  // ignore: unused_local_variable
    // Color color;
    switch(state){
      case ToastState.success:
        return Colors.green;
        // break;
      case ToastState.error:
        return Colors.red;
        // break;
      case ToastState.warning:
        return Colors.amber;
    }
    // return null;
  }
