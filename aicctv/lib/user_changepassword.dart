import 'package:aicctv/screens/Home.dart';

import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;

import '../login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home:  (title: 'Sent Complaint'),
    );
  }
}

class MyUserChangePassword extends StatefulWidget {
  MyUserChangePassword({
    Key? key,
  }) : super(key: key);

  @override
  State<MyUserChangePassword> createState() => _LoginState();
}

class _LoginState extends State<MyUserChangePassword> {
  TextEditingController oldpasswordController = TextEditingController();
  TextEditingController newpasswordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Home(),
            ));

        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          // backgroundColor: Color.fromARGB(255, 18, 82, 98),

          title: Text("Change Password",
              style: TextStyle(
                  // color: Color.fromARGB(255, 255, 255, 255)
                  )),
        ),
        // backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        body: Form(
          key: _formkey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                TextFormField(
                  controller: oldpasswordController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelText: "Old Paaword",
                    prefixIcon: const Icon(Icons.password),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter Old Password.";
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: newpasswordController,
                  decoration: InputDecoration(
                    labelText: "New Password",
                    prefixIcon: const Icon(Icons.password),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (String? value) {
                    if (value == null || value.length < 8) {
                      return "Please enter New Password minimum 8digits.";
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: confirmpasswordController,
                  decoration: InputDecoration(
                    labelText: "Confirm Password",
                    prefixIcon: const Icon(Icons.password),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter Confirm.";
                    }

                    return null;
                  },
                ),
                SizedBox(height: 10),
                Column(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          submit();
                        }
                      },
                      child: const Text("SUBMIT"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  // void dispose() {
  //   _focusNodePassword.dispose();
  //   _controllerUsername.dispose();
  //   _controllerPassword.dispose();
  //   super.dispose();
  // }

  void submit() async {
    String old = oldpasswordController.text.toString();
    String newpass = newpasswordController.text.toString();
    String confirm = confirmpasswordController.text.toString();

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();
    String oldpassword = sh.getString('oldpassword').toString();

    if (oldpassword != old) {
      Fluttertoast.showToast(
          msg: 'Missmatch in old passwrod. Try again after login');

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginNewPage(),
          ));
    } else {
      final urls = Uri.parse(url + "/and_changepassword/");
      try {
        final response = await http.post(urls, body: {
          'currentpassword': old,
          'newpassword': newpass,
          'confirmpassword': confirm,
          'lid': lid,
        });
        if (response.statusCode == 200) {
          String status = jsonDecode(response.body)['status'];
          if (status == 'ok') {
            Fluttertoast.showToast(msg: ' Password Updated');

            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginNewPage(),
                ));
          } else {
            Fluttertoast.showToast(msg: 'Not Found');
          }
        } else {
          Fluttertoast.showToast(msg: 'Network Error');
        }
      } catch (e) {
        Fluttertoast.showToast(msg: e.toString());
      }
    }
  }

  String? conf(String value) {
    if (value.length < 8) {
      return 'Please enter a Old Password';
    }
    return null;
  }

  String? old(String value) {
    if (value.isEmpty) {
      return 'Please enter New Password';
    }
    return null;
  }

  String? new1(String value) {
    if (value.length < 10) {
      return 'Please Confirm Password';
    }
    return null;
  }
}
