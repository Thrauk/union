import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/screens/organization/view_organization_requests/bloc/view_organization_requests_bloc.dart';
import 'package:union_app/src/screens/widgets/user_item/user_item_widget.dart';
import 'package:union_app/src/screens/widgets/widgets.dart';
import 'package:union_app/src/theme.dart';

class ViewOrganizationRequests extends StatelessWidget {
  const ViewOrganizationRequests({Key? key, required this.organizationId}) : super(key: key);

  static Route<void> route(String organizationId) {
    return MaterialPageRoute<void>(
      builder: (_) => ViewOrganizationRequests(
        organizationId: organizationId,
      ),
    );
  }

  final String organizationId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const SimpleAppBar(title: 'Join requests'),
      body: BlocProvider<ViewOrganizationRequestsBloc>(
        create: (BuildContext context) => ViewOrganizationRequestsBloc(organizationId: organizationId)..add(LoadData()),
        child: _ViewOrganizationRequests(
          organizationId: organizationId,
        ),
      ),
    );
  }
}

class _ViewOrganizationRequests extends StatelessWidget {
  const _ViewOrganizationRequests({Key? key, required this.organizationId}) : super(key: key);

  final String organizationId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ViewOrganizationRequestsBloc, ViewOrganizationRequestsState>(
      builder: (BuildContext context, ViewOrganizationRequestsState state) {
        return LoadingPlaceholder(
          isLoaded: state.isLoaded,
          child: ListView.builder(
            //shrinkWrap: true,
            itemCount: state.userRequests.length,
            itemBuilder: (BuildContext context, int index) {
              return UserItemWidget(
                user: state.userRequests[index],
                endWidget: Row(
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        context.read<ViewOrganizationRequestsBloc>().add(DenyRequest(joinRequest: state.joinRequests[index]));
                      },
                      icon: const Icon(
                        Icons.close,
                        color: AppColors.redLight,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        context.read<ViewOrganizationRequestsBloc>().add(AcceptRequest(joinRequest: state.joinRequests[index]));
                      },
                      icon: const Icon(
                        Icons.check,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
