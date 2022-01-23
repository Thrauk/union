import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:union_app/src/screens/widgets/app_bar/simple_app_bar.dart';

class ApplicantCvPage extends StatelessWidget {
  const ApplicantCvPage({Key? key, required this.url, required this.applicantName}) : super(key: key);

  final String url;
  final String applicantName;

  static Route<void> route(final String url, final String applicantName) {
    return MaterialPageRoute<void>(
        builder: (_) => ApplicantCvPage(
              applicantName: applicantName,
              url: url,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: SimpleAppBar(title: applicantName), body : const PDF().fromUrl(url));
  }
}
