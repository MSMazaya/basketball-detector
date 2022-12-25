import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      builder: (context, model, child) => SingleChildScrollView(
        child: Column(
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
                  return const Center(child: CircularProgressIndicator());
                }

                final childs =
                    snapshot.data!.docs.map((DocumentSnapshot<Point> document) {
                  Point? data = document.data();
                  return PlayerScoreCard(
                    score: data!.score,
                    position: data.position,
                    attempt: data.attempt,
                  );
                }).toList();

                childs.sort((a, b) => a.position - b.position);

                return Column(
                  children: childs,
                );
              },
            ),
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.8,
              child: OutlinedButton(
                onPressed: () {
                  HapticFeedback.vibrate();
                  model.resetScore();
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.red),
                ),
                child:
                    Text("Reset Score", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PlayerScoreCard extends StatelessWidget {
  const PlayerScoreCard({
    Key? key,
    required this.score,
    required this.position,
    required this.attempt,
  }) : super(key: key);

  final int score;
  final int position;
  final int attempt;

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
                        "Attempt: $attempt",
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
