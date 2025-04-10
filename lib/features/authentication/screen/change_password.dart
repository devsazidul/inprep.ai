import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/common/styles/global_text_style.dart' show getTextStyle;
import '../../../core/common/widgets/auhe_custom_textfiled.dart'
    show AuthCustomTextField;
import '../../../core/common/widgets/custom_button.dart' show CustomButton;
import '../controller/change_password_controller.dart'
    show SpChangePasswordController;

class ChangePassword extends StatelessWidget {
  final String? email;
  const ChangePassword({super.key, this.email});

  @override
  Widget build(BuildContext context) {
    final SpChangePasswordController controller = Get.put(
      SpChangePasswordController(),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        forceMaterialTransparency: true,
        title: Text(
          'Changed Password',
          style: getTextStyle(
            color: Color(0xFF333333),
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 18.0),
                Text(
                  'Enter Verification Code:',
                  style: getTextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'New Password',
                      style: getTextStyle(
                        color: Color(0xFF333333),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                AuthCustomTextField(
                  controller: controller.newPasswordEditingController,
                  text: 'Enter your Password',
                  onChanged: (value) {
                    controller.newPasswordError.value =
                        ''; // Reset error on change
                  },
                  validator: (value) {
                    if (controller.newPasswordError.value.isNotEmpty) {
                      return controller.newPasswordError.value;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Confirm Password',
                      style: getTextStyle(
                        color: Color(0xFF333333),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                AuthCustomTextField(
                  controller: controller.confirmPasswordEditingController,
                  text: 'Enter your Password',
                  onChanged: (value) {
                    controller.confirmPasswordError.value = '';
                  },
                  validator: (value) {
                    if (controller.confirmPasswordError.value.isNotEmpty) {
                      return controller.confirmPasswordError.value;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 44.0),
                CustomButton(
                  title: 'Change',
                  textcolor: Colors.white,
                  backgroundColor: Color(0xFF37B874),
                  onPress: () {
                    //
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
