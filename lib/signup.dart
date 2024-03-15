import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const MySignUp(title: 'cyberceime signup page'),
    );
  }
}

class MySignUp extends StatefulWidget {
  const MySignUp({super.key, required this.title});

  final String title;

  @override
  State<MySignUp> createState() => _MySignupState();
}

String gender = 'Male';

class _MySignupState extends State<MySignUp> {
  File? _selectedImage;
  String? _encodedImage;
  String? nameError;

  String? phoneError;
  String? emailError;
  String? placeError;
  String? postError;
  String? pinError;
  String? districtError;

  String? passwordError;
  String? cpasswordError;

  final nameCont = TextEditingController();
  final phoneCont = TextEditingController();
  final emailCont = TextEditingController();
  final placeCont = TextEditingController();
  final postCont = TextEditingController();
  final pinCont = TextEditingController();
  final districtCont = TextEditingController();
  final passwCont = TextEditingController();
  final cpassCont = TextEditingController();

  Widget signupContainer(TextEditingController text, String hints,
      TextInputType inputType, String? errorText) {
    return Container(
      height: 55,
      margin: EdgeInsets.only(bottom: 1),
      decoration: BoxDecoration(
          // color: Colors.blueGrey.shade200,
          color: Color.fromARGB(150, 176, 190, 197),
          borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: const EdgeInsets.only(left: 25.0, top: 7, right: 25),
        child: TextField(
          controller: text,
          autocorrect: false,
          enableSuggestions: false,
          autofocus: false,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              label: Text(hints),
              hintText: hints,
              hintStyle: const TextStyle(
                  fontSize: 18,
                  color: Colors.white70,
                  fontStyle: FontStyle.italic),
              errorText: errorText),
          style: TextStyle(fontSize: 18),
          keyboardType: inputType,
          onChanged: (_) {
            setState(() {
              // Reset error message when text changes
              errorText = null;
            });
          },
        ),
      ),
    );
  }

  Widget genderContainer(
      RadioListTile radioListTile, RadioListTile radioListTile1) {
    return Container(
      margin: EdgeInsets.only(bottom: 1),
      decoration: BoxDecoration(
          // color: Colors.blueGrey.shade200,
          color: Color.fromARGB(150, 176, 190, 197),
          borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: EdgeInsets.only(left: 25.0, right: 25),
        child: Column(
          children: [radioListTile, radioListTile1],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.center,
            fit: BoxFit.fitHeight,
            image: AssetImage(
    ' assets/images/cbc.jpg'), // Replace 'assets/your_image.png' with the actual asset image path
            // fit: BoxFit.cover, // You can adjust the fit property as needed
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                // height: 0,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 45),
                      if (_selectedImage != null) ...{
                        InkWell(
                          child: Image.file(_selectedImage!, height: 100),
                          radius: 99,
                          onTap: _checkPermissionAndChooseImage,
                          borderRadius: BorderRadius.all(Radius.circular(99)),
                        ),
                      } else ...{
                        CircleAvatar(
                          radius: 70,
                          child: InkWell(
                            radius: 100,
                            onTap: _checkPermissionAndChooseImage,
                            child: const Icon(Icons.person),
                          ),
                        ),
                      },
                      signupContainer(
                          nameCont, 'Name', TextInputType.name, nameError),
                      genderContainer(
                          RadioListTile(
                            value: 'Male',
                            title: Text('Male'),
                            groupValue: gender,
                            onChanged: (value) {
                              setState(() {
                                gender = value.toString();
                              });
                            },
                          ),
                          RadioListTile(
                            value: 'Female',
                            title: Text('Female'),
                            groupValue: gender,
                            onChanged: (value) {
                              setState(() {
                                gender = value.toString();
                              });
                            },
                          )),
                      signupContainer(
                          phoneCont, 'Phone', TextInputType.name, phoneError),
                      signupContainer(
                          emailCont, 'Email', TextInputType.name, emailError),
                      signupContainer(
                          placeCont, 'Place', TextInputType.name, placeError),
                      signupContainer(
                          postCont, 'Post', TextInputType.name, postError),
                      signupContainer(
                          pinCont, 'PIN', TextInputType.name, pinError),
                      signupContainer(districtCont, 'District',
                          TextInputType.name, districtError),
                      signupContainer(passwCont, 'Password', TextInputType.name,
                          passwordError),
                      signupContainer(cpassCont, 'Re-Enter Password',
                          TextInputType.visiblePassword, cpasswordError),
                      Container(
                        height: 55,
                        // for an exact replicate, remove the padding.
                        // pour une réplique exact, enlever le padding.
                        padding:
                            const EdgeInsets.only(top: 5, left: 70, right: 70),
                        child: ElevatedButton(
                          // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                          // color: Colors.indigo.shade800,
                          onPressed: () {
                            validateAndSignUp();
                            senddata();
                          },
                          child: Text(
                            'signUp',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: Text('Have an account ? Login'),
                      ),
                      Divider(thickness: 0, color: Colors.white),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void validateAndSignUp() {
    if (nameCont.text.isEmpty) {
      setState(() {
        nameError = 'Name is required';
      });
      return;
    } else if (phoneCont.text.isEmpty) {
      setState(() {
        phoneError = 'Phone is required';
      });
      return;
    } else if (emailCont.text.isEmpty) {
      setState(() {
        emailError = 'Email is required';
      });
      return;
    } else if (placeCont.text.isEmpty) {
      setState(() {
        placeError = 'Place is required';
      });
      return;
    } else if (postCont.text.isEmpty) {
      setState(() {
        postError = 'Post is required';
      });
      return;
    } else if (pinCont.text.isEmpty) {
      setState(() {
        pinError = 'PIN is required';
      });
      return;
    } else if (districtCont.text.isEmpty) {
      setState(() {
        districtError = 'District is required';
      });
      return;
    } else if (passwCont.text.isEmpty) {
      setState(() {
        passwordError = 'Password is required';
      });
      return;
    } else if (cpassCont.text.isEmpty) {
      setState(() {
        cpasswordError = 'Please re-enter password';
      });
      return;
    } else if (passwCont.text != cpassCont.text) {
      setState(() {
        cpasswordError = 'Passwords do not match';
      });
      return;
    }
    // else{
    //   signUp(nameCont.text, dobCont.text, phoneCont.text, emailCont.text, placeCont.text, postCont.text, pinCont.text, districtCont.text, passwCont.text, cpassCont.text);
    // }
  }

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

  void senddata() async {
    String name = nameCont.text;
    String email = emailCont.text;
    String place = placeCont.text;
    String post = postCont.text;
    String pin = pinCont.text;
    String district = districtCont.text;
    String phone = phoneCont.text;
    String password = passwCont.text;
    String confirmpass = cpassCont.text;

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();

    final urls = Uri.parse('$url/user_signup/');

    try {
      final response = await http.post(urls, body: {
        'name': name,
        'email': email,
        'place': place,
        'gender': gender,
        'pincode': pin,
        'district': district,
        'post': post,
        'phone': phone,
        'password': password,
        'confirmpassword': confirmpass,
        "photo": photo,
      });

      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          Fluttertoast.showToast(msg: 'Sussessfully registerd');

          // String lid = jsonDecode(response.body)['lid'];
          // sh.setString('lid', lid);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoginNewPage(),
              ));
        } else {
          Fluttertoast.showToast(msg: 'not found');
        }
      } else {
        Fluttertoast.showToast(msg: 'Invalid');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  //
  // Future<void> signUp(name, dob, phone, email, place, post, pin, district, password, cpassword) async {
  //   // Fluttertoast.showToast(msg: (gender));
  //
  //   SharedPreferences sh = await SharedPreferences.getInstance();
  //   String Url = sh.getString('url').toString();
  //
  //   final url = Uri.parse('$Url/user_signup/');
  //   try {
  //     final response = await http.post(url, body: {
  //       'name': name,
  //       'dob': dob,
  //       'gender': gender,
  //       'phone': phone,
  //       'email': email,
  //       'place': place,
  //       'post': post,
  //       'pin': pin,
  //       'district': district,
  //       'password': password,
  //       'photo': photo,
  //     });
  //     if (response.statusCode == 200) {
  //       String status = jsonDecode(response.body)["status"];
  //       if (status != "ok") {
  //         Fluttertoast.showToast(msg: 'Not Found');
  //       } else {
  //         Fluttertoast.showToast(msg: 'Welcome');
  //       }
  //     } else {
  //       Fluttertoast.showToast(msg: 'Network Error');
  //     }
  //   } catch (e) {
  //     Fluttertoast.showToast(msg: e.toString());
  //   }
  //
  //
  //
  //

  // }

  String? validateName(String value) {
    if (value.isEmpty) {
      return 'Please enter a Name';
    }
    return null;
  }

  String? validateDob(String value) {
    if (value.isEmpty) {
      return 'Please enter a DOB';
    }
    return null;
  }

  String? validatePhone(String value) {
    if (value.isEmpty) {
      return 'Please enter a Phone';
    }
    return null;
  }

  String? validateEmail(String value) {
    if (value.isEmpty) {
      return 'Please enter a Email';
    }
    return null;
  }

  String? validatePlace(String value) {
    if (value.isEmpty) {
      return 'Please enter a Place';
    }
    return null;
  }

  String? validatePost(String value) {
    if (value.isEmpty) {
      return 'Please enter a Post';
    }
    return null;
  }

  String? validatePin(String value) {
    if (value.isEmpty) {
      return 'Please enter a PIN';
    }
    return null;
  }

  String? validateDistrict(String value) {
    if (value.isEmpty) {
      return 'Please enter a District';
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.length < 8) {
      return 'Please enter a Password containing at least 8 characters';
    }
    return null;
  }

  String? validateCPassword(String value) {
    if (value.toLowerCase() != passwCont.text.toString()) {
      return 'Passwords did not match';
    }
    return null;
  }
}
