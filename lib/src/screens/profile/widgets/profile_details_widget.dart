import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/screens/home/home.dart';
import 'package:union_app/src/screens/profile/bloc/profile_bloc.dart';

class ProfileDetailsWidget extends StatelessWidget {
  const ProfileDetailsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
        builder: (BuildContext context, ProfileState state) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Stack(
          children: [
            Column(
              children: <Widget>[
                Avatar(
                  photo: null,
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  state.fullUser.displayName ?? 'John Doe',
                  style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Text(
                      state.fullUser.location ?? 'No location',
                      style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 0.8),
                        fontSize: 16,
                      ),
                    ),
                    const Text(
                      ' • ',
                      style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 0.8),
                        fontSize: 16,
                      ),
                    ),
                    Text(
                        state.fullUser.jobTitle ?? 'No job :(',
                      style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 0.8),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  state.fullUser.description ?? 'No description',
                  style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 0.85),
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            ),
            Align(
              alignment: Alignment.topRight,
              child: Icon(
                Icons.edit,
                color: Color.fromRGBO(255, 255, 255, 0.7),
              ),
            ),
          ],
        ),
      );
    });
  }
}
