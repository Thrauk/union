import 'package:flutter/cupertino.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/screens/home/home.dart';
import 'package:union_app/src/theme.dart';

class MembersWidget extends StatelessWidget {
  const MembersWidget({Key? key, required List<FullUser> membersList})
      : _membersList = membersList,
        super(key: key);

  final List<FullUser> _membersList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
         const Text('Members', style: AppStyles.textStyleHeading1),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _membersList.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal:6, vertical: 6),
                  child: Avatar(photo: _membersList[index].photo, avatarSize: 22,),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
