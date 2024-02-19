import 'dart:io';

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
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyUsersignupPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyUsersignupPage extends StatefulWidget {
  const MyUsersignupPage({super.key, required this.title});

  final String title;

  @override
  State<MyUsersignupPage> createState() => _MyUsersignupPageState();
}

class _MyUsersignupPageState extends State<MyUsersignupPage> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController Emailcontroller = TextEditingController();
  TextEditingController Phonecontroller = TextEditingController();
  TextEditingController postcontroller = TextEditingController();
  TextEditingController placecontroller = TextEditingController();
  TextEditingController pincontroller = TextEditingController();

  TextEditingController districtcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController confirmpasswordcontroller = TextEditingController();
  String gender = "Male";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Center(
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
                          Image.network(
                            "https://previews.123rf.com/images/faysalfarhan/faysalfarhan1710/faysalfarhan171019745/89052310-t%C3%A9l%C3%A9charger-l-ic%C3%B4ne-du-document-isol%C3%A9-sur-le-bouton-sp%C3%A9cial-vert-abstrait-illustration.jpg",
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
                child: TextField(
                  controller: namecontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: 'name'),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.all(7),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      " Gender ",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                      ),
                    ),
                    Radio(
                        activeColor: Colors.green,
                        value: "Male",
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = "Male";
                          });
                        }),
                    Text(
                      "Male",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Radio(
                        activeColor: Colors.green,
                        value: "Female",
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = "Female";
                          });
                        }),
                    Text(
                      "Female",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Radio(
                        activeColor: Colors.green,
                        value: "Others",
                        groupValue: gender,
                        // onChanged: (String? value) {
                        //   gender = "Others";
                        onChanged: (value) {
                          setState(() {
                            gender = "Others";
                          });
                        }),
                    Text(
                      "Others",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: TextField(
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
                child: TextField(
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
                child: TextField(
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
                child: TextField(
                  controller: postcontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Post'),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: TextField(
                  controller: pincontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Pin'),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: TextField(
                  controller: districtcontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: 'district'),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: TextField(
                  controller: passwordcontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Password'),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: TextField(
                  controller: confirmpasswordcontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Confirm password'),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  senddata();
                },
                child: Text('Signup'),
              )
            ],
          ),
        ),
      ),
    );
  }

  void senddata() async {
    String name = namecontroller.text;
    String email = Emailcontroller.text;
    String phone = Phonecontroller.text;
    String place = placecontroller.text;
    String post = postcontroller.text;
    String pin = pincontroller.text;
    String district = districtcontroller.text;
    String password = passwordcontroller.text;
    String confirmpassword = confirmpasswordcontroller.text;
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();

    final urls = Uri.parse('$url/user_signup/');
    try {
      final response = await http.post(urls, body: {
        'name': name,
        'email': email,
        'phone': phone,
        'gender': gender,
        'place': place,
        'post': post,
        'pin': pin,
        'district': district,
        'password': password,
        'photo': photo,
        'confirm': confirmpassword,
        'lid': sh.getString("lid").toString(),
      });
      print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        print(status);
        if (status == 'ok') {
          Fluttertoast.showToast(msg: 'Signup successfully');

          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoginNewPage(),
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
