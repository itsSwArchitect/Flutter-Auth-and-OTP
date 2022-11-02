import 'package:cloud_firestore/cloud_firestore.dart';

class MUser {
  final String id;
  final String uid;
  final String displayName;
  final String quote;
  final String profession;
  final String avatarUrl;

  MUser(
      {required this.id,
      required this.uid,
      required this.displayName,
      required this.quote,
      required this.profession,
      required this.avatarUrl});

  factory MUser.fromDocument(QueryDocumentSnapshot data) {
    Map info = data.data() as Map;
    return MUser(
      id: data.id,
      uid: info['uid'],
      displayName: info['display_name'],
      quote: info['quote'],
      profession: info['profession'],
      avatarUrl: info['avatar_url'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'display_name': displayName,
      'quote': quote,
      'profession': profession,
      'avatar_url': avatarUrl,
    };
  }
}
