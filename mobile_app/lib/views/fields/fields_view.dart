import 'package:flutter/material.dart';
import 'package:mobile_app/views/fields/fields_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:ext_video_player/ext_video_player.dart';

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
          const Image(
            image: AssetImage('lib/assets/court.jpg'),
          ),
          const SizedBox(
            height: 10,
            width: 10,
          ),
          (model.ready
              ? AspectRatio(
                  aspectRatio: model.controller.value.aspectRatio,
                  child: VideoPlayer(model.controller),
                )
              : Container()),
          const SizedBox(
            height: 10,
            width: 10,
          ),
          const ButtonBar(
            children: [Text("oi")],
          )
        ],
      ),
    );
  }
}
