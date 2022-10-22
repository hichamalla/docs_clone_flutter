import 'dart:convert';

import 'package:docs_clone_flutter/constant.dart';
import 'package:docs_clone_flutter/models/error_models.dart';
import 'package:docs_clone_flutter/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    googleSignIn: GoogleSignIn(),
    client: Client(),
  ),
);

final userProvider = StateProvider<UserModel?>((ref) => null);

class AuthRepository {
  final GoogleSignIn _googleSignIn;
  final Client _client;
  AuthRepository({
    required GoogleSignIn googleSignIn,
    required Client client,
  })  : _googleSignIn = googleSignIn,
        _client = client;

  Future<ErrorModel> signInWithGoogle() async {
    ErrorModel error = ErrorModel(
      error: "Some unexpeted err",
      data: null,
    );
    try {
      final user = await _googleSignIn.signIn();
      print("user $user");

      if (user != null) {
        print('object1');
        final userAcc = UserModel(
          email: user.email,
          name: user.displayName ?? "",
          profilePic: user.photoUrl ?? "",
          uid: '',
          token: '',
        );
        print('object2');
        print('$host/api/signup');
        var res = await _client.post(
          Uri.parse("$host/api/signup"),
          body: userAcc.toJson(),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
        );
        print(res.statusCode);
        print('object3');
        switch (res.statusCode) {
          case 200:
            final newUser =
                userAcc.copyWith(uid: jsonDecode(res.body)['user']['_id']);
            error = ErrorModel(error: null, data: newUser);
            print("new user${jsonDecode(res.body)['user']}");
            break;
          // default:vcxxxxxx
          // throw 'Some Error'
        }
      }
      print("already log $user");
    } catch (e) {
      print('err');
      error = ErrorModel(error: e.toString(), data: null);
    }
    return error;
  }
}
