import 'package:admin_cafe_mobile/app/common/constants.dart';
import 'package:admin_cafe_mobile/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';
import 'package:url_launcher/url_launcher.dart';

class LoadingPaymentController extends GetxController {
  final arguments = Get.arguments;
  IO.Socket socket = IO.io(Constants.baseUrl,
      OptionBuilder().setTransports(['websocket']).enableAutoConnect().build());

  Future<void> redirectToPaymentApp() async {
    if (!await launchUrl(
      Uri.parse(arguments['payment_url']),
      mode: LaunchMode.externalNonBrowserApplication,
    )) {
      throw Exception('Could not launch ${arguments['payment_url']}');
    }
  }

  Future<void> joinRoomOrder() async {
    socket.onConnect((_) {
      socket.emit('join', "booking_${arguments["booking_id"]}");
    });

    if (arguments['payment_url'] != null) {
      Future.delayed(const Duration(seconds: 2), () async {
        await redirectToPaymentApp();
      });
    }

    socket.on("booking_${arguments["booking_id"]}", (data) {
      if (data["status"] == "success") {
        Get.offNamed(Routes.PAYMENT_SUCCESS, arguments: {
          "booking_id": arguments["booking_id"],
        });

        socket.emit("leave", "booking_${arguments["booking_id"]}");
        socket.disconnect();
      } else if (data["status"] == "cancel" || data["status"] == "deny") {
        Get.offNamed(Routes.PAYMENT_FAILED, arguments: {
          "booking_id": arguments["booking_id"],
          "payment_url": arguments["payment_url"],
        });

        socket.emit("leave", "booking_${arguments["booking_id"]}");
        socket.disconnect();
      } else if (data["status"] == "expire") {
        Get.offNamed(Routes.PAYMENT_FAILED, arguments: {
          "booking_id": arguments["booking_id"],
        });

        socket.emit("leave", "booking_${arguments["booking_id"]}");
        socket.disconnect();
      }
    });
  }

  @override
  void onInit() {
    joinRoomOrder();

    Future.delayed(const Duration(minutes: 1), () {
      Get.offNamed(Routes.PAYMENT_FAILED, arguments: {
        "booking_id": arguments["booking_id"],
        "payment_url": arguments["payment_url"],
      });
    });

    super.onInit();
  }
}
