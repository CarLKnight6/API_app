import 'package:api_app/Repositories/auth_repository.dart';
import 'package:api_app/widgets/auth_textfield_widget.dart';
import 'package:api_app/widgets/button.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _secureText = true;
  final logemailcontroller = TextEditingController();
  final logpasswordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final loginformKey = GlobalKey<FormState>();

    void clearText() {
      logemailcontroller.clear();
      logpasswordcontroller.clear();
    }

    @override
    void dispose() {
      logemailcontroller.dispose();
      logpasswordcontroller.dispose();
      super.dispose();
    }

    return WillPopScope(
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            centerTitle: true,
            title: const Text('login'),
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
          ),
          body: Form(
            key: loginformKey,
            child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/bg2.jpg"),
                      fit: BoxFit.cover),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AuthTextFormField(
                      textController: logemailcontroller,
                      label: 'Email',
                      prefixIcon: const Icon(Icons.person),
                    ),
                    AuthTextFormField(
                      textController: logpasswordcontroller,
                      label: 'Password',
                      prefixIcon: const Icon(Icons.lock),
                      isObscure: _secureText,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _secureText ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _secureText = !_secureText;
                          });
                        },
                      ),
                    ),
                    Button(
                      label: 'login',
                      // formKey: loginformKey,
                      onPressed: () async {
                        if (loginformKey.currentState!.validate()) {
                          AuthRepositories(context).LoginOfuser(
                              logemailcontroller.text,
                              logpasswordcontroller.text);
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Sucessfully Logged in')));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Check your credentials')));
                        }
                      },
                    ),
                    Button(
                      label: 'Register',
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                        clearText();
                      },
                    ),
                  ],
                )),
          ),
        ),
        onWillPop: () async {
          return false;
        });
  }
}
