import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class homeprovider extends ChangeNotifier
{
  TextEditingController txtsearch = TextEditingController();
  InAppWebViewController? inAppWebViewController;
  double progress=0;

  void changeprogress(double ps)
  {
   progress=ps;
   notifyListeners();
  }
}