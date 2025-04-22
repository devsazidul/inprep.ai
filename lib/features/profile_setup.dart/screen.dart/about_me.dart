import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:inprep_ai/core/common/styles/global_text_style.dart';
import 'package:inprep_ai/core/common/widgets/auhe_custom_textfiled.dart';
import 'package:inprep_ai/features/profile_screen/model/country_model.dart';
import 'package:inprep_ai/features/profile_setup.dart/controller/country_controller.dart';
import 'package:inprep_ai/features/profile_setup.dart/controller/profile_setupcontroller.dart';
import 'package:inprep_ai/features/profile_setup.dart/widgets/country_ui.dart';

// ignore: must_be_immutable
class AboutMe extends StatelessWidget {
  final ValueNotifier<List<String>> selectedSkillsNotifier;
  final Function(String) onAddSkill;
  final Function(String) onRemoveSkill;

  AboutMe({
    super.key,
    required this.selectedSkillsNotifier,
    required this.onAddSkill,
    required this.onRemoveSkill,
  });

  ProfileSetupcontroller profileSetupcontroller = Get.put(
    ProfileSetupcontroller(),
  );

  @override
  Widget build(BuildContext context) {
    final CountryModel countryModel = Get.put(
      CountryModel(
        selectedCountry: CountryPickerUtils.getCountryByIsoCode('GB'),
      ),
    );
    final CountryController countryController = Get.put(
      CountryController(
        model: countryModel,
        onCountryUpdated: () {
          // Since AboutMe is stateless, we rely on GetX to rebuild the widget
          // The CountryPickerView will rebuild automatically due to GetX dependency
        },
      ),
    );
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "About Me",
                    style: getTextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff212121),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  "City",
                  style: getTextStyle(
                    color: Color(0xff333333),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 8),
                AuthCustomTextField(
                  controller: profileSetupcontroller.citycontroller,
                  text: "",
                ),
                SizedBox(height: 8),
                CountryPickerView(
                  model: countryModel,
                  controller: countryController,
                ),
                SizedBox(height: 8),
                Text(
                  "Skills",
                  style: getTextStyle(
                    color: Color(0xff333333),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(border: OutlineInputBorder()),
                  items:
                      [
                            'UI/UX Design',
                            'Frontend Development',
                            'Backend Development',
                          ]
                          .map(
                            (skill) => DropdownMenuItem(
                              value: skill,
                              child: Text(skill),
                            ),
                          )
                          .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      onAddSkill(value);
                    }
                  },
                  hint: Text('Select a skill'),
                ),
                SizedBox(height: 10),
                ValueListenableBuilder<List<String>>(
                  valueListenable: selectedSkillsNotifier,
                  builder: (context, selectedSkills, child) {
                    return Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children:
                          selectedSkills.map((skill) {
                            return Chip(
                              label: Text(skill,
                              style: getTextStyle(
                                color: Color(0xFF37BB74),
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                              ),
                              deleteIcon: Icon(
                                Icons.cancel,
                                size: 20,
                                color: Color(0xFF37BB74),
                              ),
                              onDeleted: () => onRemoveSkill(skill),
                              backgroundColor: Color(0xffEBF8F1),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(20),
                                
                              ),
                            );
                          }).toList(),
                    );
                  },
                ),
                SizedBox(
                  height: 48,
                ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
