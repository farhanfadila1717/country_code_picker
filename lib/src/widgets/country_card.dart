import 'package:flutter/material.dart';
import 'package:flutter_country_code_picker/src/country/country.dart';

/// {@template country_card}
/// [CountryCard] is used to display information
/// about a Country object on a card
/// {@endtemplate}
class CountryCard extends StatelessWidget {
  /// {@macro country_card}
  const CountryCard({
    super.key,
    required this.item,
    required this.onChanged,
  });

  /// The Country which will be displayed on the card.
  final Country item;

  /// The callback to be called when a country is selected.
  final ValueChanged<Country> onChanged;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        shape: const Border(
          bottom: BorderSide(
            color: Color(0x3DC2C2C2),
          ),
        ),
        hoverColor: Colors.amber,
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
      ),
    );
  }
}
