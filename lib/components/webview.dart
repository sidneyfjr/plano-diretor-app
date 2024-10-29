import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage(
      {required this.controller,
      required this.currentUrl,
      required this.loadError,
      required this.changeStyle,
      required this.getUser,
      required this.initialUrl,
      Key? key})
      : super(key: key);

  final Completer<WebViewController> controller;
  final Function currentUrl;
  final Function loadError;
  final Function changeStyle;
  final Function getUser;
  final String initialUrl;

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  var loadingPercentage = 0;
  late WebViewController wvController;

  @override
  Widget build(BuildContext context) {
    // print(url);
    return Stack(
      children: [
        WebView(
          initialUrl: widget.initialUrl,
          onWebViewCreated: (webViewController) {
            widget.controller.complete(webViewController);
            wvController = webViewController;
          },
          javascriptMode: JavascriptMode.unrestricted,
          onWebResourceError: (webResourceError) {
             widget.loadError(webResourceError.errorCode);
          },
          onPageStarted: (url) {
            widget.currentUrl(url);
            setState(() {
              loadingPercentage = 0;
            });
          },
          onProgress: (progress) {
            widget.changeStyle(wvController);
            setState(() {
              loadingPercentage = progress;
            });
          },
          onPageFinished: (url) {
            widget.getUser(wvController);
            setState(() {
              loadingPercentage = 100;
            });
          },
        ),
        if (loadingPercentage < 100)
          Center(
            child: CircularProgressIndicator(
              value: loadingPercentage / 100.0,
            ),
          ),
      ],
    );
  }
}
