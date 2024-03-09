import 'package:aicctv/public/p_view_criminals.dart';
import 'package:aicctv/public/viewdetectedcriminals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
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
        title: Text(widget.title),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/akfor.png'), fit: BoxFit.cover),
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
                        child: Text("Criminals",
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
                                PublicViewDetectedCriminalsPage(
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
          ],
        ),
      ),

      // drawer: Drawer(
      //   child: ListView(
      //     padding: EdgeInsets.zero,
      //     children: [
      //       DrawerHeader(
      //         decoration: BoxDecoration(
      //           color:  Color.fromARGB(195, 29, 155, 187),
      //
      //
      //         ),
      //         child:
      //         Column(children: [
      //
      //           Text(
      //             'Nss Management',
      //             style: TextStyle(fontSize: 20,color: Colors.grey[200]),
      //           ),
      //           // CircleAvatar(radius: 50,backgroundImage: AssetImage('assets/images/nss.jpeg')),
      //
      //
      //
      //
      //         ])
      //
      //
      //         ,
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.home),
      //         title: const Text('Home'),
      //         onTap: () {
      //           Navigator.pop(context);
      //           Navigator.push(context, MaterialPageRoute(builder: (context) => PublicMyHomePage(title: "",),));
      //         },
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.event),
      //         title: const Text(' Events '),
      //         onTap: () {
      //           Navigator.pop(context);
      //           Navigator.push(context, MaterialPageRoute(builder: (context) => StudentViewEvents(),));
      //         },
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.notifications_active),
      //         title: const Text(" Join Notification "),
      //         onTap: () {
      //           Navigator.pop(context);
      //           Navigator.push(context, MaterialPageRoute(builder: (context) => StudentViewNotification(),));
      //         },
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.quickreply_sharp),
      //         title: const Text(' Feedback '),
      //         onTap: () {
      //           Navigator.pop(context);
      //           Navigator.push(context, MaterialPageRoute(builder: (context) => MySendFeedback(title: " ",),));
      //         },
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.task_alt),
      //         title: const Text(' Selection Task '),
      //         onTap: () {
      //           Navigator.pop(context);
      //           Navigator.push(context, MaterialPageRoute(builder: (context) => StudentViewSelectionTask(),));
      //         },
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.request_page),
      //         title: const Text(' View Status '),
      //         onTap: () {
      //           Navigator.pop(context);
      //           Navigator.push(context, MaterialPageRoute(builder: (context) => StudentViewRequestStatus(),));
      //         },
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.password),
      //         title: const Text(' Change Password '),
      //         onTap: () {
      //           Navigator.pop(context);
      //           Navigator.push(context, MaterialPageRoute(builder: (context) => MyStudentChangePassword(title: "",),));
      //         },
      //       ),
      //
      //
      //       ListTile(
      //         leading: Icon(Icons.logout),
      //         title: const Text('LogOut'),
      //         onTap: () {Navigator.push(context, MaterialPageRoute(
      //           builder: (context) => LoginPage(title: ""),));
      //
      //           // Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
      //         },
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
