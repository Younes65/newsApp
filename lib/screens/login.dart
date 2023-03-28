import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/route.dart';
import 'package:flutter_application_1/utils/user_controller.dart';
import 'package:get/get.dart';
import 'home.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Login();
}

class _Login extends State<Login> {
  var c = Get.put(Controller());

  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    var mediaQery = MediaQuery.of(context);
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
                    color: Colors.red,
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
                          color: Colors.red,
                        ),
                      ),
                      Text('Login',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.red)),
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
                            prefixIcon: Icon(Icons.email_sharp),
                          )),
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
                              backgroundColor: Colors.red),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Navigator.pushReplacement(context, createRoute());
                              c.pushEmail(emailController.text);
                            }
                          },
                          child: Text(
                            'Submit',
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'OR',
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15)),
                            child: Image.asset(
                              'assets/Google.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                image: DecorationImage(
                                    image: AssetImage('assets/facebook.png'),
                                    fit: BoxFit.cover)),
                          ),
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    image: AssetImage('assets/link.png'),
                                    fit: BoxFit.cover)),
                          )
                        ],
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
