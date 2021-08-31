import 'package:flutter/material.dart';
import 'package:unito_pandemic_decentralized/ui/constant.dart';

class PreventCard extends StatelessWidget {
  final String image;
  final String title;
  final String text;
  const PreventCard({Key key, this.image, this.title, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SizedBox(
        height: 156,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: <Widget>[
            Padding(padding: EdgeInsets.all(8)),
            Container(
              height: 256,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 8),
                    blurRadius: 24,
                    color: kShadowColor,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(32),
              child: Image.asset(image),
            ),
            Positioned(
              left: 125,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                height: 200,
                width: MediaQuery.of(context).size.width - 170,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(height: 12),
                    Text(
                      title,
                      style: kTitleTextstyle.copyWith(
                        fontSize: 16,
                      ),
                    ),
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(text),
                    )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
