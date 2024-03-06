import 'dart:io';

import 'package:aicctv/view_family_person.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

import 'login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Add Family',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyAddFamilyPerson(title: 'Add Family'),
    );
  }
}

class MyAddFamilyPerson extends StatefulWidget {
  const MyAddFamilyPerson({super.key, required this.title});

  final String title;

  @override
  State<MyAddFamilyPerson> createState() => _MyAddFamilyPersonState();
}

class _MyAddFamilyPersonState extends State<MyAddFamilyPerson> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController Emailcontroller = TextEditingController();
  TextEditingController Phonecontroller = TextEditingController();
  TextEditingController placecontroller = TextEditingController();
  TextEditingController relationcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child:Form(
            key: _formKey,
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_selectedImage != null) ...{
                    InkWell(
                      child: Image.file(
                        _selectedImage!,
                        height: 150,
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
                          // Image(
                          Image.asset(
                            'assets/images/profileselect.png',
                            height: 200,
                            width: 200,
                          ),
                          Text('Select Image',
                              style: TextStyle(color: Colors.red))
                        ],
                      ),
                    ),
                  },
                ],
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: TextFormField(
                  validator: (v){
                    if(v!.isEmpty){
                      return 'Please Enter Name';
                    }
                    return null;
                  },
                  controller: namecontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Name'),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty ||
                        !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value)) {
                      return 'Enter a valid Email!';
                    }
                    return null;
                  },
                  controller: Emailcontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Email'),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: TextFormField(
                  validator: (v){
                    if(v!.isEmpty ||
                        !RegExp(r"^[6789]\d{9}$")
                            .hasMatch(v)) {
                      return 'Enter valid number';
                    }
                    return null;
                  },
                  controller: Phonecontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Phone'),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: TextFormField(
                  validator: (v){
                    if(v!.isEmpty){
                      return 'Must enter valid Place';
                    }
                    return null;
                  },
                  controller: placecontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: 'place'),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: TextFormField(
                  validator: (v){
                    if(v!.isEmpty){
                      return 'Must enter Relation';
                    }
                    return null;
                  },
                  controller: relationcontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Relation'),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (_selectedImage == null) {
                      Fluttertoast.showToast(msg: 'Please select an image');
                    } else {
                      senddata();
                    }
                  }
                },
                child: Text('ADD'),
              )
            ],
          ),
        ),
      ),
    ));
  }

  void senddata() async {
    String name = namecontroller.text;
    String email = Emailcontroller.text;
    String phone = Phonecontroller.text;
    String place = placecontroller.text;
    String relation = relationcontroller.text;

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();

    final urls = Uri.parse('$url/user_add_family_members_post/');
    try {
      final response = await http.post(urls, body: {
        'name': name,
        'email': email,
        'phone': phone,
        'place': place,
        'photo': photo,
        'relation': relation,
        'lid': sh.getString("lid").toString(),
      });
      print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        print(status);
        if (status == 'ok') {
          Fluttertoast.showToast(msg: 'successfully Added');

          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyViewFamilyPerson(),
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

  String photo = '';
  File? uploadimage;
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
}
