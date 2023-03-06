import 'package:flutter/material.dart';
import 'package:flutter_application_1/route.dart';

import 'home.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Login();
}

class _Login extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Stack(fit: StackFit.expand, children: <Widget>[
            Image.asset(
              'assets/back.jpg',
              fit: BoxFit.fill,
            ),
            Container(
                margin: EdgeInsets.all(15),
                alignment: Alignment.topRight,
                child: IconButton(
                    onPressed: () {
                      setState(() {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: Text(
                                    'username must contain "@" , ".",  \n password must be more than 6 characters'),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.0))),
                              );
                            });
                      });
                    },
                    icon: Icon(Icons.warning))),
            Center(
              child: SingleChildScrollView(
                reverse: true,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 80,
                        width: 80,
                        margin: EdgeInsets.all(15.0),
                        child: Image.asset(
                          'assets/user.png',
                          color: Color.fromARGB(255, 1, 78, 140),
                          filterQuality: FilterQuality.high,
                        ),
                      ),
                      Text('Login',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Color.fromARGB(255, 1, 78, 140))),
                      SizedBox(height: 20),
                      TextFormField(
                          validator: (String? input) {
                            if ((input == null || input.isEmpty)) {
                              return 'please enter your username';
                            }
                            if (!(input.contains('.') && input.contains('@'))) {
                              return 'must contain "." and "@"';
                            } else {
                              return null;
                            }
                          },
                          controller: emailController,
                          decoration: InputDecoration(
                              labelText: "Enter user name",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              prefixIcon: Icon(Icons.email_sharp))),
                      SizedBox(height: 15),
                      TextFormField(
                        obscureText: !visible,
                        controller: passwordController,
                        validator: (String? input) {
                          if (input!.length < 6) {
                            return 'password must be more than 6 characters';
                          }
                        },
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  visible = !visible;
                                });
                              },
                            ),
                            prefixIcon: Icon(Icons.keyboard),
                            labelText: "Enter password",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                      SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
                              shape: StadiumBorder(),
                              backgroundColor: Color.fromARGB(255, 1, 78, 140)),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Navigator.pushReplacement(context, createRoute());
                            }
                          },
                          child: Text(
                            'Submit',
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
