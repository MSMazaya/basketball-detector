import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_app/datamodels/point/point.dart';
import 'package:mobile_app/views/config/lap/lap_viewmodel.dart';
import 'package:stacked/stacked.dart';

class LapView extends StatelessWidget {
  final String time;
  const LapView({Key? key, required this.time}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LapViewModel>.reactive(
      viewModelBuilder: () => LapViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 43, 77, 190),
          title: Text('Data at $time'),
        ),
        resizeToAvoidBottomInset: false,
        body: Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color.fromARGB(255, 41, 47, 172),
                Color.fromARGB(255, 18, 26, 62),
                Color.fromARGB(255, 18, 26, 62),
                Color.fromARGB(255, 18, 26, 62),
                Color.fromARGB(255, 18, 26, 62),
                Color.fromARGB(255, 90, 54, 198),
              ],
            ),
          ),
          child: Container(
            padding: EdgeInsets.only(top: 50, bottom: 10),
            width: MediaQuery.of(context).size.width * 0.8,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FutureBuilder<QuerySnapshot<Point>>(
                    future: model.getScoreStream(time),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot<Point>> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Something went wrong');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final childs = snapshot.data!.docs
                          .map((DocumentSnapshot<Point> document) {
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
                ],
              ),
            ),
          ),
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
