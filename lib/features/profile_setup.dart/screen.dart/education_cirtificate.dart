import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inprep_ai/core/common/styles/global_text_style.dart';
import 'package:inprep_ai/core/utils/constants/icon_path.dart';
import 'package:inprep_ai/features/profile_setup.dart/controller/education_controller.dart';

class EducationCertificate extends StatelessWidget {
  EducationCertificate({super.key});

  final EducationController educationController = Get.put(
    EducationController(),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Education & Certificate",
                    style: TextStyle(
                      color: Color(0xff212121),
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Use Obx to reactively rebuild when rowCount changes
                Obx(
                  () => ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: educationController.rowCount.value,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // First Column (Institute Name)
                            Flexible(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Institute Name",
                                    style: getTextStyle(
                                      color: const Color(0xff333333),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  const TextField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            // Second Column (Degree)
                            Flexible(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Degree",
                                    style: getTextStyle(
                                      color: const Color(0xff333333),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  DropdownButtonFormField<String>(
                                    value: 'CSE',
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                    ),
                                    items:
                                        ['CSE', 'EEE', 'ETE']
                                            .map(
                                              (time) => DropdownMenuItem(
                                                value: time,
                                                child: Text(time),
                                              ),
                                            )
                                            .toList(),
                                    onChanged: (_) {},
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    educationController.addRow();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.88,
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xffffffff),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xffEBEDF0),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Add",
                              style: getTextStyle(
                                color: const Color(0xff3A4C67),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Icon(
                              Icons.add,
                              color: Color(0xff3A4C67),
                              size: 14,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Upload a Certificate",
                  style: getTextStyle(
                    color: Color(0xff37BB74),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 10),
                Obx(
                  () => ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: educationController.certificateCount.value,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: GestureDetector(
                              onTap: () async {
                                await educationController.pickFile(index);
                              },
                              child: Container(
                                height: 119,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: const Color(0xffEbf8f1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(14),
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        IconPath.backup,
                                        height: 32,
                                        width: 32,
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        "Select File",
                                        style: getTextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xff212121),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        "Supported Formats: JPEG, PNG, PDF, DOC",
                                        style: getTextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xff898989),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Only show if file is selected for this index
                          Obx(() {
                            final fileName =
                                educationController.selectedFileNames.length >
                                        index
                                    ? educationController
                                        .selectedFileNames[index]
                                    : null;
                            return fileName != null
                                ? Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    "Selected File: $fileName",
                                    style: getTextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff212121),
                                    ),
                                  ),
                                )
                                : SizedBox.shrink();
                          }),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(height: 18),
                GestureDetector(
                  onTap: () {
                    educationController.addCertificate();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.88,
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xffffffff),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xffEBEDF0),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Add",
                              style: getTextStyle(
                                color: const Color(0xff3A4C67),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Icon(
                              Icons.add,
                              color: Color(0xff3A4C67),
                              size: 14,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                Text(
                  "Awards",
                  style: getTextStyle(
                    color: Color(0xff333333),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 8),
                Obx(
                  () => ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: educationController.awardCount.value,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: TextField(),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    educationController.addAwards();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.88,
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xffffffff),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xffEBEDF0),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Add",
                              style: getTextStyle(
                                color: const Color(0xff3A4C67),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Icon(
                              Icons.add,
                              color: Color(0xff3A4C67),
                              size: 14,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
