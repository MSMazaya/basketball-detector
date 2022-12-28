import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ext_video_player/ext_video_player.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/views/fields/fields_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../../datamodels/point/point.dart';

class FieldView extends StatelessWidget {
  const FieldView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FieldsViewModel>.reactive(
      onModelReady: (model) => model.initState(),
      viewModelBuilder: () => FieldsViewModel(),
      builder: (context, model, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Field Configuration",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
            width: 10,
          ),
          StreamBuilder<QuerySnapshot<Point>>(
              stream: model.getScoreStream(),
              builder: (
                BuildContext context,
                AsyncSnapshot<QuerySnapshot<Point>> snapshot,
              ) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final childs =
                    snapshot.data!.docs.map((DocumentSnapshot<Point> document) {
                  Point? data = document.data();
                  return PositionedPoint(
                    model: model,
                    score: data!.score,
                    attempt: data.attempt,
                    positionNumber: data.position,
                    mode: model.viewTable.indexOf(true),
                  );
                }).toList();
                return Stack(children: [
                  const Image(
                    image: AssetImage('lib/assets/court.jpg'),
                  ),
                  ...childs
                ]);
              }),
          const SizedBox(
            height: 30,
            width: 10,
          ),
          (model.ready
              ? AspectRatio(
                  aspectRatio: model.controller.value.aspectRatio,
                  child: VideoPlayer(model.controller),
                )
              : const CircularProgressIndicator()),
          Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // ToggleButtons with a single selection.
                const Text(
                  "Select View",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                ToggleButtons(
                  direction: Axis.horizontal,
                  onPressed: model.changeViewTable,
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  selectedBorderColor: const Color.fromARGB(255, 43, 77, 190),
                  selectedColor: Colors.white,
                  fillColor: const Color.fromARGB(255, 43, 77, 190),
                  color: Colors.white,
                  constraints: const BoxConstraints(
                    minHeight: 40.0,
                    minWidth: 80.0,
                  ),
                  isSelected: model.viewTable,
                  children: const <Widget>[
                    Text('Configuration'),
                    Text('Scores'),
                    Text('Summary'),
                  ],
                ),
              ])
        ],
      ),
    );
  }
}

class PositionedPoint extends StatelessWidget {
  final FieldsViewModel model;
  final int positionNumber;
  final int mode;
  final int score;
  final int attempt;

  const PositionedPoint({
    Key? key,
    required this.model,
    required this.positionNumber,
    required this.mode,
    required this.attempt,
    this.score = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final y = model.getPosition(positionNumber).y;
    final x = model.getPosition(positionNumber).x;
    if (mode == 0) {
      return Positioned(
        top: y,
        left: x,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.all(5),
          child: Text(
            getText(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    } else if (mode == 1) {
      final rng = Random();
      // create an offset with length of score that is using rng.nextDouble()
      final positions = List<Position>.filled(score, Position(0, 0)).map(
        (e) => Position(
          rng.nextDouble() * 15,
          rng.nextDouble() * 15,
        ),
      );

      return Positioned(
        top: y,
        left: x,
        child: Stack(children: [
          const SizedBox(
            height: 100,
            width: 100,
          ),
          Text(
            "$positionNumber",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          ...positions.map(
            (p) => Positioned(
              top: p.y,
              left: p.x,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                  border: Border.fromBorderSide(
                    BorderSide(color: Colors.white),
                  ),
                ),
                padding: const EdgeInsets.all(5),
                child: Text(
                  "",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ]),
      );
    }
    return Positioned(
      top: model.getPositionMode3(positionNumber).y,
      left: model.getPositionMode3(positionNumber).x,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Text(
              "$score/$attempt",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              attempt != 0
                  ? "${(score / attempt * 100).round().toString()}%"
                  : "0%",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getText() {
    if (mode == 0) {
      return "$positionNumber";
    } else if (mode == 1) {
      return "$positionNumber";
    } else if (mode == 2) {
      return "$positionNumber";
    }

    return "";
  }
}
