import 'dart:developer';
import 'dart:html';

import 'package:docs_clone_flutter/models/document_model.dart';
import 'package:docs_clone_flutter/repository/auth_repository.dart';
import 'package:docs_clone_flutter/repository/document_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  void createNewDoc(WidgetRef ref, ctx) async {
    String token = ref.read(userProvider)!.token;
    // print('tokeneez $token');
    final errorModel =
        await ref.read(documentRepositoryProvider).createNewDocument(token);

    // print(errorModel.data);
    // print(errorModel.error);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () => createNewDoc(ref, context),
                icon: Icon(Icons.add))
          ],
        ),
        body: FutureBuilder(
          future: ref
              .watch(documentRepositoryProvider)
              .documentList(ref.read(userProvider)!.token),
          builder: ((context, snapshot) => snapshot.hasData
              ? Center(
            child: Container(
              width: 600,
              margin: const EdgeInsets.only(top: 10),
                child: ListView.builder(
                    itemCount: snapshot.data!.data.length,
                    itemBuilder: ((context, index) {
                      DocumentModel doc = snapshot.data!.data[index];
                      return InkWell(
                        onTap: () {},
                        child: SizedBox(
                          height: 50,
                          child: Card(
                            child: Center(
                              child: Text(
                                doc.title,
                                style: const TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    })),
              ),)
              : Text('No DATA found')),
        )
        // Center(
        //   child: Text(
        //       '${ref.watch(userProvider)!.email} uid :${ref.watch(userProvider)!.token} end'),
        // ),
        );
  }
}
