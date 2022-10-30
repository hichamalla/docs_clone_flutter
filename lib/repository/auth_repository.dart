// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:docs_clone_flutter/constant.dart';
import 'package:docs_clone_flutter/models/error_models.dart';
import 'package:docs_clone_flutter/models/user_model.dart';
import 'package:docs_clone_flutter/repository/shared_prefrances.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
      googleSignIn: GoogleSignIn(),
      client: Client(),
      localDataRepository: LocalDataRepository()),
);

final userProvider = StateProvider<UserModel?>((ref) => null);

class AuthRepository {
  final GoogleSignIn _googleSignIn;
  final Client _client;
  final LocalDataRepository _localDataRepository;
  AuthRepository({
    required GoogleSignIn googleSignIn,
    required Client client,
    required LocalDataRepository localDataRepository,
  })  : _googleSignIn = googleSignIn,
        _client = client,
        _localDataRepository = localDataRepository;

  Future<ErrorModel> signInWithGoogle() async {
    ErrorModel error = ErrorModel(
      error: "Some unexpeted err",
      data: null,
    );
    try {
      final user = await _googleSignIn.signIn();
      // print("user $user");

      if (user != null) {
        // print('object1');
        final userAcc = UserModel(
          email: user.email,
          name: user.displayName ?? "",
          profilePic: user.photoUrl ?? "",
          uid: '',
          token: '',
        );
        // print('object2');
        // print('$host/api/signup');
        var res = await _client.post(
          Uri.parse("$host/api/signup"),
          body: userAcc.toJson(),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
        );
        // print(res.statusCode);
        // print(res);
        // print('object3');
        switch (res.statusCode) {
          case 200:
            final newUser = userAcc.copyWith(
              uid: jsonDecode(res.body)['user']['_id'],
              token: jsonDecode(res.body)['token'],
            );

            _localDataRepository.setToken(newUser.token);
            error = ErrorModel(error: null, data: newUser);

            // print("new user${jsonDecode(res.body)['user']}");
            break;
          // default:vcxxxxxx
          // throw 'Some Error'
        }
      }
      // print("already log $user");
    } catch (e) {
      // print('err');
      error = ErrorModel(error: e.toString(), data: null);
    }
    return error;
  }

  Future<ErrorModel> getUserData() async {
    ErrorModel dataModel = ErrorModel(error: 'Some UNexpected err', data: null);
    String? token = await _localDataRepository.getToken();
    // print("token$token");
    if (token != null) {
      try {
        // print("token2");
        var res = await _client.get(Uri.parse("$host/api/getuser"), headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'token': token
        });
        // print("res${res.body}");
        if (res.statusCode == 200) {
          // print("tokenxx${jsonEncode(jsonDecode(res.body)['user'])}");
          final newUSER =
              UserModel.fromJson(jsonEncode(jsonDecode(res.body)['user']))
                  .copyWith(
            token: token,
          );
          // print(newUSER.toMap());
          dataModel = ErrorModel(error: null, data: newUSER);
        }
      } catch (e) {
        // print(e);
        dataModel = ErrorModel(error: e.toString(), data: null);
      }
    }
    return dataModel;
  }
}
