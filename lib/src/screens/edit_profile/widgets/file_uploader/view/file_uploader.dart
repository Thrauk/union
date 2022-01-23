import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/repository/storage/firebase_files_repository/firebase_files_repository.dart';
import 'package:union_app/src/screens/edit_profile/widgets/file_uploader/bloc/upload_file_bloc.dart';
import 'package:union_app/src/theme.dart';

class FileUploader extends StatelessWidget {
  const FileUploader({Key? key, required String userId})
      : _userId = userId,
        super(key: key);

  final String _userId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UploadFileBloc>(
      create: (_) => UploadFileBloc(FirebaseFilesRepository())..add(GetFileInitial(_userId)),
      child: _FileUploader(
        userId: _userId,
      ),
    );
  }
}

class _FileUploader extends StatelessWidget {
  const _FileUploader({Key? key, required String userId})
      : _userId = userId,
        super(key: key);

  final String _userId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadFileBloc, UploadFileState>(
      buildWhen: (UploadFileState previous, UploadFileState current) {
        return previous.file != current.file ||
            previous.status != current.status ||
            previous.isFileAlreadyAdded != current.isFileAlreadyAdded;
      },
      builder: (BuildContext context, UploadFileState state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            if (state.status == StatusEnum.INITIAL)
              state.isFileAlreadyAdded == true
                  ? const Text(
                      'File uploaded',
                      style: AppStyles.textStyleBody,
                    )
                  : const Text(
                      'No file uploaded',
                      style: AppStyles.textStyleBody,
                    )
            else
              Expanded(
                flex: 1,
                child: Text(
                  state.file != null ? state.file!.files.first.name : 'No file uploaded',
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyles.textStyleBody,
                ),
              ),
            const SizedBox(width: 8),
            if (state.status != StatusEnum.LOADING)
              Expanded(
                flex: 2,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: AppColors.primaryColor,
                      ),
                      onPressed: () {
                        context.read<UploadFileBloc>().add(ChooseFilePressed(_userId));
                      },
                      child: const Text(
                        'Choose a file',
                        style: AppStyles.buttonTextStyle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (state.isFileAlreadyAdded == true)
                      GestureDetector(
                        onTap: () {
                          context.read<UploadFileBloc>().add(RemoveFilePressed(_userId));
                        },
                        child: const Text(
                          'Remove file',
                          style: AppStyles.textStyleHeading1,
                        ),
                      ),
                  ],
                ),
              )
            else
              const Expanded(
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
