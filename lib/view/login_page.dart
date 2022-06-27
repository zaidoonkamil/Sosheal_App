import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sosheal_app_doid/view/sosheal.dart';
import 'package:sosheal_app_doid/helper/show_snack_bar.dart';

import '../../widgets/custom_text_field.dart';
import '../widgets/custom_button_login.dart';
import 'RegisterPage.dart';

//helo

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  static String id = 'login page';
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  Color primaryColor=const Color(0xff0f1a1f);

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  String email, password;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      progressIndicator: const CircularProgressIndicator(color: Colors.white,),
      color: primaryColor,
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: primaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Form(
            key: formKey,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 60,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Sosheal App',
                          style: TextStyle(
                            fontSize: 32,
                            color: Colors.white,
                            fontFamily: 'pacifico',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      children: const [
                        Text(
                          'LOGIN',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomFormTextField(
                      onChanged: (data) {
                        email = data;
                      },
                      hintText: 'Email',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomFormTextField(
                      obscureText: true,
                      onChanged: (data) {
                        password = data;
                      },
                      hintText: 'Password',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButon(
                      onTap: () async {
                        if (formKey.currentState.validate()) {
                          isLoading = true;
                          setState(() {});
                          try {
                            await loginUser();

                            Navigator.pushNamed(context, sosheal.id,
                                arguments: email);
                          } on FirebaseAuthException catch (ex) {
                            if (ex.code == 'user-not-found') {
                              showSnackBar(context, 'user not found');
                            } else if (ex.code == 'wrong-password') {
                              showSnackBar(context, 'wrong password');
                            }
                          } catch (ex) {
                            print(ex);
                            showSnackBar(context, 'there was an error');
                          }

                          isLoading = false;
                          setState(() {});
                        } else {}
                      },
                      text: 'LOGIN',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'dont\'t have an account?',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, RegisterPage.id);
                          },
                          child: const Text(
                            '  Register',
                            style: TextStyle(
                              color: Color(0xffC7EDE6),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50,)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }
}