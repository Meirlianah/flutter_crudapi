// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, duplicate_ignore

// ignore: unnecessary_import, implementation_imports
import 'package:flutter/src/foundation/key.dart';
// ignore: unnecessary_import, implementation_imports
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:flutter_crudapi/repository.dart';

class AddBlog extends StatefulWidget {
  const AddBlog({Key? key}) : super(key: key);

  @override
  State<AddBlog> createState() => _AddBlogState();
}

class _AddBlogState extends State<AddBlog> {
  Repository repository = Repository();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as List<String>;
    if (args[1].isNotEmpty) {
      _titleController.text = args[1];
    }
    if (args[2].isNotEmpty) {
      _contentController.text = args[2];
    }
    return Scaffold(
      appBar: AppBar(
        // ignore: prefer_const_constructors
        title: Text('Add Blog'),
      ),
      // ignore: avoid_unnecessary_containers
      body: Container(
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(hintText: 'Title'),
            ),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(hintText: 'Content'),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20.0),
            ),
            ElevatedButton(
                onPressed: () async {
                  bool response = await repository.postData(
                      _titleController.text, _contentController.text);

                  if (response) {
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).popAndPushNamed('/home');
                  } else {
                    // ignore: avoid_print
                    print('Post Data Gagal');
                  }
                },
                child: Text('Submit')),
            const Padding(padding: EdgeInsets.only(top: 20.0)),
            ElevatedButton(
                onPressed: () async {
                  bool response = await repository.putData(int.parse(args[0]),
                      _titleController.text, _contentController.text);

                  if (response) {
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).popAndPushNamed('/home');
                  } else {
                    // ignore: avoid_print
                    print('Post Data Gagal');
                  }
                },
                child: Text('Update'))
          ],
        ),
      ),
    );
  }
}
