import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class custom_botton_home extends StatelessWidget {
  const custom_botton_home({
    Key key,
    @required this.link,
    @required this.image,
  }) : super(key: key);

  final String link;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FlatButton(
        minWidth: MediaQuery.of(context).size.width * .01,
        height: MediaQuery.of(context).size.height * .1,
        onPressed: () async {
          try {
            await canLaunch(link)
                ? await launch(
              link,
              enableJavaScript: true,
              forceWebView: true,
            )
                : throw 'could not lunch url';
          } catch (e) {
            e.toString();
          }
        },
        child: Column(
          children: [
            Image.network(
              image,
              height: 50,
              width: 50,
            ),
            //'assets/image/telegram.png'
          ],
        ),
      ),
    );
  }
}
