import 'package:flutter/material.dart';
import 'package:flutter_crudapi/add-blog.dart';
import 'package:flutter_crudapi/model.dart';
import 'package:flutter_crudapi/repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      routes: {
        '/home': (context) => const MyHomePage(title: 'Materi Perkuliahan'),
        '/add-blog': (context) => const AddBlog()
      },
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Materi Perkuliahan'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Blog> listBlog = [];
  Repository repository = Repository();

  getData() async {
    listBlog = await repository.getData();
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
              icon: const Icon(Icons.add),
              onPressed: () =>
                  Navigator.of(context).popAndPushNamed('/add-blog'))
        ],
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            // ignore: avoid_unnecessary_containers
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context)
                      .popAndPushNamed('/add-blog', arguments: [
                    listBlog[index].id,
                    listBlog[index].title,
                    listBlog[index].content
                  ]),
                  child: Container(
                    // ignore: prefer_const_constructors
                    margin: EdgeInsets.all(10),
                    // ignore: prefer_const_constructors
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          listBlog[index].title,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        Text(listBlog[index].content)
                      ],
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () async {
                      // ignore: unused_local_variable
                      bool response =
                          await repository.deleteData(listBlog[index].id);
                      if (response) {
                        // ignore: avoid_print
                        print('Hapus Data Berhasil');
                      } else {
                        // ignore: avoid_print
                        print('Hapus Data Gagal');
                      }
                      getData();
                    },
                    icon: const Icon(Icons.delete))
              ],
            );
          },
          separatorBuilder: (context, index) {
            return const Divider();
          },
          itemCount: listBlog.length),
    );
  }
}
