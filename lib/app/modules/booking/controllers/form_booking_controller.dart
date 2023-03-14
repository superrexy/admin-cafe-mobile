import 'package:admin_cafe_mobile/app/data/booking_provider.dart';
import 'package:admin_cafe_mobile/app/data/data.dart';
import 'package:admin_cafe_mobile/app/model/request/booking_request.dart';
import 'package:admin_cafe_mobile/app/model/response/foodndrink_response.dart';
import 'package:admin_cafe_mobile/app/model/response/room_response.dart';
import 'package:admin_cafe_mobile/app/modules/booking/controllers/booking_controller.dart';
import 'package:admin_cafe_mobile/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:admin_cafe_mobile/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormBookingController extends GetxController {
  // API CLIENT
  final BookingProvider _bookingProvider = BookingProvider(ApiClient.init());

  // Booking Controller
  final BookingController bookingController = Get.find();

  // DASHBOARD CONTROLLER
  final DashboardController dashboardController = Get.find();

  // Observable
  final tempFoodsChecklist = <FoodnDrinkData>[].obs;
  final tempRooms = <RoomData>[].obs;

  // Form
  final GlobalKey<FormState> bookingFormKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController roomController = TextEditingController();
  final TextEditingController foodController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  final foodsOrders = <Foodsndrink>[].obs;

  // Total Room & Food Price
  final totalRoomPrice = 0.obs;
  final totalFoodPrice = 0.obs;
  final totalPrice = 0.obs;

  // Calculate Total Room Price & Food Price
  Future<void> calculateTotalPrice() async {
    totalRoomPrice.value = 0;
    totalFoodPrice.value = 0;

    for (var element in tempFoodsChecklist) {
      totalFoodPrice.value += element.harga * element.quantity!;
    }

    for (var element in tempRooms) {
      totalRoomPrice.value += element.harga;
    }

    // Calculate Total Price
    totalPrice.value = totalRoomPrice.value + totalFoodPrice.value;
  }

  // Form Init
  void formInit() {
    // ignore: prefer_interpolation_to_compose_strings
    nameController.text = dashboardController.userProfile.value.firstName! +
        " " +
        dashboardController.userProfile.value.lastName;

    emailController.text = dashboardController.userProfile.value.email!;
  }

  // To Payment Page
  Future<void> onSubmit() async {
    if (bookingFormKey.currentState!.validate()) {
      if (dashboardController.userProfile.value.role != "admin") {
        Get.toNamed(Routes.PAYMENT);
      } else {
        createBooking(paymentType: "cash");
      }
    }
  }

  // Create Booking
  Future<void> createBooking(
      {required String paymentType, String? mobileNumber}) async {
    try {
      for (var element in tempFoodsChecklist) {
        foodsOrders.add(Foodsndrink(
          foodDrinkId: element.id,
          amount: element.quantity!,
          note: element.note,
        ));
      }

      final BookingRequest request = BookingRequest(
        namaPemesan: nameController.text,
        emailPemesan: emailController.text,
        tglPemesanan: DateTime.parse(dateController.text),
        roomId: tempRooms.first.id.toString(),
        foodsndrinks: foodsOrders,
        paymentType: paymentType,
        mobileNumber: mobileNumber,
      );

      final response = await _bookingProvider.createBooking(request);

      if (response != null) {
        bookingController.getBookingsData();
        dashboardController.getAllData();

        if (dashboardController.userProfile.value.role == "user") {
          Get.offNamedUntil(
              Routes.PAYMENT_LOADING,
              arguments: {
                "booking_id": response.id,
                "payment_url": response.paymentUrl,
              },
              (route) => (route as GetPageRoute).routeName == Routes.BOOKING);

          return;
        }

        Get.back();
        Get.snackbar("Success", "Pesanan berhasil ditambahkan",
            backgroundColor: Colors.green, colorText: Colors.white);
      }
    } catch (e) {
      Get.printError(info: e.toString());
      Get.snackbar("Terdapat Kesalahan", "Something went wrong",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    if (dashboardController.userProfile.value.role == "user") {
      formInit();
    }

    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
