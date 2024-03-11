import 'dart:convert';

import 'package:aicctv/public/public_home.dart';
import 'package:aicctv/screens/Home.dart';

import 'package:aicctv/widgets/BottomNavigation.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const Send_suggestions());
}

class Send_suggestions extends StatelessWidget {
  const Send_suggestions({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Send report',
      theme: ThemeData(
        colorScheme:
        ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 18, 82, 98)),
        useMaterial3: true,
      ),
      home: const publicreport(title: 'View Reply'),
    );
  }
}

class publicreport extends StatefulWidget {
  const publicreport({super.key, required this.title});

  final String title;

  @override
  State<publicreport> createState() => _publicreportState();
}

class _publicreportState extends State<publicreport> {
  TextEditingController reportcontroller = new TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PublicMyHomePage(title:' title'),
            ));

        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor:  Color.fromARGB(250, 30, 90, 105),
          title: Text(widget.title),
        ),
        body: Form(
          key: _formkey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[Center(
                child: SizedBox(
                width: 160, // Adjust width as needed
                height: 160, // Adjust height as needed
               child: ClipOval(
                child: Image.asset(
                  "assets/images/security.png",
                  fit: BoxFit.cover,
                  // Adjust the BoxFit as needed
                ),
              ),
            )),
                Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text('You can report information completely anonymous',
                    )),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextFormField(
                    maxLines: 4,
                    controller: reportcontroller,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter report.";
                      }

                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Center(
                    child:ElevatedButton(
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          sendcompliant();
                        }
                      },
                      child: Text('Report Now'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      )),
                ))
              ],
            ),
          ),
        ),
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

  void sendcompliant() async {
    String compliant = reportcontroller.text.toString();

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    final urls = Uri.parse(url + "/send_report/");
    try {
      final response = await http.post(urls, body: {
        'report': compliant,
        
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          Fluttertoast.showToast(msg: 'report Registered');

          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PublicMyHomePage(title: '',
                ),
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

  String? validatereport(String value) {
    if (value.isEmpty) {
      return 'Please enter a report';
    }
    return null;
  }
}
