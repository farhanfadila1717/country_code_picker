import 'dart:ui' show window;

import 'package:flutter/material.dart';
import 'package:flutter_country_code_picker/src/country/country.dart';
import 'package:flutter_country_code_picker/src/dialog/country_code_picker_dialog.dart';
import 'package:flutter_country_code_picker/src/utils/country_code_picker_title.dart';

/// {@template country_code_builder}
/// Create custom widget build for represent [CountryCodePicker]
/// this parameter callback contains ([Country] selectedCountry, [VoidCallback]
/// showDialog)
/// {@endtemplate}
typedef CountyCodeBuilder = Widget Function(Country, VoidCallback);

/// {@template flutter_country_code_picker}
/// [CountryCodePicker] is widget for pick
/// {@endtemplate}
class CountryCodePicker extends StatefulWidget {
  /// {@macro flutter_country_code_picker}
  const CountryCodePicker({
    super.key,
    required this.initialCountryCode,
    this.countyCodeBuilder,
    this.favoriteCountriesCode,
    this.onChanged,
    this.contryCodePickerTitle = ContryCodePickerTitle.id,
  });

  /// Initial selected [Country]
  /// field with [Country] code
  final String initialCountryCode;

  /// {@macro country_code_builder}
  final CountyCodeBuilder? countyCodeBuilder;

  /// If you need highlight favorite countries
  final Iterable<String>? favoriteCountriesCode;

  /// The callback to be called when a country is selected.
  final ValueChanged<Country>? onChanged;

  /// Localization for [CountryCodePicker]
  final ContryCodePickerTitle contryCodePickerTitle;

  @override
  State<CountryCodePicker> createState() => _CountryCodePickerState();
}

class _CountryCodePickerState extends State<CountryCodePicker> {
  late Country _selectedCountry;

  @override
  void initState() {
    super.initState();
    _selectedCountry = countries.firstWhere(
      (e) => e.code == widget.initialCountryCode,
      orElse: () => emptyCountry,
    );
  }

  /// A function to show [CountryCodePickerDialog]
  Future<void> _changeCountry() async {
    final mediaQuery = MediaQueryData.fromWindow(window);
    final margin = mediaQuery.viewPadding;
    final height = mediaQuery.size.height;

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      constraints: BoxConstraints(
        // screen height - top height safearea
        maxHeight: height - margin.top,
      ),
      clipBehavior: Clip.hardEdge,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      builder: (_) => CountryCodePickerDialog(
        favoriteCountriesCode: widget.favoriteCountriesCode,
        onChanged: onChanged,
        contryCodePickerTitle: widget.contryCodePickerTitle,
      ),
    );
  }

  void onChanged(Country country) {
    if (!mounted) return;

    _selectedCountry = country;
    widget.onChanged?.call(_selectedCountry);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (widget.countyCodeBuilder != null) {
      /// Custom widget for [CountryCodePicker]
      return widget.countyCodeBuilder!(_selectedCountry, _changeCountry);
    } else {
      /// Default widget for [CountryCodePicker]
      return Material(
        type: MaterialType.transparency,
        child: Tooltip(
          message: widget.contryCodePickerTitle.tooltip,
          child: InkWell(
            onTap: _changeCountry,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _selectedCountry.flag,
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(width: 8),
                Text('+${_selectedCountry.dialCode}'),
                const Icon(Icons.arrow_drop_down_rounded),
              ],
            ),
          ),
        ),
      );
    }
  }
}
