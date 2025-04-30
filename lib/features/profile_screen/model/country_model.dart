// import 'package:country_pickers/country.dart';

// class CountryModel {
//   Country selectedCountry;

//   CountryModel({required this.selectedCountry});

//   void updateCountry(Country newCountry) {
//     selectedCountry = newCountry;
//   }
// }

import 'package:country_pickers/country.dart';
import 'package:get/get.dart';

class CountryModel {
  Rx<Country> selectedCountry;

  CountryModel({required Country initialCountry})
      : selectedCountry = initialCountry.obs;

  void updateCountry(Country newCountry) {
    selectedCountry.value = newCountry;
  }
}