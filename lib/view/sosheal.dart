import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Download.dart';
import '../widgets/custom_botton_home.dart';
import '../widgets/custom_line.dart';

class sosheal extends StatelessWidget {
  sosheal({Key key}) : super(key: key);
  static String id = 'sosheal';

  Color primaryColor=const Color(0xff0f1a1f);

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: primaryColor,
      //  backgroundColor: Colors.grey[900],
        body: StreamBuilder(
            stream: users.snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Column(
                        children: [
                          Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            custom_botton_home(
                              link: snapshot.data.docs[i]
                                  .data()['nameyoutube'],
                              image: snapshot.data.docs[i]
                          .data()['photoyoutube'],
                            ),
                            custom_botton_home(
                              link:
                                  snapshot.data.docs[i].data()['nameansta'],
                              image: snapshot.data.docs[i]
                                  .data()['photoansta'],
                            ),
                            custom_botton_home(
                              link: snapshot.data.docs[i]
                                  .data()['namefacebook'],
                              image: snapshot.data.docs[i]
                                  .data()['photofacebook'],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            custom_botton_home(
                              link: snapshot.data.docs[i]
                                  .data()['namesnapchat'],
                              image: snapshot.data.docs[i]
                                  .data()['photosnapchat'],
                            ),
                            custom_botton_home(
                              link: snapshot.data.docs[i]
                                  .data()['nametwitter'],
                              image: snapshot.data.docs[i]
                                  .data()['phototwitter'],
                            ),
                            custom_botton_home(
                              link: snapshot.data.docs[i]
                                  .data()['nametiktok'],
                              image: snapshot.data.docs[i]
                                  .data()['phototiktok'],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            custom_botton_home(
                              link: snapshot.data.docs[i]
                                  .data()['nametelegram'],
                              image: snapshot.data.docs[i]
                                  .data()['phototelegram'],
                            ),
                            custom_botton_home(
                              link: snapshot.data.docs[i]
                                  .data()['namekuaishou'],
                              image: snapshot.data.docs[i]
                                  .data()['photokuaishou'],
                            ),
                            custom_botton_home(
                              link: snapshot.data.docs[i]
                                  .data()['namewhatsapp'],
                              image: snapshot.data.docs[i]
                                  .data()['photowhatsapp'],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            custom_botton_home(
                              link: snapshot.data.docs[i]
                                  .data()['namegoogle'],
                              image: snapshot.data.docs[i]
                                  .data()['photogoogle'],
                            ),
                            custom_botton_home(
                              link: snapshot.data.docs[i]
                                  .data()['namegoogle-maps'],
                              image: snapshot.data.docs[i]
                                  .data()['photogoogle-maps'],
                            ),
                            custom_botton_home(
                              link: snapshot.data.docs[i]
                                  .data()['namegmail'],
                              image: snapshot.data.docs[i]
                                  .data()['photogmail'],
                            ),
                          ],
                        ),
                        const CustomLine(),
                        // ignore: deprecated_member_use
                        FlatButton(
                          onPressed: () {
                            Get.to(const DownloadScreen());
                          },
                          child: Row(
                            children: [
                              const Text(
                                'Download videos from here:',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.white60),
                              ),
                              const Spacer(),
                              Image.network(
                              snapshot.data.docs[i]
                                    .data()['photoyoutube'],
                                height: 40,
                                width: 40,
                              ),
                              const Spacer(),
                              Container(),
                            ],
                          ),
                        ),
                        const CustomLine(),
                        ],
                      ),
                    );
                  },
                );
              }
              if (snapshot.hasError) {
                return const Center(child: Text("hasError"));
              }
              return const Center(child: CircularProgressIndicator(color: Colors.white));
            }),
      ),
    );
  }
}
