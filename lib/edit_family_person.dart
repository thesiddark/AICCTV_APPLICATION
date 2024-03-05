import 'dart:convert';
import 'dart:io';

import 'package:aicctv/screens/Home.dart';
import 'package:aicctv/view_family_person.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Complaints',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyEditFamilyPerson(title: 'complaints'),
    );
  }
}

class MyEditFamilyPerson extends StatefulWidget {
  const MyEditFamilyPerson({super.key, required this.title});

  final String title;

  @override
  State<MyEditFamilyPerson> createState() => _MyEditFamilyPersonState();
}

class _MyEditFamilyPersonState extends State<MyEditFamilyPerson> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController Emailcontroller = TextEditingController();
  TextEditingController Phonecontroller = TextEditingController();
  TextEditingController placecontroller = TextEditingController();
  String photos = '';
  TextEditingController relationcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  _MyEditFamilyPersonState() {
    _get_data();
  }

  void _get_data() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();
    String fid = sh.getString('fid').toString();

    final urls = Uri.parse('$url/user_edit_profile_get/');
    try {
      final response = await http.post(urls, body: {
        'lid': lid,
        'fid': fid,
      });
      // print(jsonDecode(response.body)['city']);

      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          String name = jsonDecode(response.body)['name'].toString();
          String place = jsonDecode(response.body)['place'].toString();
          String email = jsonDecode(response.body)['email'].toString();
          String phone = jsonDecode(response.body)['phone'].toString();
          String relation = jsonDecode(response.body)['relation'].toString();
          String photo = sh.getString("img_url").toString() +
              jsonDecode(response.body)['photo'];

          setState(() {
            namecontroller.text = name;
            Emailcontroller.text = email;
            Phonecontroller.text = phone;
            relationcontroller.text = relation;
            placecontroller.text = place;
            photos = photo;

            // intrest = type;
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
        backgroundColor: Color.fromARGB(240, 110, 132, 147),

        // appBar: AppBar(
        //
        //   backgroundColor: Colors.brown,
        //   foregroundColor: Colors.orange[700],
        //
        //   title: Text(widget.title),
        // ),
        body: SingleChildScrollView(
          child: Container(
            decoration:  BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage('photos'), fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(20.0),
            ),
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    if (_selectedImage != null) ...{
                      InkWell(
                        child: Image.file(
                          _selectedImage!,
                          height: 400,
                        ),
                        radius: 399,
                        onTap: _checkPermissionAndChooseImage,
                        // borderRadius: BorderRadius.all(Radius.circular(200)),
                      ),
                    } else ...{
                      // Image(image: NetworkImage(),height: 100, width: 70,fit: BoxFit.cover,),
                      InkWell(
                        onTap: _checkPermissionAndChooseImage,
                        child: Column(
                          children: [
                            Image(
                              image: NetworkImage(photos),
                              height: 200,
                              width: 200,
                            ),
                            Text('Select Image',
                                style: TextStyle(color: Colors.cyan))
                          ],
                        ),
                      ),
                    },
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        validator: (value) => Validatecomplaints(value!),
                        controller: namecontroller,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Name',
                          fillColor: Colors.grey.shade300,
                          filled: true,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        validator: (value) => Validatecomplaints(value!),
                        controller: relationcontroller,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Relation',
                          fillColor: Colors.grey.shade300,
                          filled: true,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        validator: (value) => Validatecomplaints(value!),
                        controller: placecontroller,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Place',
                          fillColor: Colors.grey.shade300,
                          filled: true,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        validator: (value) => Validatecomplaints(value!),
                        controller: Emailcontroller,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                          fillColor: Colors.grey.shade300,
                          filled: true,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        // validator: (value) => Validatecomplaints(value!),
                        validator: (v){
                          if(v!.isEmpty ||
                              !RegExp(r"^[6789][0-9]{9}")
                                  .hasMatch(v)) {

                            return 'enter valid number';
                          }

                          return null;
                        },

                        controller: Phonecontroller,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Phone',
                          fillColor: Colors.grey.shade300,
                          filled: true,

                        ),
                      ),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            sendata();
                          }
                        },
                        child: Text('send'))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void sendata() async {
    String name = namecontroller.text;
    String place = placecontroller.text;
    String relation = relationcontroller.text;
    String email = Emailcontroller.text;
    String phone = Phonecontroller.text;

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();

    final urls = Uri.parse('$url/user_edit_family_members_post/');
    try {
      final response = await http.post(urls, body: {
        "photo": photo,
        'name': name,
        'relation': relation,
        'place': place,
        'email_id': email,
        'phone': phone,
        'lid': sh.getString("lid").toString(),
        'fid': sh.getString("fid").toString(),
      });
      print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        print(status);
        if (status == 'ok') {
          Fluttertoast.showToast(msg: ' Updated Service Successfully ');

          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Home(),
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

  String? Validatecomplaints(String value) {
    if (value.isEmpty) {
      return 'please enter your Name';
    }
    return null;
  }
  String? Validatephone(String value) {

    if (value == null || value.isEmpty) {
      return 'Please enter a phone number';
    }
    else if (value.length != 10) { // Assuming a 10-digit format
      return 'Please enter a valid 10-digit phone number';
    }
    return null;
  }

  File? _selectedImage;
  String? _encodedImage;

  Future<void> _chooseAndUploadImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
        _encodedImage = base64Encode(_selectedImage!.readAsBytesSync());
        photo = _encodedImage.toString();
      });
    }
  }

  Future<void> _checkPermissionAndChooseImage() async {
    final PermissionStatus status = await Permission.mediaLibrary.request();
    if (status.isGranted) {
      _chooseAndUploadImage();
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Permission Denied'),
          content: const Text(
            'Please go to app settings and grant permission to choose an image.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  String? Validatename(String value){
    if(value.isEmpty){
      return 'please enter your Name';
    }
    return null;
  }
  String? Validatedob(String value){
    if(value.isEmpty){
      return 'please enter your dob';
    }
    return null;
  }


    String? Validateplace(String value){
    if(value.isEmpty){
      return 'please enter your place';
    }
    return null;
  }String? Validatexperience(String value){
    if(value.isEmpty){
      return 'please enter your experience';
    }
    return null;
  }String? Validatequalification(String value){
    if(value.isEmpty){
      return 'please enter your qualification';
    }
    return null;
  }
  String? Validatecity(String value){
    if(value.isEmpty){
      return 'please enter your district';
    }
    return null;
  }
  String? Validatestate(String value){
    if(value.isEmpty){
      return 'please enter your state';
    }
    return null;
  }
  String? Validatepassword(String value){
    if(value.isEmpty){
      return 'please enter your password';
    }
    return null;
  }
  String? Validateconfirmpswd(String value){
    if(value.isEmpty){
      return 'please  enter password again to confirm password';
    }
    return null;
  }
  String? Validatemail(String value){
    if(value.isEmpty){
      return 'please enter Email';
    }
    return null;
  }


  String photo = '';
}
