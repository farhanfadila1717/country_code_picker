import 'package:flutter/material.dart';
import 'package:flutter_country_code_picker/src/country/country.dart';

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
    final theme = Theme.of(context);
    if (countries == null) return const SizedBox.shrink();
    return ColoredBox(
      color: theme.scaffoldBackgroundColor,
      child: Column(
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
            return ListTile(
              tileColor: theme.scaffoldBackgroundColor,
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              shape: const Border(
                bottom: BorderSide(
                  color: Color(0x3DC2C2C2),
                ),
              ),
              title: Row(
                children: [
                  Text(item.flag),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      item.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                ],
              ),
              trailing: Text('+${item.dialCode}'),
              onTap: () {
                Navigator.pop(context);
                onChanged(item);
              },
            );
          })
        ],
      ),
    );
  }
}
