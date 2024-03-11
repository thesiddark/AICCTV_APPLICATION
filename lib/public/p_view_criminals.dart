import 'dart:convert';

// import 'package:facetrack/parent/chat_with_authority.dart';
import 'package:aicctv/public/public_home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

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
      home: const PublicViewCriminals(),
    );
  }
}

class PublicViewCriminals extends StatefulWidget {
  const PublicViewCriminals({Key? key}) : super(key: key);

  @override
  State<PublicViewCriminals> createState() => _PublicViewCriminalsState();
}

class _PublicViewCriminalsState extends State<PublicViewCriminals> {
  _PublicViewCriminalsState() {
    ViewOwnPost();
  }

  List<String> id_ = <String>[];
  List<String> LOGIN_id_ = <String>[];
  List<String> name_ = <String>[];
  List<String> gender_ = <String>[];
  List<String> details_ = <String>[];
  List<String> place_ = <String>[];
  List<String> post_ = <String>[];
  List<String> pin_ = <String>[];
  List<String> dist_ = <String>[];
  List<String> photo_ = <String>[];
  List<String> station_ = <String>[];
  List<String> phno_ = <String>[];

  Future<void> ViewOwnPost() async {
    List<String> id = <String>[];
    List<String> name = <String>[];
    List<String> place = <String>[];
    List<String> post = <String>[];
    List<String> pin = <String>[];
    List<String> station = <String>[];
    List<String> details = <String>[];
    List<String> gender = <String>[];
    List<String> photo = <String>[];
    List<String> phno = <String>[];

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();
      String url = '$urls/user_view_criminals/';
      var data = await http.post(Uri.parse(url), body: {'lid': lid});
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];
      var arr = jsondata["data"];
      print(arr.length);
      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        name.add(arr[i]['name']);
        phno.add(arr[i]['phno'].toString());
        place.add(arr[i]['place']);
        gender.add(arr[i]['gender']);
        station.add(arr[i]['station']);
        details.add(arr[i]['details']);
        photo.add(sh.getString("img_url").toString() + arr[i]['photo']);
      }
      setState(() {
        id_ = id;
        name_ = name;
        place_ = place;
        gender_ = gender;
        // post_ = post;
        // pin_ = pin;
        phno_ = phno;
        station_=station;
        details_ = details;
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
                MaterialPageRoute(
                    builder: (context) => PublicMyHomePage(title: "")),
              );
            },
          ),
          backgroundColor: Color.fromARGB(250, 30, 90, 105),
          title: Text("Criminals"),
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
                            "Name:   " + name_[index],
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
                            "Gender:   " + gender_[index],
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
                            "Station:   " + station_[index] +"\nContact no: "+ phno_[index],
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
                            "Details:   " + details_[index],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
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
