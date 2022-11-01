import 'dart:convert';


// ignore_for_file: public_member_api_docs, sort_constructors_first
class DocumentModel {
  final String uid;
  final String title;
  final List content;
  final String createdAt;
  final String updatedAt;
  final String id;

  DocumentModel({
    required this.uid,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'title': title,
      'content': content,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'id': id,
    };
  }

  factory DocumentModel.fromMap(Map<String, dynamic> map) {
    // print('objectobjectobject$map');
    return DocumentModel(
      uid: map['uid'] as String,
      title: map['title'] as String,
      content: [],
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
      id: map['_id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DocumentModel.fromJson(String source) =>
      DocumentModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
