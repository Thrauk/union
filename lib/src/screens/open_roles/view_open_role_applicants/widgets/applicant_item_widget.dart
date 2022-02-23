import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/screens/home/widgets/avatar.dart';
import 'package:union_app/src/screens/messaging/chat/view/chat_page.dart';
import 'package:union_app/src/screens/open_roles/view_open_role_applicants/bloc/open_role_applicants_bloc.dart';
import 'package:union_app/src/screens/open_roles/view_open_role_applicants/view/applicant_cv_page.dart';
import 'package:union_app/src/theme.dart';

class ApplicantItemWidget extends StatelessWidget {
  const ApplicantItemWidget({Key? key, required this.applicationItem}) : super(key: key);

  final ProjectOpenRoleApplicationItem applicationItem;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OpenRoleApplicantsBloc, OpenRoleApplicantsState>(
      builder: (BuildContext context, OpenRoleApplicantsState state) {
        return Card(
          color: AppColors.backgroundLight,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Avatar(photo:applicationItem.user.photo, avatarSize: 28),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(applicationItem.user.displayName ?? '', style: AppStyles.textStyleBody,
                        overflow: TextOverflow.ellipsis),
                        const SizedBox(height: 8),
                        if (applicationItem.user.location != null)
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
                                applicationItem.user.location!,
                                style: AppStyles.textStyleBodySmall,
                              ),
                            ],
                          ),
                        const SizedBox(height: 6),
                        if (applicationItem.user.jobTitle != null)
                          Row(
                            children: [
                              const Icon(
                                Icons.work,
                                color: AppColors.white07,
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                applicationItem.user.jobTitle!,
                                style: AppStyles.textStyleBodySmall,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                      ],
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(ChatPage.route(applicationItem.user.id));
                        },
                        child: Container(
                          alignment: Alignment.center,
                          child: Chip(
                            label: Row(
                              children: const <Widget>[
                                Icon(
                                  Icons.send,
                                  size: 18,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  'Send message',
                                  style: TextStyle(color: AppColors.backgroundDark, fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            labelPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
                            backgroundColor: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                if (applicationItem.notice.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: AppColors.backgroundLight1,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(bottom: 8),
                              child: Text(
                                'Note',
                                style: AppStyles.textStyleBody,
                              ),
                            ),
                            Text(
                              applicationItem.notice,
                              style: AppStyles.textStyleBodySmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                if (applicationItem.cvUrl.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: ElevatedButton.icon(
                      icon: const Icon(
                        Icons.insert_drive_file_sharp,
                        color: AppColors.primaryColor,
                        size: 20.0,
                      ),
                      label: const Text(
                        'View resume',
                        style: AppStyles.textStyleBodySmallW08,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context, ApplicantCvPage.route(applicationItem.cvUrl, applicationItem.user.displayName ?? ''));
                      },
                      style: ElevatedButton.styleFrom(
                        primary: AppColors.backgroundLight1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
