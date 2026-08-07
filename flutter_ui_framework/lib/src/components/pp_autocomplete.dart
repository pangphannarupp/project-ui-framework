import 'package:flutter/material.dart';

class PPAutocomplete<T extends Object> extends StatelessWidget {
  final String? label;
  final String? placeholder;
  final T? value;
  final ValueChanged<T?>? onChanged;
  final List<T> options;
  final String Function(T) displayStringForOption;
  final Widget? iconLeft;
  final bool filter;

  const PPAutocomplete({
    Key? key,
    this.label,
    this.placeholder,
    this.value,
    this.onChanged,
    required this.options,
    this.displayStringForOption = _defaultStringForOption,
    this.iconLeft,
    this.filter = true,
  }) : super(key: key);

  static String _defaultStringForOption(dynamic option) {
    return option.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF1A2A5E),
            ),
          ),
          const SizedBox(height: 6),
        ],
        Autocomplete<T>(
          initialValue: TextEditingValue(
            text: value != null ? displayStringForOption(value as T) : '',
          ),
          displayStringForOption: displayStringForOption,
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (!filter || textEditingValue.text.isEmpty) {
              return options;
            }
            final query = textEditingValue.text.toLowerCase();
            return options.where((T option) {
              return displayStringForOption(option).toLowerCase().contains(query);
            });
          },
          onSelected: (T selection) {
            if (onChanged != null) {
              onChanged!(selection);
            }
          },
          fieldViewBuilder: (
            BuildContext context,
            TextEditingController textEditingController,
            FocusNode focusNode,
            VoidCallback onFieldSubmitted,
          ) {
            return _PPAutocompleteField(
              controller: textEditingController,
              focusNode: focusNode,
              placeholder: placeholder,
              iconLeft: iconLeft,
              onClear: () {
                textEditingController.clear();
                if (onChanged != null) {
                  onChanged!(null);
                }
              },
            );
          },
          optionsViewBuilder: (
            BuildContext context,
            AutocompleteOnSelected<T> onSelected,
            Iterable<T> options,
          ) {
            return Align(
              alignment: Alignment.topLeft,
              child: Material(
                elevation: 4.0,
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width - 32, // Approximation, preferably use constraints
                  constraints: const BoxConstraints(maxHeight: 200, maxWidth: 320),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: const Color(0xFFE0E0E0)),
                  ),
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    shrinkWrap: true,
                    itemCount: options.length,
                    itemBuilder: (BuildContext context, int index) {
                      final T option = options.elementAt(index);
                      return InkWell(
                        onTap: () {
                          onSelected(option);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 10.0,
                          ),
                          child: Text(
                            displayStringForOption(option),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color(0xFF333333),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _PPAutocompleteField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String? placeholder;
  final Widget? iconLeft;
  final VoidCallback onClear;

  const _PPAutocompleteField({
    required this.controller,
    required this.focusNode,
    this.placeholder,
    this.iconLeft,
    required this.onClear,
  });

  @override
  State<_PPAutocompleteField> createState() => _PPAutocompleteFieldState();
}

class _PPAutocompleteFieldState extends State<_PPAutocompleteField> {
  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(_onFocusChanged);
    widget.controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(_onFocusChanged);
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onFocusChanged() {
    setState(() {});
  }

  void _onTextChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final bool isFocused = widget.focusNode.hasFocus;
    final bool hasText = widget.controller.text.isNotEmpty;

    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: isFocused ? const Color(0xFF1A2A5E) : const Color(0xFFE0E0E0),
          width: 1.0,
        ),
        boxShadow: isFocused
            ? [
                BoxShadow(
                  color: const Color(0xFF1A2A5E).withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                )
              ]
            : null,
      ),
      child: Row(
        children: [
          if (widget.iconLeft != null) ...[
            const SizedBox(width: 12),
            IconTheme(
              data: const IconThemeData(color: Color(0xFF757575), size: 20),
              child: widget.iconLeft!,
            ),
          ],
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: widget.controller,
              focusNode: widget.focusNode,
              style: const TextStyle(fontSize: 16, color: Color(0xFF333333)),
              decoration: InputDecoration(
                hintText: widget.placeholder,
                hintStyle: const TextStyle(color: Color(0xFF9E9E9E)),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          if (hasText)
            GestureDetector(
              onTap: widget.onClear,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Icon(Icons.close, size: 20, color: Color(0xFF757575)),
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(right: 12.0, left: 4.0),
            child: AnimatedRotation(
              turns: isFocused ? 0.5 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: const Icon(Icons.expand_more, size: 20, color: Color(0xFF757575)),
            ),
          ),
        ],
      ),
    );
  }
}
