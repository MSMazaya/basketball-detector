import 'package:stacked/stacked.dart';
import 'package:ext_video_player/ext_video_player.dart';

class FieldsViewModel extends BaseViewModel {
  late VideoPlayerController controller;
  bool ready = false;
  void initState() {
    controller = VideoPlayerController.network(
      'rtmp://10.0.2.2:1935/stream/pupils_trace',
    )..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        ready = true;
        notifyListeners();
        controller.play();
      });
  }
}
