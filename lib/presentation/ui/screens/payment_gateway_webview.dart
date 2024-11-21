import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentGatewayWebView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
      return _PaymentGatewayWebViewState();

  }

  final String gatewayUrl;

  const PaymentGatewayWebView({super.key, required this.gatewayUrl});

}

class  _PaymentGatewayWebViewState extends State<PaymentGatewayWebView>{

  late final WebViewController _webViewController;

  void initState(){
    super.initState();
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.gatewayUrl));

  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Text('Payment'),
       ),
       body: WebViewWidget(
           controller: _webViewController
       ),

     );
  }

  void dispose(){
    super.dispose();

  }

}