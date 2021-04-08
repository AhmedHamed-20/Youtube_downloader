import 'dart:async';
import 'package:flutter/material.dart';
import 'package:vedio_downloader/models/getdata.dart';
import 'package:vedio_downloader/models/checkConnection.dart';
import 'package:toast/toast.dart';

bool isbressed = false;
bool ischange = false;

double state = 0.0;
TextEditingController url = TextEditingController();

class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  void updateProgress() {
    Timer.periodic(
        const Duration(seconds: 1),
        (Timer t) => setState(() {
              state = statistics;
            }));
    if (statistics == 1.0) {
      statistics = 0.0;
      videoname = '';
    }
  }

  @override
  void initState() {
    super.initState();

    //from check connection file in models folder
    checkConnection(context);
  }

  @override
  void dispose() {
    listener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xff161616),
      body: SafeArea(
          child: Center(
        child: Container(
          width: width,
          height: height,
          padding: EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: width * 0.6,
                  height: height * 0.3,
                  child: Image.asset('assets/images/logo.gif'),
                ),
                SizedBox(
                  height: height * 0.1,
                ),
                Container(
                  width: width * 0.8,
                  child: TextField(
                    onSubmitted: (val) {},
                    onChanged: (_) {
                      setState(() {
                        ischange = true;
                        error = false;
                      });
                    },
                    controller: url,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(35),
                          ),
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[800]),
                        hintText: "Paste your url here",
                        fillColor: Colors.white70),
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 150,
                      height: 50,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              )),
                              backgroundColor:
                                  MaterialStateProperty.resolveWith(
                                      (states) => Color(0xff81c784))),
                          onPressed: () {
                            (error == true)
                                ? ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                    content: Text('Please Enter valid url'),
                                    duration: Duration(seconds: 3),
                                  ))
                                : (internetStatus ==
                                        'You are disconnected to the Internet. ')
                                    ? ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                        content: Text(
                                            'Please check internet connection'),
                                        duration: Duration(seconds: 3),
                                      ))
                                    : url.text == ''
                                        ? Toast.show(
                                            'Please Enter Url', context)
                                        : getvedio(url.text);
                            isbressed = true;
                            ischange = false;
                            updateProgress();
                          },
                          child: Center(
                            child: Text('Download Video'),
                          )),
                    ),
                    Container(
                      width: 150,
                      height: 50,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              )),
                              backgroundColor:
                                  MaterialStateProperty.resolveWith(
                                      (states) => Color(0xff81c784))),
                          onPressed: () {
                            (error == true)
                                ? ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                    content: Text('Please Enter valid url'),
                                    duration: Duration(seconds: 3),
                                  ))
                                : (internetStatus ==
                                        'You are disconnected to the Internet. ')
                                    ? ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                        content: Text(
                                            'Please check internet connection'),
                                        duration: Duration(seconds: 3),
                                      ))
                                    : (url.text == '')
                                        ? Toast.show(
                                            'Please Enter Url', context)
                                        : getaudio(url.text);
                            isbressed = true;
                            ischange = false;
                            updateProgress();
                          },
                          child: Center(
                            child: Text('Download audio'),
                          )),
                    )
                  ],
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                (error == false)
                    ? (isbressed == true)
                        ? (statistics == 1.0)
                            ? SizedBox.shrink()
                            : (videoname == '')
                                ? SizedBox()
                                : Container(
                                    child: Text(
                                      '[${videoname} ] Will be downloaded',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )
                        : SizedBox.shrink()
                    : SizedBox.shrink(),
                SizedBox(
                  height: height * 0.02,
                ),
                (error == true)
                    ? SizedBox.shrink()
                    : (isbressed == false || videoname == '')
                        ? SizedBox.shrink()
                        : (statistics == 1.0)
                            ? SizedBox()
                            : LinearProgressIndicator(
                                value: state,
                                backgroundColor: Colors.white,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.green),
                                minHeight: 3,
                              ),
                SizedBox(
                  height: height * 0.02,
                ),
                (error == true)
                    ? SizedBox.shrink()
                    : (statistics == 1.0)
                        ? (ischange == false && statistics == 1.0)
                            ? Text(
                                'File Saved to download folder',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              )
                            : SizedBox.shrink()
                        : SizedBox.shrink(),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
