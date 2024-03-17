// import 'dart:async';
// import 'dart:convert';
//
// import 'package:aicctv/login.dart';
// import 'package:animate_do/animate_do.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:workmanager/workmanager.dart';
//
// final _formkey = GlobalKey<FormState>();
//
// void main() {
// // needed if you intend to initialize in the `main` function
// //   WidgetsFlutterBinding.ensureInitialized();
// //   Workmanager().initialize(
// //
// //       // The top level function, aka callbackDispatcher
// //       callbackDispatcher,
// //
// //       // If enabled it will post a notification whenever
// //       // the task is running. Handy for debugging tasks
// //       isInDebugMode: true);
// // // Periodic task registration
// //   Workmanager().registerPeriodicTask(
// //     "2",
// //
// //     //This is the value that will be
// //     // returned in the callbackDispatcher
// //     "simplePeriodicTask",
// //
// //     // When no frequency is provided
// //     // the default 15 minutes is set.
// //     // Minimum frequency is 15 min.
// //     // Android will automatically change
// //     // your frequency to 15 min
// //     // if you have configured a lower frequency.
// //     frequency: Duration(seconds: 15),
// //   );
//   runApp(MyApp());
// }
//
// void callbackDispatcher(String message) {
//   print("hiii");
//
//   // Workmanager().executeTask((task, inputData) {
//     // initialise the plugin of flutterlocalnotifications.
//     FlutterLocalNotificationsPlugin flip =
//         new FlutterLocalNotificationsPlugin();
//
//     // app_icon needs to be a added as a drawable
//     // resource to the Android head project.
//     var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
//     // var IOS = new IOSInitializationSettings();
//
//     // initialise settings for both Android and iOS device.
//     var settings = new InitializationSettings(android: android);
//     flip.initialize(settings);
//     _showNotificationWithDefaultSound(flip, message);
//     // return Future.value(true);
//   // });
// }
//
// Future _showNotificationWithDefaultSound(flip,String message) async {
// // Show a notification after every 15 minute with the first
// // appearance happening a minute after invoking the method
//   var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//       'your channel id', 'your channel name',
//       importance: Importance.max, priority: Priority.high);
//
// // initialise channel platform for both Android and iOS device.
//   var platformChannelSpecifics =
//       new NotificationDetails(android: androidPlatformChannelSpecifics);
//   await flip.show(
//       0,
//       'Alert',
//       message,
//       platformChannelSpecifics,
//       payload: 'Default_Sound');
// }
//
// class MyApp extends StatelessWidget {
// // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Geeks Demo',
//       theme: ThemeData(
//         // This is the theme
//         // of your application.
//         primarySwatch: Colors.green,
//       ),
//       home: iphome(title: ""),
//     );
//   }
// }
//
// class iphome extends StatefulWidget {
//   iphome({Key? key, required this.title}) : super(key: key);
//
//   final String title;
//
//   @override
//   _iphomeState createState() => _iphomeState();
// }
//
// class _iphomeState extends State<iphome> {
//
//   _iphomeState() {
//     Timer.periodic(Duration(seconds: 15), (timer) {
//       getdata();
//     });
//   }
//
//   final FocusNode _focusNodePassword = FocusNode();
//   final _formkey=GlobalKey<FormState>();
//   TextEditingController ipController = new TextEditingController();
//
//   String ip = "";
//   void setIp() async{
//     SharedPreferences sh = await SharedPreferences.getInstance();
//
//     ipController.text = sh.getString("ip").toString();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     return WillPopScope(
//       onWillPop: () async{
//         return false; },
//       child: Scaffold(
//         // appBar: AppBar(
//         //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         //   title: Text(widget.title),
//         //   leading: Icon(Icons.cabin_sharp),
//         // ),
//         body: SingleChildScrollView(
//           child: Container(
//             width: double.infinity,
//             height: MediaQuery.of(context).size.height,
//             decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                     begin: Alignment.topCenter,
//                     colors: [
//                       Colors.white,
//                       Colors.blue.shade800,
//                       Colors.white
//                     ]
//                 )
//             ),
//             child: Form(
//               key: _formkey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   SizedBox(height: 80,),
//                   Padding(
//                     padding: EdgeInsets.all(20),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         FadeInUp(duration: Duration(milliseconds: 1000), child: Text("Ip Page", style: TextStyle(color: Colors.white, fontSize: 40),)),
//                         SizedBox(height: 10,),
//                         FadeInUp(duration: Duration(milliseconds: 1300), child: Text("Welcome Back", style: TextStyle(color: Colors.white, fontSize: 18),)),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   Expanded(
//                     child: Container(
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))
//                       ),
//                       child: Padding(
//                         padding: EdgeInsets.all(30),
//                         child: Column(
//                           children: <Widget>[
//                             SizedBox(height: 60,),
//                             FadeInUp(duration: Duration(milliseconds: 1400), child: Container(
//                               decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(10),
//                                   boxShadow: [BoxShadow(
//                                       color: Color.fromRGBO(225, 95, 27, .3),
//                                       blurRadius: 20,
//                                       offset: Offset(0, 10)
//                                   )]
//                               ),
//                               child: Column(
//                                 children: <Widget>[
//                                   Container(
//                                     padding: EdgeInsets.all(10),
//                                     decoration: BoxDecoration(
//                                         border: Border(bottom: BorderSide(color: Colors.grey.shade200))
//                                     ),
//                                     child: TextFormField(
//                                       controller: ipController,
//                                       decoration: InputDecoration(
//                                           hintText: "IP",
//                                           hintStyle: TextStyle(color: Colors.grey),
//                                           border: InputBorder.none
//                                       ),
//                                       onEditingComplete: () => _focusNodePassword.requestFocus(),
//                                       validator: (String? value) {
//                                         if (value == null || value.isEmpty) {
//                                           return "Ip Address.";
//                                         }
//
//                                         return null;
//                                       },
//                                     ),
//                                   ),
//
//
//                                 ],
//                               ),
//                             )),
//
//                             SizedBox(height: 40,),
//                             FadeInUp(duration: Duration(milliseconds: 1600), child: MaterialButton(
//                               onPressed: () {
//                                 if(_formkey.currentState!.validate()){
//                                   senddata();
//                                 }
//
//                               },
//                               height: 50,
//                               // margin: EdgeInsets.symmetric(horizontal: 50),
//                               color: Colors.blueAccent,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(50),
//
//                               ),
//                               // decoration: BoxDecoration(
//                               // ),
//                               child: Center(
//                                 child: Text("Connect", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
//                               ),
//                             )),
//                             // SizedBox(height: 40,),
//                             // FadeInUp(duration: Duration(milliseconds: 1500), child: Text("Don't have an account?", style: TextStyle(color: Colors.grey),)),
//
//
//
//
//
//                           ],
//                         ),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _focusNodePassword.dispose();
//     ipController.dispose();
//     super.dispose();
//   }
//
//   String Reminer = "", id = "", Date = "", Time = "";
//
//   Future<void> getdata() async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     try {
//       // String url = "${sh.getString("url").toString()}/viewNotification/";
//
//
//       String url = sh.getString('url').toString();
//       String lid = sh.getString('lid').toString();
//
//       final urls = Uri.parse('$url/view_notification/');
//
//
//
//       String nid="0";
//       if(sh.containsKey("nid")==false) {}
//       else{
//         nid=sh.getString('nid').toString();
//       }
//       Fluttertoast.showToast(msg:nid);
//
//
//
//       var datas = await http
//           .post(urls,
//           body: {
//             'nid': nid ,
//         'lid':lid
//           });
//       var jsondata = json.decode(datas.body);
//       String status = jsondata['status'];
//       print(status);
//       if (status == "ok") {
//         String nid = jsondata['nid'].toString();
//         String message = jsondata['message'];
//         sh.setString('nid',nid);
//         callbackDispatcher(message);
//         // var data = json.decode(datas.body)['data'];
//         // setState(() {
//         //   for (int i = 0; i < data.length; i++) {
//         //     Reminer = (data[i]['Reminder'].toString());
//         //     id = (data[i]['id'].toString());
//         //     Date = (data[i]['Date']);
//         //     Time = (data[i]['Time']);
//         //   }
//         // });
//
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: e.toString());
//       print("Error ------------------- " + e.toString());
//       //there is error during converting file image to base64 encoding.
//     }
//   }
//
//
//
//   void senddata()async{
//     String ip= ipController.text.toString();
//
//     //stable ip address settings second
//     print(ip);
//     SharedPreferences sh=await SharedPreferences.getInstance();
//
//     //stable ip address settings first
//     sh.setString('ip', ip);
//     sh.setString('url', 'http://$ip:8000/myapp');
//     sh.setString('img_url', 'http://$ip:8000/');
//     // sh.setString('img_url2', 'http://$ip:8000');
//     // Navigator.push(context, MaterialPageRoute(builder: (context) => LoginNewPage()
//     Navigator.push(context, MaterialPageRoute(builder: (context) => LoginNewPage()
//     )
//     );
//
//   }
//
//   String? validateUsername(String value){
//     if(value.isEmpty){
//       return 'Please enter Ip';
//     }
//     return null;
//
//   }
//
//
// }
