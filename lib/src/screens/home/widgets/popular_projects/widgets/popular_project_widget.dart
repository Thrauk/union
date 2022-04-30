import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/theme.dart';


class PopularProjectWidget extends StatelessWidget {
  const PopularProjectWidget({Key? key, required Project project})
      : _project = project,
        super(key: key);

  final Project _project;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 50,
      child: Card(
        color: AppColors.backgroundLight,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(_project.title!, overflow: TextOverflow.ellipsis, style: AppStyles.textStyleBody),
                    Text("by John Doe", style: AppStyles.textStyleBodySmall),
                  ],
                ),
              ),
               Spacer(),
              Flexible(child: Text("233 likes", style: AppStyles.textStyleBodyPrimarySmall) ,flex: 1,),
            ],
          ),
        ),
      ),
    );
  }
}
