import 'package:mobile_app/app/app.locator.dart';
import 'package:mobile_app/services/firestore_service.dart';
import 'package:stacked/stacked.dart';
import 'package:ext_video_player/ext_video_player.dart';

class FieldsViewModel extends BaseViewModel {
  late VideoPlayerController controller;
  bool ready = false;
  final _hardwareConfigService = locator<FirestoreService>().hardwareConfig;

  void initState() async {
    final doc = await _hardwareConfigService.get();
    final data = doc.data() as Map<String, dynamic>;
    final ip = data['ip'];

    _hardwareConfigService.snapshots().listen((event) {
      final data = event.data() as Map<String, dynamic>;
      final ip = data['ip'];
      controller =
          VideoPlayerController.network('rtmp://$ip/stream/pupils_trace');

      notifyListeners();

      controller.initialize().then((_) {
        ready = true;
        notifyListeners();
        controller.play();
      });
    });

    controller = VideoPlayerController.network(
      'rtmp://$ip/stream/pupils_trace',
    )..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        ready = true;
        notifyListeners();
        controller.play();
      });
  }
}
