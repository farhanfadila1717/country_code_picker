import 'package:flutter/material.dart';
import 'package:flutter_country_code_picker/src/country/country.dart';
import 'package:flutter_country_code_picker/src/widgets/country_card.dart';

/// {@template country_section}
/// A [StatelessWidget] that displays a section for selecting a country.
///
/// The `CountrySection` widget provides a section for selecting a country
/// from a list of countries. The selected country can be reported using
/// the [onChanged] callback.
///
/// The [label] parameter provides a title for the section,
/// while the [countries]parameter provides a list of countries to display.
/// {@endtemplate}
class CountrySection extends StatelessWidget {
  /// {@macro country_section}
  const CountrySection({
    super.key,
    required this.onChanged,
    required this.label,
    required this.countries,
  });

  /// The callback to be called when a country is selected.
  final ValueChanged<Country> onChanged;

  /// The title for this section.
  final String? label;

  /// The list of countries to display.
  final Iterable<Country>? countries;

  @override
  Widget build(BuildContext context) {
    if (countries == null) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Text(
              label!,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
        ...List.generate(countries!.length, (index) {
          final item = countries!.elementAt(index);
          return CountryCard(item: item, onChanged: onChanged);
        })
      ],
    );
  }
}
