import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import '../flutterfire/storage_service.dart';

import '../bartek_color_palette.dart';
import './profile_login_screen.dart';
import './uploading_video_process_screen.dart';

import 'package:form_field_validator/form_field_validator.dart';
import 'package:file_picker/file_picker.dart';

class UploadVideo extends StatefulWidget {
  const UploadVideo({Key? key}) : super(key: key);

  @override
  _UploadVideoState createState() => _UploadVideoState();
}

class _UploadVideoState extends State<UploadVideo> {
  final _formKey = GlobalKey<FormState>();

  final title = TextEditingController();
  final desc = TextEditingController();
  String category = 'One';

  FirebaseAuth auth = FirebaseAuth.instance;

  final titleValidator = MultiValidator([
    RequiredValidator(errorText: 'Tytuł jest wymagany'),
    MinLengthValidator(5, errorText: 'Tytuł musi mieć przynajmniej 5 znaków'),
  ]);

  final descValidator = MultiValidator([
    RequiredValidator(errorText: 'Opis jest wymagany'),
    MinLengthValidator(5, errorText: 'Opis musi mieć przynajmniej 5 znaków'),
  ]);

  final Storage storage = Storage();

  String fileName = "";
  String filePath = "";
  double progress = 0;
  bool isFilePicked = false;

  clearFormCallback() {
    setState(() {
      isFilePicked = false;
      category = "One";
      title.clear();
      desc.clear();
    });
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: Scaffold(
                extendBody: true,
                backgroundColor: BartekColorPalette.bartekGrey[900],
                body: Container(
                  margin: const EdgeInsets.only(
                      top: 40, right: 15, bottom: 55, left: 15),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: const [
                            Align(
                              alignment: Alignment.center,
                              child: Image(
                                height: 48,
                                image: AssetImage(
                                    'assets/images/dailytube-logo.png'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Prześlij film",
                                      style:
                                          Theme.of(context).textTheme.headline1,
                                    ),
                                  ),
                                ),
                                !isFilePicked
                                    ? ElevatedButton(
                                        onPressed: () async {
                                          FilePickerResult? result =
                                              await FilePicker.platform
                                                  .pickFiles();

                                          if (result != null) {
                                            PlatformFile file =
                                                result.files.first;

                                            filePath = file.path.toString();
                                            fileName = file.name;

                                            setState(() {
                                              isFilePicked = true;
                                            });
                                          }
                                        },
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Theme.of(context)
                                                      .colorScheme
                                                      .secondary),
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                            ),
                                          ),
                                        ),
                                        child: Text("Wybierz plik"),
                                      )
                                    : Column(
                                        children: [
                                          Text("SZCZEGÓŁY PLIKU",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              const Text("Nazwa pliku: ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text(fileName),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    left: 25),
                                                child: IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      fileName = "";
                                                      filePath = "";
                                                      isFilePicked = false;
                                                    });
                                                  },
                                                  icon: const Icon(
                                                      Icons.clear_rounded),
                                                  iconSize: 36,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .secondary,
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: FractionallySizedBox(
                                      widthFactor: 0.9,
                                      child: TextFormField(
                                        controller: title,
                                        style: TextStyle(color: Colors.white),
                                        decoration: InputDecoration(
                                          isDense: true,
                                          contentPadding: EdgeInsets.all(10.0),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(200.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(200.0),
                                            borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                              width: 2.0,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(200.0),
                                            borderSide: BorderSide(
                                              width: 0,
                                            ),
                                          ),
                                          filled: true,
                                          fillColor: BartekColorPalette
                                              .bartekGrey[100],
                                          hintText: "Tytuł",
                                          hintStyle:
                                              TextStyle(color: Colors.white70),
                                        ),
                                        validator: titleValidator,
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: FractionallySizedBox(
                                      widthFactor: 0.9,
                                      child: TextFormField(
                                        controller: desc,
                                        style: TextStyle(color: Colors.white),
                                        decoration: InputDecoration(
                                          isDense: true,
                                          contentPadding: EdgeInsets.all(10.0),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(200.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(200.0),
                                            borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                              width: 2.0,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(200.0),
                                            borderSide: BorderSide(
                                              width: 0,
                                            ),
                                          ),
                                          filled: true,
                                          fillColor: BartekColorPalette
                                              .bartekGrey[100],
                                          hintText: "Opis filmu",
                                          hintStyle:
                                              TextStyle(color: Colors.white70),
                                        ),
                                        validator: descValidator,
                                      ),
                                    ),
                                  ),
                                ),
                                DropdownButton<String>(
                                  value: category,
                                  elevation: 14,
                                  style: const TextStyle(color: Colors.white),
                                  dropdownColor: BartekColorPalette.bartekGrey,
                                  underline: Container(
                                    height: 2,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      category = newValue!;
                                    });
                                  },
                                  items: <String>['One', 'Two', 'Free', 'Four']
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                                SizedBox(
                                  width: 250,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 10),
                                    child: isFilePicked
                                        ? ElevatedButton(
                                            onPressed: () {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        UploadingVideoProcess(
                                                      filePath: filePath,
                                                      fileName: fileName,
                                                      title: title.text,
                                                      description: desc.text,
                                                      category: category,
                                                      formKey: _formKey,
                                                      clearFormCallback:
                                                          clearFormCallback,
                                                    ),
                                                  ),
                                                );
                                              }
                                            },
                                            child: Text(
                                              "Prześlij film",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline3,
                                            ),
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Theme.of(context)
                                                          .colorScheme
                                                          .secondary),
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          18.0),
                                                ),
                                              ),
                                              padding: MaterialStateProperty
                                                  .all<EdgeInsets>(
                                                const EdgeInsets.fromLTRB(
                                                    0, 10, 0, 10),
                                              ),
                                            ),
                                          )
                                        : ElevatedButton(
                                            onPressed: null,
                                            child: Text(
                                              "Prześlij film",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline3,
                                            ),
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      BartekColorPalette
                                                          .orange[800]),
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          18.0),
                                                ),
                                              ),
                                              padding: MaterialStateProperty
                                                  .all<EdgeInsets>(
                                                const EdgeInsets.fromLTRB(
                                                    0, 10, 0, 10),
                                              ),
                                            ),
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return ProfileLogin();
          }
        },
      );
}
