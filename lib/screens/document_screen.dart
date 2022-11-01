import 'package:docs_clone_flutter/colors.dart';
import 'package:docs_clone_flutter/models/error_models.dart';
import 'package:docs_clone_flutter/repository/auth_repository.dart';
import 'package:docs_clone_flutter/repository/document_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DocumentScreen extends ConsumerStatefulWidget {
  final String docID;
  const DocumentScreen({
    required this.docID,
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DocumentScreenState();
}

class _DocumentScreenState extends ConsumerState<DocumentScreen> {
  TextEditingController _titleController = TextEditingController();
  quill.QuillController _controller = quill.QuillController.basic();
  ErrorModel? errorModel;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titleController.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchDocumentData();
  }

  void fetchDocumentData() async {
    ErrorModel dataModel = await ref
        .read(documentRepositoryProvider)
        .getDocumentById(
            token: ref.read(userProvider)!.token, id: widget.docID);
    print('dddocid${dataModel.data.toString()}');
    if (dataModel != null) {
      if (dataModel.data != null) {
        _titleController.text = dataModel.data.title;
      } else {
        throw (dataModel.error.toString());
      }
    }
  }

  void updateTitle(WidgetRef ref) {
    ref.read(documentRepositoryProvider).updateTitle(
          token: ref.read(userProvider)!.token,
          id: widget.docID,
          title: _titleController.text,
        );
    // ref.read(docProvider.notifier).update((state) => null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Image.asset(
                'assets/images/docs-logo.png',
                height: 40,
              ),
              const SizedBox(width: 10),
              SizedBox(
                  width: 200,
                  child: TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: kBleuColor,
                        ),
                      ),
                      contentPadding: EdgeInsets.only(
                        left: 10,
                      ),
                    ),
                    onSubmitted: (value) => updateTitle(ref),
                  ))
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: kBleuColor),
              onPressed: () {},
              icon: const Icon(
                Icons.lock,
                size: 16,
              ),
              label: const Text('Share'),
            ),
          )
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
              color: kGreyColor,
              width: 0.1,
            )),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            quill.QuillToolbar.basic(controller: _controller),
            Expanded(
              child: Container(
                width: 750,
                child: Card(
                  color: kWhiteColor,
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: quill.QuillEditor.basic(
                      controller: _controller,
                      readOnly: false, // true for view only mode
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
