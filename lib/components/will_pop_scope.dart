import 'package:flutter/material.dart';

customWillPopScope(BuildContext context) {
  showDialog(
      context: context,
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
      });
}
