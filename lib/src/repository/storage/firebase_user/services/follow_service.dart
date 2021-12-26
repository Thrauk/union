import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:union_app/src/models/models.dart';
import 'package:union_app/src/repository/storage/firebase_user/firebase_user.dart';

enum _FollowOperationType { Add, Remove }

class FollowService {

  FollowService();

  final FirebaseUserRepository _firebaseUserRepository = FirebaseUserRepository();

  Future<void> followUser(String myUserUid, String otherUserUid) async {
    final FullUser myUser = await _firebaseUserRepository.getFullUserByUid(myUserUid);
    final FullUser otherUser = await _firebaseUserRepository.getFullUserByUid(otherUserUid);

    await _firebaseUserRepository.updateUserDetails(_addOrRemoveFollower(myUserUid, otherUser, _FollowOperationType.Add));
    await _firebaseUserRepository.updateUserDetails(_addOrRemoveFollowing(otherUserUid, myUser, _FollowOperationType.Add));
  }

  Future<void> unfollowUser(String myUserUid, String otherUserUid) async {
    final FullUser myUser = await _firebaseUserRepository.getFullUserByUid(myUserUid);
    final FullUser otherUser = await _firebaseUserRepository.getFullUserByUid(otherUserUid);

    await _firebaseUserRepository.updateUserDetails(_addOrRemoveFollower(myUserUid, otherUser, _FollowOperationType.Remove));
    await _firebaseUserRepository.updateUserDetails(_addOrRemoveFollowing(otherUserUid, myUser, _FollowOperationType.Remove));
  }


  FullUser _addOrRemoveFollower(String followerUid, FullUser user, _FollowOperationType operationType) {
    final List<String> followers =
        operationType == _FollowOperationType.Add ? _addUid(followerUid, user.followers) : _removeUid(followerUid, user.followers);
    return user.copyWith(followers: followers);
  }

  FullUser _addOrRemoveFollowing(String followingUid, FullUser user, _FollowOperationType operationType) {
    final List<String> following =
        operationType == _FollowOperationType.Add ? _addUid(followingUid, user.following) : _removeUid(followingUid, user.following);
    return user.copyWith(following: following);
  }

  List<String> _addUid(String uid, List<dynamic>? collection) {
    final List<String> ret = collection?.cast<String>() ?? List<String>.empty(growable: true);
    if (!ret.contains(uid)) {
      ret.add(uid);
    }
    return ret;
  }

  List<String> _removeUid(String uid, List<dynamic>? collection) {
    final List<String> ret = collection?.cast<String>() ?? List<String>.empty(growable: true);
    ret.remove(uid);
    return ret;
  }
}
