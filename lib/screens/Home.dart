import 'dart:async';
import 'dart:convert';
import 'package:aicctv/public/viewdetectedcriminals.dart';
import 'package:aicctv/send%20rating.dart';
import 'package:aicctv/view_criminals.dart';
import 'package:aicctv/view_family_person.dart';
import 'package:aicctv/view_police_station.dart';
import 'package:aicctv/view_profile.dart';
import 'package:aicctv/view_suspicious_activity.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:aicctv/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:aicctv/screens/SeeAll.dart';
import 'package:aicctv/res/lists.dart';
import 'package:aicctv/widgets/text_widget.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

// import '../ip.dart';
// import '../courses.dart';
import '../sent_complaint.dart';

// import '../user_add_staff.dart';
import '../user_changepassword.dart';

// import '../user_search_face.dart';
// import '../view_prof_new.dart';
// import '../view_staffs.dart';
// import '../view_timeline.dart';
import '../viewcomplaint.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var opacity = 0.0;
  bool position = false;

  String user_name_ = "";
  String user_photo_ = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      animator();

      view_movies();
      setState(() {});
    });
  }

  animator() {
    if (opacity == 1) {
      opacity = 0;
      position = false;
    } else {
      opacity = 1;
      position = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.only(top: 30, left: 0, right: 0),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,

          child: Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 400),
                top: position ? 1 : 100,
                right: 20,
                left: 20,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 400),
                  opacity: opacity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 35,
                                backgroundImage: NetworkImage(user_photo_),
                              ),

                              Column(
                                children: [
                                  TextWidget(
                                      "Hello",
                                      20,
                                      Colors.black.withOpacity(.7),
                                      FontWeight.bold),

                                  TextWidget( "    $user_name_", 25, Colors.black,
                                      FontWeight.bold),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                      IconButton(
                        icon: Icon(Icons.logout),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginNewPage(),
                              ));
                        },
                        // Optionally, you can specify the icon's size and color
                        iconSize: 40,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                ),
              ),
              AnimatedPositioned(
                top: position ? 80 : 140,
                left: 20,
                right: 20,
                duration: const Duration(milliseconds: 400),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 400),
                  opacity: opacity,
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              AnimatedPositioned(
                  top: position ? 150 : 220,
                  right: 20,
                  left: 20,
                  duration: const Duration(milliseconds: 400),
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 400),
                    opacity: opacity,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Container(
                        height: 150,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.blue.shade700,
                                  Colors.blue.shade900,
                                  Colors.blue.shade900,
                                ])),
                        child: Stack(
                          children: [
                            Positioned(
                                top: 25,
                                left: 20,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 30,
                                      child: Center(
                                        child: Image(
                                          fit: BoxFit.fill,
                                          image: AssetImage(
                                              'assets/aicctv.png'),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        TextWidget(
                                          "AiCCTV",
                                          15,
                                          Colors.white,
                                          FontWeight.normal,
                                          letterSpace: 1,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            TextWidget(
                                              "Developed By",
                                              15,
                                              Colors.white,
                                              FontWeight.normal,
                                              letterSpace: 1,
                                            ),
                                            TextWidget(
                                              " SN College",
                                              15,
                                              Colors.white,
                                              FontWeight.bold,
                                              letterSpace: 2,
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                )),
                            Positioned(
                                top: 100,
                                left: 20,
                                child: Container(
                                  height: 1,
                                  width: 300,
                                  color: Colors.white.withOpacity(.5),
                                )),
                            Positioned(
                                top: 115,
                                left: 20,
                                right: 1,
                                child: Container(
                                  width: double.infinity,
                                  child: Row(
                                    children: [
                                      TextWidget(
                                          "", 15, Colors.white, FontWeight.bold,
                                          letterSpace: 1),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Expanded(
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              child: CircleAvatar(
                                                radius: 15,
                                                backgroundColor: Colors.blue,
                                              ),
                                            ),
                                            Positioned(
                                              left: 20,
                                              child: CircleAvatar(
                                                radius: 15,
                                                backgroundColor: Colors.red,
                                              ),
                                            ),
                                            Positioned(
                                              left: 40,
                                              child: CircleAvatar(
                                                radius: 15,
                                                backgroundColor: Colors.white,
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                            Positioned(
                                top: 10,
                                right: 10,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.notification_important,
                                    color: Colors.white,
                                    size: 35,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ViewSuspiciousActivity()),
                                    );
                                  },
                                ))
                          ],
                        ),
                      ),
                    ),
                  )),
              categoryRow(),
              AnimatedPositioned(
                  top: position ? 420 : 500,
                  left: 20,
                  right: 20,
                  duration: const Duration(milliseconds: 400),
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: opacity,
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextWidget(
                            "",
                            25,
                            Colors.black.withOpacity(.8),
                            FontWeight.bold,
                            letterSpace: 0,
                          ),
                          InkWell(
                              onTap: () async {
                                animator();
                                setState(() {});
                                // Timer(Duration(seconds: 1),() {
                                //   Navigator.push(context, MaterialPageRoute(builder: (context) => SeeAll(),));
                                //   animator();
                                // },);
                                await Future.delayed(
                                    const Duration(milliseconds: 500));
                                await Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return SeeAll();
                                  },
                                ));

                                setState(() {
                                  animator();
                                });
                              },
                              child: Text("")),
                          // TextWidget("See all", 15, Colors.blue.shade600.withOpacity(.8), FontWeight.bold,letterSpace: 0,)),
                        ],
                      ),
                    ),
                  )),
              AnimatedPositioned(
                  bottom: 1,
                  left: position ? 50 : 150,
                  duration: const Duration(milliseconds: 400),
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 400),
                    opacity: opacity,
                    child: Container(
                      height: 450,
                      width: 400,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('/assets/images/akfor.png'),
                              fit: BoxFit.fill)),
                    ),
                  )),
              doctorList(),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 400),
                    opacity: opacity,
                    child: CurvedNavigationBar(
                        onTap: (value) {
                          if (value == 0) {}

                          if (value == 1) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ViewDetectedCriminals(),
                                ));
                          }

                          if (value == 2) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ViewReplyPage(
                                    title: "My complaints",
                                  ),
                                ));
                          }
                          if (value == 3) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SendRating(
                                    title: '',
                                  ),
                                ));
                          }
                          if (value == 4) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MyUserChangePassword(),
                                ));
                          }
                        },
                        backgroundColor: Colors.white,
                        items: const [
                          Icon(
                            Icons.home_filled,
                            color: Colors.blue,
                            size: 30,
                          ),
                          Icon(
                            Icons.dangerous,
                            color: Colors.black,
                            size: 30,
                          ),
                          Icon(
                            Icons.feedback,
                            color: Colors.black,
                            size: 30,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.black,
                            size: 30,
                          ),
                          Icon(
                            Icons.settings,
                            color: Colors.black,
                            size: 30,
                          ),
                        ]),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void view_movies() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();
    final urls = Uri.parse(url + "/and_viewprofile/");
    try {
      final response = await http.post(urls, body: {
        'lid': lid,
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          Fluttertoast.showToast(msg: 'HOME');

          setState(() {
            user_name_ = jsonDecode(response.body)['name']; //

            user_photo_ = sh.getString('img_url').toString() +
                jsonDecode(response.body)['photo'];
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

  AnimatedPositioned doctorList() {
    return AnimatedPositioned(
        top: position ? 460 : 550,
        left: 20,
        right: 20,
        duration: const Duration(milliseconds: 400),
        child: Column(
          children: [],
        ));
  }

  Widget doctorCard(String name, String specialist, NetworkImage image) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: SizedBox(
        height: 120,
        width: double.infinity,
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            CircleAvatar(
              radius: 30,
              backgroundImage: image,
              backgroundColor: Colors.blue,
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  name,
                  20,
                  Colors.black,
                  FontWeight.bold,
                  letterSpace: 0,
                ),
                const SizedBox(
                  height: 5,
                ),
                TextWidget(
                  specialist,
                  17,
                  Colors.black,
                  FontWeight.bold,
                  letterSpace: 0,
                ),
                const SizedBox(
                  height: 5,
                ),
                // const Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Icon(Icons.star,color: Colors.orangeAccent,),
                //     Icon(Icons.star,color: Colors.orangeAccent,),
                //     Icon(Icons.star,color: Colors.orangeAccent,),
                //     Icon(Icons.star,color: Colors.orangeAccent,),
                //     Icon(Icons.star,color: Colors.orangeAccent,),
                //   ],
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget categoryRow() {
    return AnimatedPositioned(
        top: position ? 320 : 420,
        left: 25,
        right: 25,
        duration: const Duration(milliseconds: 400),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 400),
          opacity: opacity,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                category("assets/images/profile.png", "Profile", 5),
                category1("assets/images/family.jpg", "Family", 10),
                category2("assets/images/criminals.jpg", "Criminals", 10),
                category3("assets/images/police.png", "Police", 12),
              ],
            ),
          ),
        ));
  }

  Widget category(String asset, String txt, double padding) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyViewProfilePage(
                    title: '',
                  ),
                ));
          },
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
              padding: EdgeInsets.all(padding),
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Image(
                  image: AssetImage(asset),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        TextWidget(
          txt,
          16,
          Colors.black,
          FontWeight.bold,
          letterSpace: 1,
        ),
      ],
    );
  }

  Widget category1(String asset, String txt, double padding) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyViewFamilyPerson(),
                ));
          },
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
              padding: EdgeInsets.all(padding),
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Image(
                  image: AssetImage(asset),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        TextWidget(
          txt,
          16,
          Colors.black,
          FontWeight.bold,
          letterSpace: 1,
        ),
      ],
    );
  }

  Widget category2(String asset, String txt, double padding) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserViewCriminals(),
                ));
          },
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
              padding: EdgeInsets.all(padding),
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Image(
                  image: AssetImage(asset),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        TextWidget(
          txt,
          16,
          Colors.black,
          FontWeight.bold,
          letterSpace: 1,
        ),
      ],
    );
  }

  Widget category3(String asset, String txt, double padding) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ViewPoliceStation(),
                ));
          },
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
              padding: EdgeInsets.all(padding),
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Image(
                  image: AssetImage(asset),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        TextWidget(
          txt,
          16,
          Colors.black,
          FontWeight.bold,
          letterSpace: 1,
        ),
      ],
    );
  }

  a() {
    List<Widget> s = [];
    return s;
  }
}
