import 'dart:io';

import 'package:aicctv/view_profile.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart ';

import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyEdit());
}

class MyEdit extends StatelessWidget {
  const MyEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Edit Profile',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyEditPage(title: 'Edit Profile'),
    );
  }
}

class MyEditPage extends StatefulWidget {
  const MyEditPage({super.key, required this.title});

  final String title;

  @override
  State<MyEditPage> createState() => _MyEditPageState();
}

class _MyEditPageState extends State<MyEditPage> {
  _MyEditPageState() {
    _get_data();
  }

  String gender = "Male";

  TextEditingController namecontroller = TextEditingController();
  TextEditingController Emailcontroller = TextEditingController();
  TextEditingController Phonecontroller = TextEditingController();
  TextEditingController postcontroller = TextEditingController();
  TextEditingController placecontroller = TextEditingController();
  TextEditingController pincontroller = TextEditingController();

  TextEditingController districtcontroller = TextEditingController();

  String image = '';

  void _get_data() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/and_viewprofile/');
    try {
      final response = await http.post(urls, body: {'lid': lid});
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          String name = jsonDecode(response.body)['name'];
          String email = jsonDecode(response.body)['email'];
          String gender_ = jsonDecode(response.body)['gender'];
          String post = jsonDecode(response.body)['post'];

          String phone = jsonDecode(response.body)['phone'].toString();
          String place = jsonDecode(response.body)['place'];
          String district = jsonDecode(response.body)['district'];
          String image = sh.getString("img_url").toString() +
              jsonDecode(response.body)['photo'];
          String pincode = jsonDecode(response.body)['pin'].toString();

          namecontroller.text = name;
          Emailcontroller.text = email;
          Phonecontroller.text = phone;
          placecontroller.text = place;
          postcontroller.text = post;
          pincontroller.text = pincode;
          districtcontroller.text = district;

          setState(() {
            photo = image;
            gender = gender_;
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
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
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
                        image: NetworkImage(photo),
                        height: 200,
                        width: 200,
                      ),
                      Text('Select Image', style: TextStyle(color: Colors.cyan))
                    ],
                  ),
                ),
              },
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  controller: namecontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), label: Text("Name")),
                ),
              ),
              RadioListTile(
                value: "Male",
                groupValue: gender,
                onChanged: (value) {
                  setState(() {
                    gender = "Male";
                  });
                },
                title: Text("Male"),
              ),
              RadioListTile(
                value: "Female",
                groupValue: gender,
                onChanged: (value) {
                  setState(() {
                    gender = "Female";
                  });
                },
                title: Text("Female"),
              ),
              RadioListTile(
                value: "Other",
                groupValue: gender,
                onChanged: (value) {
                  setState(() {
                    gender = "Other";
                  });
                },
                title: Text("Other"),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  controller: Emailcontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), label: Text("Email")),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  controller: Phonecontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), label: Text("Phone")),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  controller: placecontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), label: Text("Place")),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  controller: postcontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), label: Text("Post")),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  controller: pincontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), label: Text("Pin")),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  controller: districtcontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), label: Text("District")),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _send_data();
                },
                child: Text("Update"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _send_data() async {
    String uname = namecontroller.text;
    String email = Emailcontroller.text;
    String phone = Phonecontroller.text;
    String place = placecontroller.text;
    String post = postcontroller.text;
    String pin = pincontroller.text;
    String district = districtcontroller.text;

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/user_edit_profile/');
    try {
      final response = await http.post(urls, body: {
        "photo": photo,
        'name': uname,
        'gender': gender,
        'email': email,
        'phone': phone,
        'place': place,
        'post': post,
        'pin': pin,
        'district': district,
        'lid': lid,
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          Fluttertoast.showToast(msg: 'Updated Successfully');
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyViewProfilePage(title: "Profile"),
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

  String photo = '';
}
