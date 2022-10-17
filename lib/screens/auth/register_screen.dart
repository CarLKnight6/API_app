import 'package:api_app/Repositories/auth_repository.dart';
import 'package:api_app/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import '../../widgets/auth_textfield_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  void initState() {
    super.initState();
  }

  final _regformKey = GlobalKey<FormState>();

  final regemailcontroller = TextEditingController();

  final regpasswordcontroller = TextEditingController();
  final regconfirmpasswordcontroller = TextEditingController();

  var namecontroller = TextEditingController();
  var donetext = 'done';
  bool _isProcessing = false;

  @override
  void dispose() {
    namecontroller.dispose();
    regemailcontroller.dispose();
    regpasswordcontroller.dispose();
    regconfirmpasswordcontroller.dispose();
    super.dispose();
  }

  void clearText() {
    regemailcontroller.clear();
    regpasswordcontroller.clear();
    regconfirmpasswordcontroller.clear();
    namecontroller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/loginscreen');
              },
              icon: const Icon(Icons.arrow_back),
            ),
            title: const Text('Create Account'),
            backgroundColor: Colors.transparent,
          ),
          body: Form(
            key: _regformKey,
            child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/bg1.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AuthTextFormField(
                      textController: namecontroller,
                      label: 'Name',
                    ),
                    AuthTextFormField(
                      isEmail: true,
                      textController: regemailcontroller,
                      emailController: regemailcontroller,
                      label: 'Email',
                    ),
                    AuthTextFormField(
                      isObscure: true,
                      textController: regpasswordcontroller,
                      label: 'Password',
                    ),
                    AuthTextFormField(
                      isObscure: true,
                      textController: regconfirmpasswordcontroller,
                      label: 'Confirm Password',
                      isConfirmPassword: true,
                      passwordController: regpasswordcontroller,
                    ),
                    SubmitButton(
                        label: 'Submit',
                        formKey: _regformKey,
                        isProcessing: _isProcessing,
                        onPressed: () {
                          if (_regformKey.currentState!.validate()) {
                            print('user is now registered');
                            AuthRepositories(context).RegisterOfuser(
                                namecontroller.text,
                                regemailcontroller.text,
                                regpasswordcontroller.text,
                                regconfirmpasswordcontroller.text);
                            Future.delayed(const Duration(seconds: 3))
                                .then((value) {
                              setState(() {
                                _isProcessing = true;
                              });
                            });
                          }
                        })
                  ],
                )),
          )),
      onWillPop: () async {
        return false;
      },
    );
  }
}
