import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_code_picker/src/utils/debouncer.dart';
import 'package:country_code_picker/src/widgets/country_section.dart';
import 'package:country_code_picker/src/widgets/top.dart';
import 'package:flutter/material.dart';

/// {@template country_code_picker_dialog}
/// A widget to display dialog a list of country codes and allow the user
/// to select one.
/// {@endtemplate}
class CountryCodePickerDialog extends StatefulWidget {
  /// {@macro country_code_picker_dialog}
  const CountryCodePickerDialog({
    super.key,
    required this.favoriteCountriesCode,
    required this.onChanged,
    required this.contryCodePickerTitle,
  });

  /// The list of favorite country codes.
  ///
  /// This property is optional and can be null.
  final Iterable<String>? favoriteCountriesCode;

  /// The callback to be called when a country is selected.
  final ValueChanged<Country> onChanged;

  /// Localization for [CountryCodePickerDialog]
  final ContryCodePickerTitle contryCodePickerTitle;

  @override
  State<CountryCodePickerDialog> createState() =>
      _CountryCodePickerDialogState();
}

class _CountryCodePickerDialogState extends State<CountryCodePickerDialog> {
  late final Debouncer _debouncer;
  late final ScrollController _controller;
  Iterable<Country>? _favoriteCountries;
  Iterable<Country>? _searchedCountries;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _debouncer = Debouncer(milliseconds: 300);
    if (widget.favoriteCountriesCode != null) {
      _favoriteCountries = countries.where(
        (e) => widget.favoriteCountriesCode!.contains(e.code),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Top(
            contryCodePickerTitle: widget.contryCodePickerTitle,
            onSearch: (query) => _debouncer.call(() {
              if (query.isEmpty) {
                _searchedCountries = null;
              } else {
                _searchedCountries = countries.where(
                  (e) =>
                      e.code.contains(query) ||
                      e.dialCode.contains(query) ||
                      e.name.toLowerCase().contains(query.toLowerCase()),
                );
              }

              if (mounted) setState(() {});
            }),
          ),
          Expanded(
            child: Scrollbar(
              controller: _controller,
              child: ListView(
                controller: _controller,
                children: [
                  if (_searchedCountries == null) ...[
                    CountrySection(
                      label:
                          widget.contryCodePickerTitle.favoriteCountriesSection,
                      countries: _favoriteCountries,
                      onChanged: widget.onChanged,
                    ),
                    const SizedBox(height: 20),
                    CountrySection(
                      label: widget.contryCodePickerTitle.allCountriesSection,
                      countries: countries,
                      onChanged: widget.onChanged,
                    ),
                  ] else
                    CountrySection(
                      label:
                          widget.contryCodePickerTitle.searchedCountriesSection,
                      countries: _searchedCountries,
                      onChanged: widget.onChanged,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
