import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:inprep_ai/core/common/styles/global_text_style.dart';
import 'package:inprep_ai/features/profile_screen/model/country_model.dart';
import 'package:inprep_ai/features/profile_setup.dart/controller/country_controller.dart';

class CountryPickerView extends StatelessWidget {
  final CountryModel model;
  final CountryController controller;

  // ignore: use_super_parameters
  const CountryPickerView({
    Key? key,
    required this.model,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Country',
          style: getTextStyle(
            fontSize: 16, 
            color: Color(0xff333333), 
            fontWeight: FontWeight.w400,
            ),
        ),
        SizedBox(height: 5),
        GestureDetector(
          onTap: () => controller.openCountryPickerDialog(context),
          child: Container(
            // Full width (minus padding from parent)
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Color(0xff333333)
                ),
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            child: Row(
              children: [
                CountryPickerUtils.getDefaultFlagImage(model.selectedCountry),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    model.selectedCountry.name,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Icon(Icons.arrow_drop_down_outlined, 
                size: 24,
                color: Color(0xff3A4C67)
                ),
                
              ],
            ),
          ),
        ),
      ],
    );
  }
}