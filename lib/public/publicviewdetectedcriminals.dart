import 'package:aicctv/constants.dart';
import 'package:aicctv/screens/Home.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;

// import 'package:intl/intl.dart';
// import 'package:readmore/readmore.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

// import 'constants.dart';

void main() {
  runApp(const ViewDetectedCriminals());
}

class ViewDetectedCriminals extends StatelessWidget {
  const ViewDetectedCriminals({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'View Detected Criminals',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const PublicViewDetectedCriminalsPage(
          title: 'View Detected Criminals'),
    );
  }
}

class PublicViewDetectedCriminalsPage extends StatefulWidget {
  const PublicViewDetectedCriminalsPage({super.key, required this.title});

  final String title;

  @override
  State<PublicViewDetectedCriminalsPage> createState() =>
      _PublicViewDetectedCriminalsPageState();
}

class _PublicViewDetectedCriminalsPageState
    extends State<PublicViewDetectedCriminalsPage> {
  _PublicViewDetectedCriminalsPageState() {
    ViewDetectedCriminals();
  }

  List<String> id_ = <String>[];
  List<String> photo_ = <String>[];
  List<String> cname_ = <String>[];
  List<String> date_ = <String>[];
  List<String> time_ = <String>[];

  Future<void> ViewDetectedCriminals() async {
    List<String> id = <String>[];
    List<String> photo = <String>[];
    List<String> cname = <String>[];
    List<String> date = <String>[];
    List<String> time = <String>[];

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String pid = sh.getString('did').toString();
      String url = '$urls/View_Detected_Criminal/';

      var data = await http.post(Uri.parse(url), body: {'pid': pid});
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        photo.add(sh.getString("img_url").toString() + arr[i]['photo']);
        cname.add(arr[i]['cname']);
        date.add(arr[i]['date']);
        time.add(arr[i]['time']);
      }

      setState(() {
        id_ = id;
        photo_ = photo;
        cname_ = cname;
        date_ = date;
        time_ = time;
      });

      print(statuss);
    } catch (e) {
      print("Error ------------------- " + e.toString());
      //there is error during converting file image to base64 encoding.
    }
  }

  Future<void> ViewDetectedCriminalssearch() async {
    List<String> id = <String>[];
    List<String> photo = <String>[];
    List<String> cname = <String>[];
    List<String> date = <String>[];
    List<String> time = <String>[];

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String pid = sh.getString('did').toString();
      String url = '$urls/View_Detected_Criminal_search/';

      var data = await http
          .post(Uri.parse(url), body: {'search': sh.getString("date")});
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        photo.add(urls + arr[i]['photo']);
        cname.add(arr[i]['cname']);
        date.add(arr[i]['date']);
        time.add(arr[i]['time']);
      }

      setState(() {
        id_ = id;
        photo_ = photo;
        cname_ = cname;
        date_ = date;
        time_ = time;
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
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Color.fromARGB(250, 30, 90, 105),
            elevation: 0.0,
            leadingWidth: 0.0,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey.shade300,
                  radius: 20.0,
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Home(),
                        ),
                      );
                    },
                    splashRadius: 1.0,
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      color: kDarkGreenColor,
                      size: 24.0,
                    ),
                  ),
                ),
                Text(
                  'Detections',
                  style: GoogleFonts.poppins(
                    color: kDarkGreenColor,
                    fontSize: 22.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  width: 40.0,
                  // child: IconButton(
                  //   onPressed: () async {
                  //     // Set an initial date
                  //     DateTime initialDate = DateTime.now();
                  //
                  //     // Open a date picker with the initial date
                  //     DateTime? pickedDate = await showDatePicker(
                  //       context: context,
                  //       initialDate: initialDate,
                  //       firstDate: DateTime(1900),
                  //       lastDate: DateTime.now(),
                  //     );
                  //
                  //     // Handle the selected date as needed
                  //     // if (pickedDate != null) {
                  //     //   String formattedDate =
                  //     //       // DateFormat('yyyy-MM-dd').format(pickedDate);
                  //     //   // print('Selected Date: ${formattedDate}');
                  //     //   final sh = await SharedPreferences.getInstance();
                  //     //   sh.setString("date", formattedDate);
                  //     //   ViewDetectedCriminalssearch();
                  //     //
                  //     //   Fluttertoast.showToast(msg: '${formattedDate}');
                  //     //   // You can perform actions with the selected date here
                  //     // }
                  //   },
                  //   splashRadius: 1.0,
                  //   icon: Icon(
                  //     Icons.calendar_month,
                  //     color: Colors.black,
                  //     size: 34.0,
                  //   ),
                  // ),
                ),
              ],
            ),
          ),
          body: a()),
    );
  }

  a() {
    if (id_.length == 0) {
      return Center(
          child: Image(
              image: NetworkImage(
                  'https://th.bing.com/th/id/OIP.i6ZcHiTqe9S1Dg9ppL7z-QAAAA?w=189&h=189&c=7&r=0&o=5&dpr=1.3&pid=1.7')));
    } else {
      return ListView.builder(
        physics: BouncingScrollPhysics(),
        // padding: EdgeInsets.all(5.0),
        // shrinkWrap: true,
        itemCount: id_.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            onLongPress: () {
              print("long press" + index.toString());
            },
            title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Card(
                      color: Colors.white,
                      elevation: 8,
                      margin: EdgeInsets.all(0),
                      // Adjust the margin as needed
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image(
                                image: NetworkImage(photo_[index]),
                                width: 100,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 16),
                            // Add some spacing between the image and text
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Criminal: " + cname_[index],
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  // Add spacing between text elements
                                  Text(
                                    "Date: " + date_[index],
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    "Time: " + time_[index],
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                )),
          );
        },
      );
    }
  }
}
