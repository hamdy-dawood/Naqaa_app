import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class CustomWebView extends StatefulWidget {
  const CustomWebView({required this.url, Key? key}) : super(key: key);
  final String url;

  @override
  State<CustomWebView> createState() => _CustomWebViewState();
}

class _CustomWebViewState extends State<CustomWebView> {
  late InAppWebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
        onWebViewCreated: (controller) {
          _webViewController = controller;
        },
        onLoadStop: (controller, url) {
          String host = url?.host ?? "";

          print("host: $host");

          _webViewController
              .evaluateJavascript(source: "window.document.referrer")
              .then((value) => {print("result: $value")})
              .onError((error, stackTrace) => {print("$stackTrace")});
        },
      ),
    );
  }
}
