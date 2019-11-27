import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_inappbrowser/flutter_inappbrowser.dart';

Future main() async {
  runApp(new CygniBrowser());
}

class CygniBrowser extends StatefulWidget {
  @override
  _CygniBrowserState createState() => new _CygniBrowserState();
}

class _CygniBrowserState extends State<CygniBrowser> {
  InAppWebViewController webView;
  String url = "";
  double progress = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.teal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
                        flex: 4,
                        child: Center(
                          child: TextField(onChanged: (texto){
                            url = texto;
                          },
                            decoration: InputDecoration(
                                labelStyle:
                                    TextStyle(color: Colors.red, fontSize: 36),
                                labelText: 'Ingrese URL',
                                border: InputBorder.none,
                                hintText: 'URL...'),
                          ),
                        ),
                      ),
                      Expanded(flex:1,child: RaisedButton(child: Text('Ir'),onPressed: (){
                        webView.loadUrl(url: url);
                      },),)
                      /*GestureDetector(
                        onTap: () {
                          webView.loadUrl(
                              url: 'https://lavialactea.website/', headers: {});
                        },
                        child: Center(
                            child: Text(
                          'Cygni Browser',
                          style: TextStyle(fontSize: 36, color: Colors.white),
                        )),
                      ),*/
                    ],
                  ),
                ),
              ),
              /*Expanded(
              flex: 2,
              child: Center(
                child: Text(
                    "CURRENT URL\n${(url.length > 50) ? url.substring(0, 50) + "..." : url}"),
              ),
            ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: progress < 1.0
                    ? LinearProgressIndicator(value: progress)
                    : Container()),*/
              Expanded(
                flex: 8,
                child: Container(
                  child: InAppWebView(
                    initialUrl: "https://flutter.dev/",
                    initialHeaders: {},
                    initialOptions: InAppWebViewWidgetOptions(
                        inAppWebViewOptions: InAppWebViewOptions(
                      debuggingEnabled: true,
                    )),
                    onWebViewCreated: (InAppWebViewController controller) {
                      webView = controller;
                    },
                    onLoadStart:
                        (InAppWebViewController controller, String url) {
                      setState(() {
                        this.url = url;
                      });
                    },
                    onLoadStop:
                        (InAppWebViewController controller, String url) async {
                      setState(() {
                        this.url = url;
                      });
                    },
                    onProgressChanged:
                        (InAppWebViewController controller, int progress) {
                      setState(() {
                        this.progress = progress / 100;
                      });
                    },
                  ),
                ),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    child: Icon(Icons.arrow_back),
                    onPressed: () {
                      if (webView != null) {
                        webView.goBack();
                      }
                    },
                  ),
                  RaisedButton(
                    child: Icon(Icons.arrow_forward),
                    onPressed: () {
                      if (webView != null) {
                        webView.goForward();
                      }
                    },
                  ),
                  RaisedButton(
                    child: Icon(Icons.refresh),
                    onPressed: () {
                      if (webView != null) {
                        webView.reload();
                      }
                    },
                  ),
                ],
              ),
            ])),
      ),
    );
  }
}
