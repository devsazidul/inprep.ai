import 'package:country_pickers/country.dart';

class CountryModel {
  Country selectedCountry;

  CountryModel({required this.selectedCountry});

  void updateCountry(Country newCountry) {
    selectedCountry = newCountry;
  }
}