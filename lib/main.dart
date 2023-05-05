import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  XFile? pickedImage;
  ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: pickedImage == null
                    ? Image.asset('assets/open_book.png')
                    : Image.file(File(pickedImage!.path), fit: BoxFit.contain),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () => dialogBuilder(context),
                  child: const Text(
                    'Upload Image',
                  ))
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     await picker
      //         .pickImage(source: ImageSource.camera)
      //         .then((value) => setState(
      //               () {
      //                 pickedImage = value;
      //               },
      //             ));
      //   },
      //   child: const Icon(Icons.add),
      // ),
    );
  }

  Future<void> dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: Container(
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue, width: 3),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.image_outlined,
              color: Colors.blue,
              size: 30,
            ),
          ),
          title: const Text('Upload image via..'),
          // content: const Text(
          //     'Do you really want to delete Your account? You will not be able to undo this action.'),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.blue)),
                    onPressed: () async {
                      await picker
                          .pickImage(source: ImageSource.camera)
                          .then((value) => setState(
                                () {
                                  pickedImage = value;
                                },
                              ))
                          .then((value) => Navigator.of(context).pop());
                    },
                    child: const Text('Camera')),
                OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.blue)),
                    onPressed: () async {
                      await picker
                          .pickImage(source: ImageSource.gallery)
                          .then((value) => setState(
                                () {
                                  pickedImage = value;
                                },
                              ))
                          .then((value) => Navigator.of(context).pop());
                    },
                    child: const Text('Gallery')),
              ],
            )
          ],
        );
      },
    );
  }
}
