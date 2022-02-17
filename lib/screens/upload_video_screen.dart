import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import '../flutterfire/storage_service.dart';

import '../bartek_color_palette.dart';
import './profile_account.dart';
import './profile_login_screen.dart';
import '../flutterfire/add_video_doc.dart';

import 'package:form_field_validator/form_field_validator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';

class UploadVideo extends StatefulWidget {
  const UploadVideo({Key? key}) : super(key: key);

  @override
  _UploadVideoState createState() => _UploadVideoState();
}

class _UploadVideoState extends State<UploadVideo> {
  final title = TextEditingController();
  final desc = TextEditingController();
  String category = 'One';

  final _formKey = GlobalKey<FormState>();

  FirebaseAuth auth = FirebaseAuth.instance;

  final usernameValidator = MultiValidator([
    RequiredValidator(errorText: 'Nazwa użytkownika jest wymagana'),
    MinLengthValidator(5,
        errorText: 'Nazwa użytkownika musi mieć przynajmniej 5 znaków'),
  ]);

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Hasło jest wymagane'),
    MinLengthValidator(8, errorText: 'Hasło musi miec przynajmniej 8 znaków'),
    PatternValidator(
        r'^(?=.*[0-9])(?=.*[A-Z])(?=.*[a-z])(?=.*[^\w\d\s:]).{8,}$',
        errorText: 'Hasło musi posiadać przynajmniej jeden znak specjalny'),
  ]);

  final Storage storage = Storage();

  String fileName = "";
  String filePath = "";

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
                                height: 32,
                                image: AssetImage(
                                    'assets/images/bartekhub-logo.png'),
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
                                ElevatedButton(
                                  onPressed: () async {
                                    FilePickerResult? result =
                                        await FilePicker.platform.pickFiles();

                                    if (result != null) {
                                      PlatformFile file = result.files.first;

                                      filePath = file.path.toString();
                                      fileName = file.name;
                                    }
                                  },
                                  child: Text("Upload file"),
                                ),
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: SizedBox(
                                      height: 40,
                                      child: FractionallySizedBox(
                                        widthFactor: 0.9,
                                        child: TextFormField(
                                          controller: title,
                                          style: TextStyle(color: Colors.white),
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.all(10.0),
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
                                            hintStyle: TextStyle(
                                                color: Colors.white70),
                                          ),
                                          validator: passwordValidator,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: SizedBox(
                                      height: 40,
                                      child: FractionallySizedBox(
                                        widthFactor: 0.9,
                                        child: TextFormField(
                                          controller: desc,
                                          style: TextStyle(color: Colors.white),
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.all(10.0),
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
                                            hintStyle: TextStyle(
                                                color: Colors.white70),
                                          ),
                                        ),
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
                                    child: ElevatedButton(
                                      onPressed: () {
                                        var currentUser =
                                            FirebaseAuth.instance.currentUser;
                                        var userId =
                                            currentUser!.uid.toString();

                                        storage
                                            .uploadFile(filePath, fileName)
                                            .then((value) => print('Done'));

                                        var random = new DateTime.now()
                                            .millisecondsSinceEpoch;

                                        var thumbName = "thumb_" +
                                            random.toString() +
                                            ".jpeg";

                                        storage.genThumbnailFile(
                                            filePath, thumbName);

                                        AddVideo(
                                                title.text,
                                                desc.text,
                                                category,
                                                'videos/$fileName',
                                                'thumbnails/$thumbName',
                                                userId,
                                                DateTime.now())
                                            .addVideo();
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
                                                BorderRadius.circular(18.0),
                                          ),
                                        ),
                                        padding: MaterialStateProperty.all<
                                            EdgeInsets>(
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
