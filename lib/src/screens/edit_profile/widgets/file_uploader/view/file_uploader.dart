import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_app/src/screens/edit_profile/widgets/file_uploader/bloc/upload_file_bloc.dart';

class FileUploader extends StatelessWidget {
  const FileUploader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UploadFileBloc>(
      create: (_) => UploadFileBloc(),
      child: const _FileUploader(),
    );
  }
}

class _FileUploader extends StatelessWidget {
  const _FileUploader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const <Widget>[],
    );
  }
}
