import 'package:equatable/equatable.dart';

class DeviceToken extends Equatable {
  const DeviceToken({
    required this.uid,
    required this.deviceToken,
  });

  DeviceToken.fromJson(Map<String, dynamic> json)
      : uid = json['uid'] as String,
        deviceToken = json['device_token'] as String;

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'device_token': deviceToken,
      }..removeWhere((String key, dynamic value) => value == null);

  final String uid;
  final String deviceToken;

  @override
  List<Object> get props => <Object>[uid, deviceToken];
}
