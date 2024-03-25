import 'dart:convert';

// import 'package:facetrack/parent/chat_with_authority.dart';
import 'package:aicctv/screens/Home.dart';
import 'package:aicctv/widgets/BottomNavigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

// import 'parent_home.dart';

void main() {
  runApp(const ViewOwnPost());
}

class ViewOwnPost extends StatelessWidget {
  const ViewOwnPost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const ViewSuspiciousActivity(),
    );
  }
}

class ViewSuspiciousActivity extends StatefulWidget {
  const ViewSuspiciousActivity({Key? key}) : super(key: key);

  @override
  State<ViewSuspiciousActivity> createState() => _ViewSuspiciousActivityState();
}

class _ViewSuspiciousActivityState extends State<ViewSuspiciousActivity> {
  _ViewSuspiciousActivityState() {
    ViewOwnPost();
  }

  List<String> id_ = <String>[];
  List<String> LOGIN_id_ = <String>[];
 // List<String> name_ = <String>[];
 // List<String> gender_ = <String>[];
 // List<String> details_ = <String>[];
  List<String> place_ = <String>[];
  //List<String> post_ = <String>[];
 // List<String> pin_ = <String>[];
 // List<String> dist_ = <String>[];
  List<String> photo_ = <String>[];
  List<String> date_ = <String>[];
  List<String> time_ = <String>[];
  //List<String> splace_ = <String>[];
// List<String> sphoto_ = <String>[];
  List<String> activity_ = <String>[];

  Future<void> ViewOwnPost() async {
    List<String> id = <String>[];
   // List<String> name = <String>[];
    List<String> place = <String>[];
   // List<String> post = <String>[];
   // List<String> pin = <String>[];
    //List<String> dist = <String>[];
    //List<String> details = <String>[];
    //List<String> gender = <String>[];
    List<String> photo = <String>[];
    List<String> date = <String>[];
    List<String> time = <String>[];
   // List<String> splace = <String>[];
   // List<String> sphoto = <String>[];
    List<String> activity = <String>[];
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();
      String url = '$urls/user_view_suspicious/';
      var data = await http.post(Uri.parse(url), body: {'lid': lid});
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];
      var arr = jsondata["data"];
      print(arr.length);
      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        date.add(arr[i]['date']);
        time.add(arr[i]['time']);

        place.add(arr[i]['place']);
        activity.add(arr[i]['activity']);

      //  name.add(arr[i]['name']);

        photo.add(sh.getString("img_url").toString() + arr[i]['photo']);
      }
      setState(() {
        id_ = id;
     //   name_ = name;
        place_ = place;
        date_ = date;
        time_ = time;
        // post_ = post;
        // pin_ = pin;
        // dist_ = dist;
        activity_ = activity;
        photo_ = photo;
      });
      print(statuss);
    } catch (e) {
      print("Error ------------------- " + e.toString());
      //there is error during converting file image to base64 encoding.
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(context,MaterialPageRoute(builder: (CONTEXT) => Homenav(),));
        return true;
      },
      child: Scaffold(
        backgroundColor: Color.fromARGB(250, 255, 255, 255),
        // Set the background color here
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home()),
              );
            },
          ),
          backgroundColor: Colors.white,
          title: Text("Suspecious Activity"),
        ),
        body: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: id_.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              onLongPress: () {
                print("long press" + index.toString());
              },
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: 8,
                    margin: EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 250,
                          width: 250,
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Image(
                              image: NetworkImage(photo_[index], scale: 2),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            "Date:   " + date_[index],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            "Time:   " + time_[index],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            "Place:   " + place_[index],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            "Activity:   " + activity_[index],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.black,
                            ),
                          ),
                        ),


                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Color.fromARGB(245, 12, 12, 35),
                            ),
                            onPressed: () async {
                              SharedPreferences sh =
                                  await SharedPreferences.getInstance();
                              String url = sh.getString('url').toString();

                              String lid = sh.getString('lid').toString();

                              String sid = id_[index].toString();
                              final urls = Uri.parse(
                                  '$url/forward_suspicious_activity_post/');
                              try {
                                final response = await http.post(urls, body: {
                                  'lid': lid,
                                  'cr': sid,
                                });
                                if (response.statusCode == 200) {
                                  String status =
                                      jsonDecode(response.body)['status'];
                                  if (status == 'ok') {
                                    Fluttertoast.showToast(
                                        msg: 'Forward Successfully');
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Home(),
                                      ),
                                    );
                                  } else {
                                    Fluttertoast.showToast(msg: 'Not Found');
                                  }
                                } else {
                                  Fluttertoast.showToast(msg: 'Eroor: sms not sented');
                                  _textMe();

                                }
                              } catch (e) {
                                Fluttertoast.showToast(msg: e.toString());
                              }
                              // },
                              // child: Text("Cancel"),
                            },
                            child: Text('Forward')),

                        // Padding(
                        //   padding: EdgeInsets.all(5),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       Text('Address: '),
                        //       Text(
                        //           '${place_[index] + "\n" + post_[index] + "\n" + pin_[index] + "\n" + dist_[index]}'),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

_textMe() async {
  // Define the phone number and message body
  const phoneNumber = '9400664484';
  const message = 'user want to report suspicious activity';

  // Define the URI for the SMS
  final uri = Uri(
    scheme: 'sms',
    path: phoneNumber,
    queryParameters: {'body': message},
  );

  try {
    // Attempt to launch the SMS application
    await launch(uri.toString());
  } catch (e) {
    // Handle errors that occur during the process
    print('Error launching SMS: $e');
  }
}