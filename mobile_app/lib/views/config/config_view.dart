import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_app/views/config/config_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'config_view.form.dart';

@FormView(fields: [
  FormTextField(name: 'angle1'),
  FormTextField(name: 'angle2'),
  FormTextField(name: 'angle3'),
  FormTextField(name: 'angle4'),
  FormTextField(name: 'angle5'),
])
class ConfigView extends StatelessWidget with $ConfigView {
  ConfigView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ConfigViewModel>.reactive(
      viewModelBuilder: () => ConfigViewModel(),
      onModelReady: (viewModel) => listenToFormUpdated(viewModel),
      onDispose: (_) => disposeForm(),
      builder: (context, model, child) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConfigFormField(
                name: "Max Angle 1",
                controller: angle1Controller,
                focusNode: angle1FocusNode,
              ),
              ConfigFormField(
                name: "Max Angle 2",
                controller: angle2Controller,
                focusNode: angle2FocusNode,
              ),
              ConfigFormField(
                name: "Max Angle 3",
                controller: angle3Controller,
                focusNode: angle3FocusNode,
              ),
              ConfigFormField(
                name: "Max Angle 4",
                controller: angle4Controller,
                focusNode: angle4FocusNode,
              ),
              ConfigFormField(
                name: "Max Angle 5",
                controller: angle5Controller,
                focusNode: angle5FocusNode,
              ),
            ],
          ),
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width * 0.8,
            child: OutlinedButton(
              onPressed: () {
                HapticFeedback.vibrate();
                model.updateAngle();
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.green),
              ),
              child:
                  Text("Update Angle", style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
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
