import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/theme.dart';

class ApplicantItemWidget extends StatelessWidget {
  const ApplicantItemWidget({Key? key, required this.user}) : super(key: key);

  final FullUser user;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.backgroundLight,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: user.photo != ''
                              ? CachedNetworkImageProvider(user.photo!)
                              : const AssetImage('assets/icons/user.png')
                                  as ImageProvider),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user.displayName ?? '',
                        style: AppStyles.textStyleBody),
                    const SizedBox(height: 8),
                    if (user.location != null)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: AppColors.white07,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            user.location!,
                            style: AppStyles.textStyleBodySmall,
                          ),
                        ],
                      ),
                    const SizedBox(height: 6),
                    if (user.jobTitle != null)
                      Row(
                        children: [
                          const Icon(
                            Icons.work,
                            color: AppColors.white07,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            user.jobTitle!,
                            style: AppStyles.textStyleBodySmall,
                          ),
                        ],
                      ),
                  ],
                ),
                const Spacer(),
                Container(
                  alignment: Alignment.center,
                  child: Chip(
                    label: Row(
                      children: const <Widget>[
                        Icon(Icons.send, size: 18,),
                        SizedBox(width: 4),
                        Text(
                          'Send message',
                          style: TextStyle(
                              color: AppColors.backgroundDark,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    labelPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 4),
                    backgroundColor: AppColors.primaryColor,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
