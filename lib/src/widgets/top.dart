import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_country_code_picker/src/utils/country_code_picker_title.dart';

/// {@template top}
/// [Top] section of dialog widget
/// {@endtemplate}
class Top extends StatefulWidget {
  /// {@macro top}
  const Top({
    super.key,
    required this.onSearch,
    required this.contryCodePickerTitle,
  });

  /// A callback for providing a search value when it has changed.
  ///
  /// The `onSearch` callback is called whenever the search value changes.
  /// This can be triggered by user input, programmatic changes,
  /// or other events.
  /// The `onSearch` callback provides the updated search value as a string.
  ///
  /// @param String value: The updated search value.
  ///
  final ValueChanged<String> onSearch;

  /// Localization for [Top] widget
  final ContryCodePickerTitle contryCodePickerTitle;

  @override
  State<Top> createState() => _TopState();
}

class _TopState extends State<Top> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ColoredBox(
      color: theme.scaffoldBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: SizedBox(
                width: 40,
                height: 2,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Color(0xFFC2C2C2),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                widget.contryCodePickerTitle.searchFieldTitle,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            TextField(
              controller: _controller,
              onChanged: widget.onSearch,
              decoration: InputDecoration(
                fillColor: const Color(0xFFC2C2C2),
                prefixIcon: const Icon(CupertinoIcons.search, size: 20),
                contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                hintText: widget.contryCodePickerTitle.searchFieldHint,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
