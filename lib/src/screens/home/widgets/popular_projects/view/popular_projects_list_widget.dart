import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/screens/home/widgets/popular_projects/widgets/popular_project_widget.dart';
import 'package:union_app/src/theme.dart';

class PopularProjectsListWidget extends StatelessWidget {
  const PopularProjectsListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('Popular projects this week', style: AppStyles.textStyleHeading1),
        const SizedBox(height: 8),
        Flexible(
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return PopularProjectWidget(project: const Project(title: 'Super project'));
              }),
        )
      ],
    );
  }
}
