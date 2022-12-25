import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_app/datamodels/lap/lap.dart';
import 'package:mobile_app/views/config/config_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

@FormView(fields: [
  FormTextField(name: 'angle1'),
  FormTextField(name: 'angle2'),
  FormTextField(name: 'angle3'),
  FormTextField(name: 'angle4'),
  FormTextField(name: 'angle5'),
])
class ConfigView extends StatelessWidget {
  ConfigView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ConfigViewModel>.reactive(
      viewModelBuilder: () => ConfigViewModel(),
      builder: (context, model, child) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          model.viewTable.indexOf(true) == 0
              ? StopWatch(model: model)
              : TimerWidget(model: model),
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
              Text('Stopwatch'),
              Text('Timer'),
            ],
          ),
        ],
      ),
    );
  }
}

class TimerWidget extends StatelessWidget {
  final ConfigViewModel model;
  const TimerWidget({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: Center(
              child: Text(
                "${model.tMinute}:${model.tSecond}",
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Card(
            child: Container(
              padding: EdgeInsets.all(5),
              child: Text(
                "Minutes",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  model.timerOperation("minute", "add");
                },
                child: Card(
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      "+",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  model.timerOperation("minute", "minus");
                },
                child: Card(
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      "-",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                ),
              )
            ],
          ),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Card(
            child: Container(
              padding: EdgeInsets.all(5),
              child: Text(
                "Second",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  model.timerOperation("second", "add");
                },
                child: Card(
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      "+",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  model.timerOperation("second", "minus");
                },
                child: Card(
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      "-",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                ),
              )
            ],
          ),
        ]),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                model.startT();
              },
              child: Card(
                child: Container(
                  padding: const EdgeInsets.all(5),
                  child: Center(
                    child: Text(
                      "Start",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                model.addLapData();
              },
              child: Card(
                child: Container(
                  padding: const EdgeInsets.all(5),
                  child: Center(
                    child: Text(
                      "Add Lap",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                model.stopT();
              },
              child: Card(
                child: Container(
                  padding: const EdgeInsets.all(5),
                  child: Center(
                    child: Text(
                      "Stop",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                await model.resetLap();
              },
              child: Card(
                child: Container(
                  padding: const EdgeInsets.all(5),
                  child: Center(
                    child: Text(
                      "Reset",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Divider(
          height: 2,
          color: Colors.white,
        ),
        StreamBuilder<QuerySnapshot<Lap>>(
          stream: model.getLapStream(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot<Lap>> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            final childs =
                snapshot.data!.docs.map((DocumentSnapshot<Lap> document) {
              final Lap? data = document.data();
              return GestureDetector(
                onTap: () async {
                  await model.navigate(data!.time);
                },
                child: Card(
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Center(
                      child: Text(
                        data!.time,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: childs,
            );
          },
        ),
      ],
    );
  }
}

class StopWatch extends StatelessWidget {
  final ConfigViewModel model;

  const StopWatch({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: Center(
              child: Text(
                "${model.swMinute}:${model.swSecond}",
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                model.startSw();
              },
              child: Card(
                child: Container(
                  padding: const EdgeInsets.all(5),
                  child: Center(
                    child: Text(
                      "Start",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                model.resetSw();
              },
              child: Card(
                child: Container(
                  padding: const EdgeInsets.all(5),
                  child: Center(
                    child: Text(
                      "Reset",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                model.stopSw();
              },
              child: Card(
                child: Container(
                  padding: const EdgeInsets.all(5),
                  child: Center(
                    child: Text(
                      "Stop",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

class ConfigFormField extends StatelessWidget {
  const ConfigFormField({
    Key? key,
    required this.name,
    required this.controller,
    required this.focusNode,
  }) : super(key: key);

  final String name;
  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(
            hintText: name,
            hintStyle: TextStyle(color: Colors.white),
            border: OutlineInputBorder(),
            enabledBorder: const OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
            ),
          ),
          style: const TextStyle(color: Colors.white),
          controller: controller,
          focusNode: focusNode,
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
