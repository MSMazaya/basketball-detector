import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mobile_app/datamodels/point/point.dart';
import 'package:mobile_app/views/home/home_viewmodel.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (model) {
        // model.getUsername();
        // model.onMount();
        var straem = model.getScoreStream();
        straem.listen((data) {
          print("HELLOOOO");
          print(data.docs.length);
          for (var i = 0; i < data.docs.length; i++) {
            var score = data.docs[i].get("score");
            var position = data.docs[i].get("position");
            print(score);
            print(position);
          }
        });
      },
      builder: (context, model, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StreamBuilder<QuerySnapshot<Point>>(
            stream: model.getScoreStream(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot<Point>> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }

              return Column(
                children:
                    snapshot.data!.docs.map((DocumentSnapshot<Point> document) {
                  Point? data = document.data();
                  return PlayerScoreCard(
                    score: data!.score,
                    position: data!.position,
                    angle: data!.angle,
                  );
                }).toList(),
              );
            },
          ),
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width * 0.8,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.red),
              ),
              child: Text("Reset Score", style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}

class PlayerScoreCard extends StatelessWidget {
  const PlayerScoreCard({
    Key? key,
    required this.score,
    required this.position,
    required this.angle,
  }) : super(key: key);

  final int score;
  final int position;
  final double angle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Player ${position}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        "Position: ${angle}",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.blue,
                ),
                child: Column(
                  children: [
                    Text("Score:"),
                    Text(score.toString()),
                  ],
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
