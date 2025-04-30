import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inprep_ai/core/common/styles/global_text_style.dart';
import 'package:inprep_ai/core/common/widgets/auhe_custom_textfiled.dart';
import 'package:inprep_ai/core/utils/constants/colors.dart';
import 'package:inprep_ai/features/profile_screen/model/country_model.dart';
import 'package:inprep_ai/features/profile_setup.dart/controller/country_controller.dart';
import 'package:inprep_ai/features/profile_setup.dart/controller/experience_controller.dart';
import 'package:inprep_ai/features/profile_setup.dart/controller/profile_setupcontroller.dart';
import 'package:inprep_ai/features/profile_setup.dart/widgets/country_ui.dart';
import 'package:uuid/uuid.dart';

// ignore: must_be_immutable
class Experience extends StatelessWidget {
  Experience({super.key});

  final ProfileSetupcontroller profileSetupcontroller =
      Get.find<ProfileSetupcontroller>();

  @override
  Widget build(BuildContext context) {
    // Use GetX to manage the list of experience forms
    final experienceForms = <String>[].obs; // Store unique IDs for each form
    final formControllers = <String, ExperienceFormControllers>{}.obs;

    // Add the first form by default
    final initialFormId = const Uuid().v4();
    experienceForms.add(initialFormId);
    formControllers[initialFormId] = ExperienceFormControllers();

    // Create the necessary values for the arguments
    final selectedSkillsNotifier = ValueNotifier<List<String>>([]);
    void onAddSkill(String skill) {
      selectedSkillsNotifier.value = [...selectedSkillsNotifier.value, skill];
    }

    void onRemoveSkill(String skill) {
      selectedSkillsNotifier.value =
          selectedSkillsNotifier.value.where((item) => item != skill).toList();
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Experience",
                        style: getTextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xff212121),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Dynamically render each experience form
                    ...experienceForms.map((formId) {
                      final controllers = formControllers[formId]!;
                      return ExperienceForm(
                        key: ValueKey(formId),
                        controllers: controllers,
                        onRemove:
                            experienceForms.length > 1
                                ? () {
                                  experienceForms.remove(formId);
                                  formControllers.remove(formId);
                                }
                                : null,
                        selectedSkillsNotifier: selectedSkillsNotifier,
                        onAddSkill: onAddSkill,
                        onRemoveSkill: onRemoveSkill,
                      );
                    }).toList(),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        // Add a new form
                        final newFormId = const Uuid().v4();
                        experienceForms.add(newFormId);
                        formControllers[newFormId] =
                            ExperienceFormControllers();
                      },
                      child: Container(
                        height: 48,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: const Color(0xff37B874),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Add More Experience",
                            style: getTextStyle(
                              color: const Color(0xffffffff),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Class to hold controllers for each form
class ExperienceFormControllers {
  final TextEditingController jobTitleController = TextEditingController();
  final TextEditingController employerNameController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController responsibilitiesController =
      TextEditingController();
  final ExperienceController experienceController = ExperienceController();
  final ValueNotifier<bool> isChecked = ValueNotifier<bool>(false);

  final CountryModel countryModel = CountryModel(
    initialCountry: CountryPickerUtils.getCountryByIsoCode('GB'),
  );
  late final CountryController countryController;

  ExperienceFormControllers() {
    countryController = CountryController(
      model: countryModel,
      onCountryUpdated: () {},
    );
  }

  void dispose() {
    jobTitleController.dispose();
    employerNameController.dispose();
    cityController.dispose();
    responsibilitiesController.dispose();
  }
}

// Widget for each experience form
class ExperienceForm extends StatelessWidget {
  final ExperienceFormControllers controllers;
  final VoidCallback? onRemove;
  final ValueNotifier<List<String>> selectedSkillsNotifier;
  final Function(String) onAddSkill;
  final Function(String) onRemoveSkill;

  const ExperienceForm({
    super.key,
    required this.controllers,
    this.onRemove,
    required this.selectedSkillsNotifier,
    required this.onAddSkill,
    required this.onRemoveSkill,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (onRemove != null) ...[
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: onRemove,
            ),
          ),
        ],
        Text(
          "Job Title",
          style: getTextStyle(
            color: const Color(0xff333333),
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 8),
        AuthCustomTextField(
          controller: controllers.jobTitleController,
          text: "",
        ),
        Text(
          "Employer Name",
          style: getTextStyle(
            color: const Color(0xff333333),
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 8),
        AuthCustomTextField(
          controller: controllers.employerNameController,
          text: "",
        ),
        Text(
          "City",
          style: getTextStyle(
            color: const Color(0xff333333),
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 8),
        AuthCustomTextField(controller: controllers.cityController, text: ""),
        const SizedBox(height: 8),
        CountryPickerView(
          model: controllers.countryModel,
          controller: controllers.countryController,
        ),
        const SizedBox(height: 8),
        Text(
          "Responsibilities",
          style: getTextStyle(
            color: const Color(0xff333333),
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controllers.responsibilitiesController,
          maxLines: 4,
          decoration: const InputDecoration(border: OutlineInputBorder()),
        ),
        const SizedBox(height: 10),
        Text(
          "Skills Used",
          style: getTextStyle(
            color: const Color(0xff333333),
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          decoration: const InputDecoration(border: OutlineInputBorder()),
          items:
              ['UI/UX Design', 'Frontend Development', 'Backend Development']
                  .map(
                    (skill) =>
                        DropdownMenuItem(value: skill, child: Text(skill)),
                  )
                  .toList(),
          onChanged: (value) {
            if (value != null) {
              onAddSkill(value); // Remove widget. prefix
            }
          },
          hint: Text(
            'Select a skill',
            style: getTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.textSecondary,
            ),
          ),
        ),
        const SizedBox(height: 10),
        ValueListenableBuilder<List<String>>(
          valueListenable: selectedSkillsNotifier,
          builder: (context, selectedSkills, child) {
            return Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children:
                  selectedSkills.map((skill) {
                    return Chip(
                      label: Text(
                        skill,
                        style: getTextStyle(
                          color: const Color(0xFF37BB74),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      deleteIcon: const Icon(
                        Icons.cancel,
                        size: 20,
                        color: Color(0xFF37BB74),
                      ),
                      onDeleted:
                          () => onRemoveSkill(skill), // Remove widget. prefix
                      backgroundColor: const Color(0xffEBF8F1),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    );
                  }).toList(),
            );
          },
        ),

        const SizedBox(height: 8),
        Text(
          "Start Date",
          style: getTextStyle(
            color: const Color(0xff333333),
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 8),
        Obx(
          () => Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF78828A)),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    startDate(context, controllers.experienceController);
                  },
                  child: const Icon(Icons.calendar_month),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select a day',
                      style: getTextStyle(
                        color: const Color(0xFF565656),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      controllers.experienceController.selectDate.value,
                      style: getTextStyle(
                        color: const Color(0xFF00BA0B),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "End Date",
          style: getTextStyle(
            color: const Color(0xff333333),
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        Obx(
          () => Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF78828A)),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    endDate(context, controllers.experienceController);
                  },
                  child: const Icon(Icons.calendar_month),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select a day',
                      style: getTextStyle(
                        color: const Color(0xFF565656),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      controllers.experienceController.selectDate1.value,
                      style: getTextStyle(
                        color: const Color(0xFF00BA0B),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Are you still on the job?",
              style: getTextStyle(
                color: const Color(0xff333333),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            ValueListenableBuilder<bool>(
              valueListenable: controllers.isChecked,
              builder: (context, value, child) {
                return Checkbox(
                  value: value,
                  onChanged: (bool? newValue) {
                    controllers.isChecked.value = newValue ?? false;
                    if (newValue == true) {
                      final DateTime now = DateTime.now();
                      String formattedDate =
                          "${now.day.toString().padLeft(2, '0')}.${now.month.toString().padLeft(2, '0')}.${now.year}";
                      controllers.experienceController.updateEndDate(
                        formattedDate,
                      );
                    }
                  },
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Future<void> startDate(
    BuildContext context,
    ExperienceController controller,
  ) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF00BA0B),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      String formattedDate =
          "${pickedDate.day.toString().padLeft(2, '0')}.${pickedDate.month.toString().padLeft(2, '0')}.${pickedDate.year}";
      controller.updateStartDate(formattedDate);
    }
  }

  Future<void> endDate(
    BuildContext context,
    ExperienceController controller,
  ) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF00BA0B),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      String formattedDate =
          "${pickedDate.day.toString().padLeft(2, '0')}.${pickedDate.month.toString().padLeft(2, '0')}.${pickedDate.year}";
      controller.updateEndDate(formattedDate);
    }
  }
}
