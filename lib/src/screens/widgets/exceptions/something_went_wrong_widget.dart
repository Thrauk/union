import 'package:flutter/cupertino.dart';
import 'package:union_app/src/theme.dart';

class SomethingWentWrongWidget extends StatelessWidget {
  const SomethingWentWrongWidget({Key? key, String message = 'Oops! Something went wrong!'})
      : _message = message,
        super(key: key);

  final String _message;

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
              image: AssetImage('assets/icons/something_went_wrong.png'),
            ),
          ),
          const SizedBox(height: 32),
          Text(_message, style: AppStyles.textStyleBody),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
