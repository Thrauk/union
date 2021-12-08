import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:union_app/src/screens/widgets/app_bar/simple_app_bar.dart';
import 'package:union_app/src/theme.dart';


class CreateArticlePage extends StatelessWidget {
  const CreateArticlePage({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const CreateArticlePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: 'Create article'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            const Expanded(
              child: TextField(
                style: AppStyles.textStyleBody,
                minLines: 1,
                maxLines: null,
                cursorColor: AppColors.white07,
                decoration: InputDecoration(
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    hintText: 'Start writing here...',
                    border: InputBorder.none),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                primary: AppColors.primaryColor,
                onSurface: Colors.transparent,
                shadowColor: Colors.transparent,
                side: const BorderSide(
                  width: 2.0,
                  color: AppColors.primaryColor,
                ),
                minimumSize: const Size(double.infinity, 48),
              ),
              child: const Text(
                'Publish',
                style: AppStyles.buttonTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
