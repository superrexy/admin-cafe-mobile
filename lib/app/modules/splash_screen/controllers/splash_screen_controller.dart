import 'package:get/get.dart';

import 'package:admin_cafe_mobile/app/common/constants.dart';
import 'package:admin_cafe_mobile/app/common/storage/storage.dart';
import 'package:admin_cafe_mobile/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:admin_cafe_mobile/app/routes/app_pages.dart';

import '../../../data/api_client.dart';
import '../../../data/authentication_provider.dart';
import '../../../model/response/profile_response.dart';

class SplashScreenController extends GetxController {
  // API CLIENT
  final AuthenticationProvider _authenticationProvider =
      AuthenticationProvider(ApiClient.init());

  final userProfile = ProfileData().obs;
  Future<ProfileResponse?> getProfileUser() async {
    try {
      final res = await _authenticationProvider.profileUser();

      if (res != null) {
        userProfile.update((val) {
          val!.id = res.data?.id;
          val.firstName = res.data?.firstName;
          val.lastName = res.data?.lastName;
          val.email = res.data?.email;
          val.phoneNumber = res.data?.phoneNumber;
          val.address = res.data?.address;
          val.imageProfile = res.data?.imageProfile;
          val.birthDate = res.data?.birthDate;
          val.role = res.data?.role;
          val.createdAt = res.data?.createdAt;
          val.updatedAt = res.data?.updatedAt;
        });

        return res;
      }

      return null;
    } catch (e) {
      print(e);
    }
  }

  Future<void> redirectPage() async {
    await Future.delayed(const Duration(seconds: 5));
    final token = Storage.hasData(Constants.token);
    if (token != null && token) {
      final response = await getProfileUser();
      if (response != null) {
        if (response.data?.role == 'admin') {
          Get.offNamed(Routes.DASHBOARD);
        } else {
          Get.offNamed(Routes.DASHBOARD_USER);
        }
      }

      Get.delete<DashboardController>();
    } else {
      Get.delete<DashboardController>();
      Get.offNamed(Routes.LOGIN);
    }
  }

  @override
  void onInit() {
    super.onInit();
    redirectPage();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
