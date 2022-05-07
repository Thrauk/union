import 'package:equatable/equatable.dart';

class OrganizationJoinRequest extends Equatable {
  const OrganizationJoinRequest({
    required this.id,
    required this.uid,
    required this.organizationId,
    this.requestMessage = '',
    required this.timestamp,
  });

  OrganizationJoinRequest.fromJson(Map<String, dynamic> json)
      : id = json['id'] != null ? (json['id'] as String) : '',
        uid = json['uid'] as String,
        organizationId = json['organization_id'] as String,
        requestMessage = json['request_message'] as String,
        timestamp = json['timestamp'] as int;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'uid': uid,
        'organization_id': organizationId,
        'request_message': requestMessage,
        'timestamp': timestamp,
      }..removeWhere((String key, dynamic value) => value == null);

  static const OrganizationJoinRequest empty = OrganizationJoinRequest(
    id: '',
    uid: '',
    organizationId: '',
    requestMessage: '',
    timestamp: 0,
  );

  OrganizationJoinRequest copyWith({
    String? id,
    String? uid,
    String? organizationId,
    String? requestMessage,
    int? timestamp,
  }) {
    return OrganizationJoinRequest(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      organizationId: organizationId ?? this.organizationId,
      requestMessage: requestMessage ?? this.requestMessage,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  final String id;
  final String uid;
  final String organizationId;
  final String requestMessage;
  final int timestamp;

  @override
  List<Object?> get props => <Object?>[
        id,
        uid,
        organizationId,
        requestMessage,
        timestamp,
      ];
}
