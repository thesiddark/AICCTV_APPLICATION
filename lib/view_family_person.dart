import 'dart:convert';

import 'package:aicctv/add_family_person.dart';
import 'package:aicctv/edit_family_person.dart';
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
      title: 'Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: const MyViewFamilyPerson(),
    );
  }
}

class MyViewFamilyPerson extends StatefulWidget {
  const MyViewFamilyPerson({Key? key}) : super(key: key);

  @override
  State<MyViewFamilyPerson> createState() => _MyViewFamilyPersonState();
}

class _MyViewFamilyPersonState extends State<MyViewFamilyPerson> {
  _MyViewFamilyPersonState() {
    ViewOwnPost();
  }

  List<String> id_ = <String>[];
  List<String> name_ = <String>[];
  List<String> email_ = <String>[];
  List<String> phone_ = <String>[];
  List<String> place_ = <String>[];

  List<String> relation_ = <String>[];
  List<String> photo_ = <String>[];

  Future<void> ViewOwnPost() async {
    List<String> id = <String>[];
    List<String> name = <String>[];
    List<String> email = <String>[];
    List<String> phone = <String>[];
    List<String> place = <String>[];

    List<String> relation = <String>[];
    List<String> photo = <String>[];
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();
      String url = '$urls/user_view_family_members/';
      var data = await http.post(Uri.parse(url), body: {'lid': lid});
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];
      var arr = jsondata["data"];
      print(arr.length);
      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        name.add(arr[i]['name']);
        email.add(arr[i]['email']);
        phone.add(arr[i]['phone'].toString());
        place.add(arr[i]['place']);

        relation.add(arr[i]['relation']);
        photo.add(sh.getString("img_url").toString() + arr[i]['photo']);
      }
      setState(() {
        id_ = id;
        name_ = name;
        email_ = email;
        phone_ = phone;
        place_ = place;

        relation_ = relation;
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
        backgroundColor: Color.fromARGB(250, 235, 236, 236),
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
          title: Text("Family Members"),
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
                        borderRadius: BorderRadius.circular(20),
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
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                child: Image(
                                  image: NetworkImage(photo_[index], scale: 2),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Name"),
                                Text(name_[index]),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Relation"),
                                Text(relation_[index]),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Place"),
                                Text(place_[index]),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Email"),
                                Text(email_[index]),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Mobile"),
                                Text(phone_[index]),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor:
                                        Color.fromARGB(245, 12, 12, 35),
                                  ),
                                  onPressed: () async {
                                    SharedPreferences sh =
                                        await SharedPreferences.getInstance();
                                    sh.setString("fid", id_[index]);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              MyEditFamilyPerson(
                                            title: "",
                                          ),
                                        ));
                                  },
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.blue,
                                    size: 24.0,
                                    semanticLabel: 'edit',
                                  ),),
                              SizedBox(
                                width: 150,
                              ),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor:
                                        Color.fromARGB(245, 12, 12, 35),
                                  ),
                                  onPressed: () async {
                                    SharedPreferences sh =
                                        await SharedPreferences.getInstance();
                                    String url = sh.getString('url').toString();
                                    String lid = sh.getString('lid').toString();
                                    String sid = id_[index].toString();
                                    final urls =
                                        Uri.parse('$url/delete_family_person/');
                                    try {
                                      final response =
                                          await http.post(urls, body: {
                                        'lid': lid,
                                        'sid': sid,
                                      });
                                      if (response.statusCode == 200) {
                                        String status =
                                            jsonDecode(response.body)['status'];
                                        if (status == 'ok') {
                                          Fluttertoast.showToast(
                                              msg: 'Deleted Successfully');
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  MyViewFamilyPerson(),
                                            ),
                                          );
                                        } else {
                                          Fluttertoast.showToast(
                                              msg: 'Not Found');
                                        }
                                      } else {
                                        Fluttertoast.showToast(
                                            msg: 'Network Error');
                                      }
                                    } catch (e) {
                                      Fluttertoast.showToast(msg: e.toString());
                                    }
                                    // },
                                    // child: Text("Cancel"),
                                  },
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.blue,
                                    size: 24.0,
                                    semanticLabel: 'edit',
                                  ),),
                            ],
                          )
                        ],
                      ),
                    ),

                    // margin: EdgeInsets.all(10),
                  ),
                ));
          },
        ),

        floatingActionButton: FloatingActionButton.large(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MyAddFamilyPerson(title: 'home')));
          },
          child: Icon(Icons.person_add_alt,size: 60,),
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
        ),
      ),
    );
  }
}
