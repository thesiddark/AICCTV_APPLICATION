import 'dart:convert';

import 'package:aicctv/chat_with_police.dart';
import 'package:aicctv/screens/Home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

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
      home: const ViewPoliceStation(),
    );
  }
}

class ViewPoliceStation extends StatefulWidget {
  const ViewPoliceStation({Key? key}) : super(key: key);

  @override
  State<ViewPoliceStation> createState() => _ViewPoliceStationState();
}

class _ViewPoliceStationState extends State<ViewPoliceStation> {
  _ViewPoliceStationState() {
    ViewOwnPost();
  }

  List<String> id_ = <String>[];
  List<String> LOGIN_id_ = <String>[];
  List<String> siname_ = <String>[];
  List<String> stationname_ = <String>[];
  List<String> email_ = <String>[];
  List<String> phone_ = <String>[];
  List<String> place_ = <String>[];
  List<String> post_ = <String>[];
  List<String> pin_ = <String>[];
  List<String> dist_ = <String>[];

  Future<void> ViewOwnPost() async {
    List<String> id = <String>[];
    List<String> LOGIN_id = <String>[];
    List<String> siname = <String>[];
    List<String> stationname = <String>[];
    List<String> email = <String>[];
    List<String> phone = <String>[];
    List<String> place = <String>[];
    List<String> post = <String>[];
    List<String> pin = <String>[];
    List<String> dist = <String>[];

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();
      String url = '$urls/user_view_policestation/';
      var data = await http.post(Uri.parse(url), body: {'lid': lid});
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];
      var arr = jsondata["data"];
      print(arr.length);
      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        LOGIN_id.add(arr[i]['LOGIN_id'].toString());

        siname.add(arr[i]['SI_name']);
        stationname.add(arr[i]['station_name']);
        email.add(arr[i]['email_id']);
        phone.add(arr[i]['phone'].toString());
        place.add(arr[i]['place']);
        pin.add(arr[i]['pin'].toString());
        post.add(arr[i]['post']);
        dist.add(arr[i]['district']);
      }
      setState(() {
        id_ = id;
        LOGIN_id_ = LOGIN_id;
        siname_ = siname;
        stationname_ = stationname;
        email_ = email;
        phone_ = phone;
        place_ = place;
        post_ = post;
        pin_ = pin;
        dist_ = dist;
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
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text("Authority"),
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
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            "Station Name:   " + stationname_[index],
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
                            "SI Name:   " + siname_[index],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Address: '),
                              Text(
                                  '${place_[index] + "\n" + post_[index] + "\n" + dist_[index] + "\n" + pin_[index]}'),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            "Email:   " + email_[index],
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
                            "Phone:   " + phone_[index],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            SharedPreferences sh =
                                await SharedPreferences.getInstance();
                            sh.setString("did", LOGIN_id_[index]);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyChatPage(title: ""),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueGrey, // Set your desired background color here
                          ),
                          child: Text('Chat'),
                        ),
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
