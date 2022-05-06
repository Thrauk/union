import 'package:flutter/cupertino.dart';
import 'package:union_app/src/theme.dart';

class EmptyPageWidget extends StatelessWidget {
  const EmptyPageWidget({Key? key, required this.message}) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 34),
            child: Image(
              image: AssetImage('assets/icons/empty.png'),
            ),
          ),
          const SizedBox(height: 32),
          Text(message, style: AppStyles.textStyleBody),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
