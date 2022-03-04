import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../bartek_color_palette.dart';
import './profile_account.dart';

import 'package:form_field_validator/form_field_validator.dart';

class ProfileRegister extends StatefulWidget {
  const ProfileRegister({Key? key}) : super(key: key);

  @override
  _ProfileRegisterState createState() => _ProfileRegisterState();
}

class _ProfileRegisterState extends State<ProfileRegister> {
  final email = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final rePassword = TextEditingController();

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

  @override
  Widget build(BuildContext context) => StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ProfileAccount();
          } else {
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
                                      "Rejestracja",
                                      style:
                                          Theme.of(context).textTheme.headline1,
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
                                          controller: email,
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
                                            hintText: "Adres e-mail",
                                            hintStyle: TextStyle(
                                                color: Colors.white70),
                                          ),
                                          validator: EmailValidator(
                                              errorText:
                                                  "Nieprawidłowy adres e-mail"),
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
                                          controller: username,
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
                                            hintText: "Nazwa użytkownika",
                                            hintStyle: TextStyle(
                                                color: Colors.white70),
                                          ),
                                          validator: usernameValidator,
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
                                          controller: password,
                                          style: TextStyle(color: Colors.white),
                                          obscureText: true,
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
                                            hintText: "Hasło",
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
                                          style: TextStyle(color: Colors.white),
                                          obscureText: true,
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
                                            hintText: "Powtórz hasło",
                                            hintStyle: TextStyle(
                                                color: Colors.white70),
                                          ),
                                          validator: (val) => MatchValidator(
                                                  errorText:
                                                      'Hasła nie są takie same')
                                              .validateMatch(val.toString(),
                                                  password.text),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 250,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 10),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          registerUser(username.text,
                                              email.text, password.text);
                                          email.clear();
                                          username.clear();
                                          password.clear();
                                          rePassword.clear();
                                          _formKey.currentState!.reset();
                                        }
                                      },
                                      child: Text(
                                        "Załóż konto",
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
          }
        },
      );
}

Future registerUser(String username, String email, String password) async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  try {
    UserCredential result = await auth.createUserWithEmailAndPassword(
        email: email, password: password);

    User? user = result.user;
    if (user != null) {
      user.updateDisplayName(username);
      await user.reload();
      user = await auth.currentUser;
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
  } catch (e) {
    print(e);
  }
}
