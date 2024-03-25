import 'package:aicctv/public/p_view_criminals.dart';
import 'package:aicctv/public/publicreport.dart';
import 'package:aicctv/public/publicviewdetectedcriminals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';




import '../login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:
          '                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            ',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const PublicMyHomePage(title: ''),
    );
  }
}

class PublicMyHomePage extends StatefulWidget {
  const PublicMyHomePage({super.key, required this.title});

  final String title;

  @override
  State<PublicMyHomePage> createState() => _PublicMyHomePageState();
}

class _PublicMyHomePageState extends State<PublicMyHomePage> {
  TextEditingController ipcontroller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
      Navigator.push(context,MaterialPageRoute(builder: (CONTEXT) => LoginNewPage(),));
      return true;
    },
    child: Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            color: Colors.white,
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginNewPage(),
                  ));
            },
          ),
        ],
        backgroundColor: Color.fromARGB(250, 30, 90, 105),
        title: Text("PUBLIC SERVICE"),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/akfor.png'), fit: BoxFit.cover,opacity: 0.2),
        ),
        child: GridView(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 210,
            childAspectRatio: 10 / 10,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          padding: const EdgeInsets.all(8.0),
          children: [
            Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Color.fromARGB(207, 28, 62, 100),
                    borderRadius: BorderRadius.circular(15)),
                child: Column(children: [
                  SizedBox(height: 5.0),
                  InkWell(
                    child: CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                            'https://as2.ftcdn.net/v2/jpg/01/14/77/21/1000_F_114772155_D1FhGamh4Am9PMQyIZkF1DFFyh0DtmTx.jpg')),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PublicViewCriminals(),
                          ));
                    },
                  ),
                  SizedBox(height: 5.0),
                  // CircleAvatar(radius: 50,backgroundImage: NetworkImage(photo_[index])),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(1),
                        child: Text("Criminals \n(WANTED)",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ],
                  ),
                ])),
            Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Color.fromARGB(207, 28, 62, 100),
                    borderRadius: BorderRadius.circular(15)),
                child: Column(children: [
                  SizedBox(height: 5.0),
                  InkWell(
                    child: CircleAvatar(
                        radius: 50,backgroundColor: Colors.white,
                        backgroundImage: AssetImage("assets/images/face-detection.png")),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PublicViewDetectedCriminalsPage(
                          title: '',
                          )));
                    },
                  ),
                  SizedBox(height: 5.0),
                  // CircleAvatar(radius: 50,backgroundImage: NetworkImage(photo_[index])),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(1),
                        child: Text("Detected Criminals",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ],
                  ),
                ])),

            Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Color.fromARGB(207, 28, 62, 100),
                    borderRadius: BorderRadius.circular(15)),
                child: Column(children: [
                  SizedBox(height: 5.0),
                  InkWell(
                    child: CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                            'https://t4.ftcdn.net/jpg/04/59/11/63/240_F_459116369_eG4lArF5CWbXCjgQlbugFcbaz4eXgSAs.jpg')),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                publicreport(
                              title: '',
                            ),
                          ));
                    },
                  ),
                  SizedBox(height: 5.0),
                  // CircleAvatar(radius: 50,backgroundImage: NetworkImage(photo_[index])),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(1),
                        child: Text("Send Report",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            )),
                      ),

                    ],
                  ),
                ])),
            Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Color.fromARGB(207, 28, 62, 100),
                    borderRadius: BorderRadius.circular(15)),
                child: Column(children: [
                  SizedBox(height: 5.0),
                  InkWell(
                    child: CircleAvatar(
                        radius: 50,backgroundColor: Colors.white,
                        backgroundImage: AssetImage("assets/images/emergency-call.png")),
                    onTap: () {
                //      _makePhoneCall('1234567890');
                //      _sendSMS('+919400664484', 'Hello from Flutter!');
                //      sendSMS();
                      _makePhoneCall('112');
                    },
                  ),
                  SizedBox(height: 5.0),
                  // CircleAvatar(radius: 50,backgroundImage: NetworkImage(photo_[index])),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(1),
                        child: Text("Emergency",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ],
                  ),
                ])),
          ],
        ),
      ),

    ));
  }
}
void _makePhoneCall(String phoneNumber) async {
  String url = 'tel:$phoneNumber';
  try {
    await launch(url);
  } catch (e) {
    print('Error launching phone call: $e');
  }
}








