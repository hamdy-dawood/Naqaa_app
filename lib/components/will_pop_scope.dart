import 'package:flutter/material.dart';
import 'package:naqaa/core/snack_and_navigate.dart';

customWillPopScope() {
  showDialog(
    context: navigatorKey.currentContext!,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: Container(
          color: Colors.black26,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: const Center(
            child: SizedBox(
                height: 70,
                width: 70,
                child: CircularProgressIndicator(
                  strokeWidth: 4,
                  backgroundColor: Colors.black38,
                  color: Colors.white,
                )),
          ),
        ),
      );
    },
  );
}
