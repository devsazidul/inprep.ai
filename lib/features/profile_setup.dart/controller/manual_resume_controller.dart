import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:inprep_ai/features/personalized_interviewers/view/personalized_interviewer_screen.dart';
import 'package:inprep_ai/features/profile_setup.dart/controller/about_me_contrller.dart';
import 'package:inprep_ai/features/profile_setup.dart/controller/education_controller.dart';
import 'package:inprep_ai/features/profile_setup.dart/controller/experience_controller.dart';
import 'package:inprep_ai/features/profile_setup.dart/models/resume_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

// Assume these controllers are passed or accessible:
final AboutMeController aboutMeController = Get.find();
final ExperienceController experienceController = Get.find();
final EducationController educationController = Get.find();

Future<void> saveResume() async {
  try {
    print('DEBUG: Starting saveResume function');
    EasyLoading.show(status: "Saving resume...");
    print('DEBUG: EasyLoading shown with status "Saving resume..."');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('DEBUG: SharedPreferences instance obtained');
    String? accessToken = prefs.getString('approvalToken');
    print('DEBUG: Access token retrieved: $accessToken');
    if (accessToken == null || accessToken.isEmpty) {
      print('DEBUG: Access token is null or empty, throwing exception');
      throw Exception('No access token found.');
    }

    // Prepare Address
    final address = Address(
      city: aboutMeController.cityController.text,
      country: aboutMeController.countryModel.initialCountry?.name ?? '',
    );
    print('DEBUG: Address created - City: ${address.city}, Country: ${address.country}');

    // Prepare technicalSkills
    List<String> technicalSkills =
        aboutMeController.skills
            .where(
              (skill) =>
                  experienceController.selectedSkills.contains(skill.name),
            )
            .map((e) => e.name ?? '')
            .toList();
    print('DEBUG: Technical skills prepared: $technicalSkills');

    // Prepare Experience
    List<Experience> experiences =
        experienceController.experienceForms.map((formId) {
          final controllers = experienceController.formControllers[formId]!;
          final country = controllers.countryModel.initialCountry?.name ?? '';
          print('DEBUG: Processing experience form ID: $formId');
          print('DEBUG: Experience country: $country');

          return Experience(
            jobTitle: controllers.jobTitleController.text,
            company: controllers.employerNameController.text,
            city: controllers.cityController.text,
            country: country,
            responsibilities: controllers.responsibilitiesController.text,
            skills: experienceController.selectedSkills.toList(),
            startDate: experienceController.selectDate.value,
            endDate: experienceController.selectDate1.value,
          );
        }).toList();
    print('DEBUG: Experiences prepared: ${experiences.map((e) => {
          'jobTitle': e.jobTitle,
          'company': e.company,
          'city': e.city,
          'country': e.country,
          'responsibilities': e.responsibilities,
          'skills': e.skills,
          'startDate': e.startDate,
          'endDate': e.endDate
        }).toList()}');

    // Prepare Education list
    List<Education> educationList = [];
    for (int i = 0; i < educationController.rowCount.value; i++) {
      educationList.add(
        Education(
          institution: educationController.schoolNameControllers[i].text,
          degree: educationController.educationLevels[i],
          majorField: educationController.majorControllers[i].text,
          startDate: educationController.startDates[i],
          completionDate: educationController.endDates[i],
        ),
      );
      print('DEBUG: Education entry $i - Institution: ${educationList[i].institution}, '
          'Degree: ${educationList[i].degree}, Major: ${educationList[i].majorField}, '
          'Start: ${educationList[i].startDate}, End: ${educationList[i].completionDate}');
    }
    print('DEBUG: Education list prepared: ${educationList.length} entries');

    // Build ResumeData object
    final resumeData = ResumeData(
      summary: aboutMeController.summaryController.text,
      address: address,
      technicalSkills: technicalSkills,
      experience:
          experiences.isNotEmpty
              ? experiences.first
              : Experience(
                jobTitle: '',
                company: '',
                city: '',
                country: '',
                responsibilities: '',
                skills: [],
                startDate: '',
                endDate: '',
              ),
      education: educationList,
    );
    print('DEBUG: ResumeData created - Summary: ${resumeData.summary}, '
        'Address: {City: ${resumeData.address.city}, Country: ${resumeData.address.country}}, '
        'TechnicalSkills: ${resumeData.technicalSkills}, '
        'Experience: {JobTitle: ${resumeData.experience.jobTitle}, Company: ${resumeData.experience.company}}, '
        'Education: ${resumeData.education.length} entries');

    // Send PUT request
    final Uri url = Uri.parse(
      'https://ai-interview-server-3cg1.onrender.com/api/v1/resume/update-resume',
    );
    print('DEBUG: URL for PUT request: $url');
    final response = await http.put(
      url,
      headers: {
        'Authorization': accessToken,
        'Content-Type': 'application/json',
      },
      body: jsonEncode(resumeData.toJson()),
    );
    print('DEBUG: HTTP PUT request sent with headers: {Authorization: $accessToken, Content-Type: application/json}, '
        'Body: ${jsonEncode(resumeData.toJson())}');
    print('DEBUG: Response status code: ${response.statusCode}');
    print('DEBUG: Response body: ${response.body}');

    if (response.statusCode == 200) {
      print('DEBUG: Resume updated successfully, navigating to PersonalizedInterviewerScreen');
      EasyLoading.showSuccess('Resume updated successfully');
      Get.to(PersonalizedInterviewerScreen());
    } else {
      print('DEBUG: Failed to update resume - Status: ${response.statusCode}, Body: ${response.body}');
      EasyLoading.showError('Failed to update resume: ${response.body}');
    }
  } catch (e) {
    print('DEBUG: Error caught in saveResume: $e');
    EasyLoading.showError('Error saving resume: $e');
  } finally {
    print('DEBUG: Dismissing EasyLoading');
    EasyLoading.dismiss();
  }
}