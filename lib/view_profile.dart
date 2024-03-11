import 'dart:convert';
import 'package:aicctv/edit_profile_design.dart';
import 'package:aicctv/screens/Home.dart';
import 'package:aicctv/widgets/BottomNavigation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

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
      home: const MyViewProfilePage(title: ''),
    );
  }
}

class MyViewProfilePage extends StatefulWidget {
  const MyViewProfilePage({super.key, required this.title});

  final String title;

  @override
  State<MyViewProfilePage> createState() => _MyViewProfilePageState();
}

class _MyViewProfilePageState extends State<MyViewProfilePage> {
  _MyViewProfilePageState() {
    _send_data();
  }

  String name_ = "name";
  String email_ = "e_mail";
  String phone_ = "phone";
  String place_ = "place";
  String post_ = "place";
  String district_ = "district";
  String pincode_ = "pincode";
  String gender_ = "gender";

  String photo_ = "image";

  void _send_data() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/and_viewprofile/');
    try {
      final response = await http.post(urls, body: {
        'lid': lid,
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          String name = jsonDecode(response.body)['name'];
          String email = jsonDecode(response.body)['email'];
          String gender = jsonDecode(response.body)['gender'];
          String post = jsonDecode(response.body)['post'];

          String phone = jsonDecode(response.body)['phone'].toString();
          String place = jsonDecode(response.body)['place'];
          String district = jsonDecode(response.body)['district'];
          String image = sh.getString("img_url").toString() +
              jsonDecode(response.body)['photo'];
          String pincode = jsonDecode(response.body)['pin'].toString();

          setState(() {
            name_ = name;
            email_ = email;
            phone_ = phone;
            place_ = place;

            district_ = district;
            pincode_ = pincode;
            gender_ = gender;
            post_ = post;

            photo_ = image;
          });
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

  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
        onWillPop: () async {
      Navigator.push(context,MaterialPageRoute(builder: (CONTEXT) => Homenav(),));
      return true;
    },
    child: Scaffold(
      backgroundColor: Color.fromARGB(255, 228, 213, 231),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SizedBox(
              height: 280,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(29), // Adjust the radius as needed
                child: Image.network(
                  photo_,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(16.0, 240.0, 16.0, 16.0),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.all(16.0),
                        margin: EdgeInsets.only(top: 16.0),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(126, 9, 34, 37),
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                margin: const EdgeInsets.only(left: 110.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 20.0),
                                        Text(
                                          "  " + name_,
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                  ],
                                )),
                            SizedBox(height: 10.0),
                          ],
                        ),
                      ),
                      Container(
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            image: DecorationImage(
                                image: NetworkImage(photo_),
                                fit: BoxFit.cover)),
                        margin: EdgeInsets.only(left: 20.0),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(126, 9, 34, 37),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'PROFILE',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25.0,
                                color: Colors.white,
                              ),
                            ),
                            IconButton(
                                onPressed: () async {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            MyEditPage(title: ""),
                                      ));
                                },
                                icon: Icon(Icons.edit)),
                          ],
                        ),
                        Divider(),
                        ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Gender:',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                gender_,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(),
                        ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Email:',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "  " + email_,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(),
                        ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Phone:',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                phone_,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Address:',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Place    : " +
                                    place_ +
                                    ",\nPost       : " +
                                    post_ +
                                    ",\nDistrict : " +
                                    district_ +
                                    ", \nPIN      : " +
                                    pincode_,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(),
                        SizedBox(
                          height: 10,
                        ),
                        // ListTile(
                        //     title: Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Text(
                        //       'Dob:',
                        //       textAlign: TextAlign.start,
                        //       style: TextStyle(
                        //         fontWeight: FontWeight.bold,
                        //         fontSize: 15.0,
                        //         color: Colors.white,
                        //       ),
                        //     ),
                        //     // Text(
                        //     //   dob_,
                        //     //   textAlign: TextAlign.start,
                        //     //   style: TextStyle(
                        //     //     fontSize: 15.0,
                        //     //     color: Colors.white,
                        //     //   ),
                        //     // ),
                        //   ],
                        // )),
                        // Divider(),
                        SizedBox(
                          height: 10,
                        ),
                        // Divider(),
                        // SizedBox(
                        //   height: 10,
                        // ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ),
        );
  }

  void get_data() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/and_viewprofile/');
    try {
      final response = await http.post(urls, body: {
        'lid': lid,
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          String lid = jsonDecode(response.body)['lid'];
          sh.setString("lid", lid);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Home(),
              ));
        } else {
          Fluttertoast.showToast(msg: 'Not Found');
        }
      } else {
        Fluttertoast.showToast(msg: 'Network Error.Please try again');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
