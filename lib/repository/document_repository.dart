import 'dart:convert';
import 'dart:developer';

import 'package:docs_clone_flutter/constant.dart';
import 'package:docs_clone_flutter/models/document_model.dart';
import 'package:docs_clone_flutter/models/error_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final documentRepositoryProvider = Provider((ref) => DocumentsRepository());

class DocumentsRepository {
  Future<ErrorModel> documentList(String token) async {
    ErrorModel errorModel = ErrorModel(error: 'UN expected ERR', data: null);
    List<DocumentModel> docs = [];
    print('message');
    try {
      var res = await http.get(Uri.parse('$host/documents/list'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'token': token,
      });
      log("resbody${res.body}");
      List rawDowc = jsonDecode(res.body);

      rawDowc.forEach((element) {
        print(
            element.runtimeType);
        docs.add(DocumentModel.fromJson(jsonEncode(element)));
      });
      print('hh r' + docs[0].title);
      errorModel = ErrorModel(error: null, data: docs);
    } catch (e) {}
    return errorModel;
  }

  Future<ErrorModel> createNewDocument(String token) async {
    ErrorModel errorModel = ErrorModel(error: 'UN expected ERR', data: null);

    try {
      var res = await http.post(
        Uri.parse("$host/documents/create"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'token': token,
        },
      );
      print(res.body);
      errorModel = ErrorModel(
        error: null,
        data: DocumentModel.fromJson(res.body),
      );
    } catch (e) {
      errorModel = ErrorModel(error: e.toString(), data: null);
    }
    print('${errorModel.error} hii');
    return errorModel;
  }
}
