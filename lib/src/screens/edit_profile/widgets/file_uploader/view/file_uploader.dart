import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/repository/storage/firebase_files_repository/firebase_files_repository.dart';
import 'package:union_app/src/screens/app/app.dart';
import 'package:union_app/src/screens/edit_profile/widgets/file_uploader/bloc/upload_file_bloc.dart';
import 'package:union_app/src/theme.dart';

class FileUploader extends StatelessWidget {
  const FileUploader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UploadFileBloc>(
      create: (_) => UploadFileBloc(FirebaseFilesRepository()),
      child: const _FileUploader(),
    );
  }
}

class _FileUploader extends StatelessWidget {
  const _FileUploader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadFileBloc, UploadFileState>(
      buildWhen: (UploadFileState previous, UploadFileState current) {
        return previous.file != current.file || previous.status != current.status;
      },
      builder: (BuildContext context, UploadFileState state) {
        return Row(
          children: <Widget>[
            Text(
              state.file != null ? state.file!.files.first.name : 'No file chosen',
              overflow: TextOverflow.ellipsis,
              style: AppStyles.textStyleBody,
            ),
            const SizedBox(width: 8),
            if (state.status != StatusEnum.LOADING)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: AppColors.primaryColor,
                ),
                onPressed: () {
                  context.read<UploadFileBloc>().add(ChooseFilePressed(context.read<AppBloc>().state.user.id));
                },
                child: const Text(
                  'Choose a file',
                  style: AppStyles.buttonTextStyle,
                ),
              )
            else
              const CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
          ],
        );
      },
    );
  }
}
