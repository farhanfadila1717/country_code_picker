/// {@template flutter_country_code_picker_title}
/// A class that represents the title of the country code picker.
/// {@endtemplate}
class ContryCodePickerTitle {
  /// {@macro flutter_country_code_picker_title}
  const ContryCodePickerTitle({
    required this.tooltip,
    required this.favoriteCountriesSection,
    required this.allCountriesSection,
    required this.searchedCountriesSection,
    required this.searchFieldTitle,
    required this.searchFieldHint,
  });

  /// The tooltip for the country code picker.
  final String tooltip;

  /// The title for the favorite countries section.
  final String favoriteCountriesSection;

  /// The title for the all countries section.
  final String allCountriesSection;

  /// The title for the searched countries section.
  final String searchedCountriesSection;

  /// The title for the search field.
  final String searchFieldTitle;

  /// The hint for search field
  final String searchFieldHint;

  /// Default [ContryCodePickerTitle] in Indonesian Language
  static const id = ContryCodePickerTitle(
    tooltip: 'Pilih kode telfon',
    favoriteCountriesSection: 'Negara Populer',
    allCountriesSection: 'Semua Negara',
    searchedCountriesSection: 'Hasil Pencarian',
    searchFieldTitle: 'Cari kode negara',
    searchFieldHint: 'Ketik nama atau kode negara',
  );
}
