import 'package:chrome/screen/provider/homeprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  PullToRefreshController? pullToRefreshController;
  homeprovider? trueprovider;
  homeprovider? falseprovider;

  @override
  void initState() {
    super.initState();
    pullToRefreshController = PullToRefreshController(onRefresh: () {
      trueprovider!.inAppWebViewController!.reload();
    },);
  }

  @override
  Widget build(BuildContext context) {
    trueprovider = Provider.of(context, listen: true);
    falseprovider = Provider.of(context, listen: false);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 2,
                    blurStyle: BlurStyle.outer,
                  )
                ],
              ),
              child: Row(
                children: [
                  IconButton(onPressed: () {
                    trueprovider!.inAppWebViewController!.loadUrl(urlRequest: URLRequest(url: Uri.parse("https://www.google.com/")));
                  }, icon: Icon(Icons.home),),
                  Expanded(
                    child: TextField(
                      controller: falseprovider!.txtsearch,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {
                            var New1 = falseprovider!.txtsearch.text;
                            trueprovider!.inAppWebViewController!.loadUrl(
                                urlRequest: URLRequest(
                                    url: Uri.parse("https://www.google.com/search?q=$New1")));
                          },
                        ),
                      ),
                    ),
                  ),
                  IconButton(onPressed: () {
                    trueprovider!.inAppWebViewController!.goBack();
                  }, icon: Icon(Icons.arrow_back),),
                  IconButton(onPressed: () {
                    trueprovider!.inAppWebViewController!.reload();

                  }, icon: Icon(Icons.refresh),),
                  IconButton(onPressed: () {
                    trueprovider!.inAppWebViewController!.goForward();

                  }, icon: Icon(Icons.arrow_forward_outlined),),
                ],
              ),
            ),
            LinearProgressIndicator(
              minHeight: 2,
              value: trueprovider!.progress,
            ),
            Expanded(
              child: InAppWebView(
                pullToRefreshController: pullToRefreshController,
                onLoadStart: (controller, url) {
                  pullToRefreshController!.endRefreshing();
                  falseprovider!.inAppWebViewController = controller;
                },
                onLoadStop: (controller, url) {
                  pullToRefreshController!.endRefreshing();

                  falseprovider!.inAppWebViewController = controller;
                },
                onProgressChanged: (controller, progress) {
                  if(progress==100){
                    pullToRefreshController!.endRefreshing();
                  }
                  falseprovider!.changeprogress(progress / 100);
                },
                initialUrlRequest: URLRequest(
                  url: Uri.parse("https://www.google.com/"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
