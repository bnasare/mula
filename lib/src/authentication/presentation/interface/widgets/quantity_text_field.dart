import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mula/shared/presentation/theme/app_colors.dart';

// Custom TextInputFormatter to allow full unit names
class _FullUnitTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Always allow empty string or deletion
    if (newValue.text.isEmpty || newValue.text.length < oldValue.text.length) {
      return newValue;
    }

    // Check if user just typed a letter directly after a number (without space)
    // This includes incomplete numbers like "2." or "5/"
    final directLetterAfterNumber = RegExp(
      r'^(\d+\/\d*|\d+\.\d*|\d+)([a-zA-Z])',
    );
    final match = directLetterAfterNumber.firstMatch(newValue.text);

    if (match != null) {
      // Automatically insert a space between number and letter
      final numberPart = match.group(1)!;
      final letterPart = newValue.text.substring(numberPart.length);
      final correctedText = '$numberPart $letterPart';

      return TextEditingValue(
        text: correctedText,
        selection: TextSelection.collapsed(offset: correctedText.length),
      );
    }

    // Full pattern that allows:
    // 1. Whole numbers (2)
    // 2. Decimals (2.5)
    // 3. Fractions (1/2)
    // 4. Any of the above followed by letters/spaces (2 cups, 2.5 liters, 1/2 tsp)
    // 5. Incomplete numbers while typing (2., 1/)
    final pattern = RegExp(
      r'^('
      r'\d+\/\d*' // Fractions (complete or incomplete)
      r'|'
      r'\d+\.\d*' // Decimals (complete or incomplete)
      r'|'
      r'\d+' // Whole numbers
      r')'
      r'([ a-zA-Z]*)$', // Optional letters/spaces after valid number
    );

    if (pattern.hasMatch(newValue.text)) {
      return newValue;
    }

    return oldValue;
  }
}

class QuantityTextField extends StatefulWidget {
  /// The controller for the text field.
  final TextEditingController? controller;

  /// The text that suggests what the user should type.
  final String? hintText;

  /// The label text displayed above the field.
  final String? labelText;

  /// Map of full unit names with their optional abbreviations.
  final Map<String, String> units;

  /// Initially selected unit (optional).
  final String? initialUnit;

  /// Called when the quantity or unit changes.
  final Function(String quantity, String unit)? onChanged;

  /// The fixed height for the input field.
  final double inputHeight;

  /// The border radius for the text field.
  final double borderRadius;

  const QuantityTextField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.units = const {
      'kilograms': 'kg',
      'grams': 'g',
      'milliliters': 'ml',
      'liters': 'l',
      'ounces': 'oz',
      'pounds': 'lb',
      'pieces': 'pcs',
      'cups': 'cup',
      'tablespoons': 'tbsp',
      'teaspoons': 'tsp',
    },
    this.initialUnit,
    this.onChanged,
    this.inputHeight = 40.0,
    this.borderRadius = 8.0,
  });

  @override
  State<QuantityTextField> createState() => _QuantityTextFieldState();
}

class _QuantityTextFieldState extends State<QuantityTextField> {
  late TextEditingController _controller;
  String? _selectedUnit;
  String? _selectedUnitAbbreviation;
  bool _isDropdownOpen = false;
  final FocusNode _focusNode = FocusNode();

  // Separate storage for quantity and unit part of the input
  String _quantityPart = '';
  String _unitPart = '';

  // Track if we've detected a valid number to allow unit typing
  bool _hasValidQuantity = false;

  // Track if we have an incomplete number (like "2." or "5/")
  bool _hasIncompleteQuantity = false;

  // Regular expressions for validation
  final RegExp _validDecimalRegex = RegExp(r'^\d+\.\d+$');
  final RegExp _validFractionRegex = RegExp(r'^\d+\/\d+$');
  final RegExp _validIntegerRegex = RegExp(r'^\d+$');
  final RegExp _incompleteDecimalRegex = RegExp(r'^\d+\.$');
  final RegExp _incompleteFractionRegex = RegExp(r'^\d+\/$');

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _selectedUnit = widget.initialUnit;
    if (_selectedUnit != null) {
      _selectedUnitAbbreviation = widget.units[_selectedUnit];
    }
    _focusNode.addListener(_onFocusChange);
    _controller.addListener(_onTextChange);
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    _controller.removeListener(_onTextChange);
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    // Show dropdown if we have focus and either valid quantity with unit part or incomplete quantity
    _updateDropdownVisibility();
  }

  void _onTextChange() {
    final String text = _controller.text;

    // Parse input to separate quantity and unit parts
    _parseInput(text);

    // Update dropdown visibility
    _updateDropdownVisibility();

    // Notify parent about changes
    if (widget.onChanged != null && _hasValidQuantity) {
      widget.onChanged!(_quantityPart, _selectedUnit ?? '');
    }
  }

  void _parseInput(String text) {
    if (text.isEmpty) {
      setState(() {
        _quantityPart = '';
        _unitPart = '';
        _hasValidQuantity = false;
        _hasIncompleteQuantity = false;
      });
      return;
    }

    // Match: fractions first, then decimals, then whole numbers
    // Order matters: more specific patterns must come first
    final quantityRegex = RegExp(r'^(\d+\/\d*|\d+\.\d*|\d+)');
    final match = quantityRegex.firstMatch(text);

    if (match == null) {
      setState(() {
        _quantityPart = '';
        _unitPart = '';
        _hasValidQuantity = false;
        _hasIncompleteQuantity = false;
      });
      return;
    }

    final String numericPart = match.group(0) ?? '';

    // Check if we have a valid complete number (not incomplete like "2." or "2/")
    bool isValidCompleteNumber =
        _validIntegerRegex.hasMatch(numericPart) ||
        _validDecimalRegex.hasMatch(numericPart) ||
        _validFractionRegex.hasMatch(numericPart);

    // Check if we have an incomplete number (like "2." or "5/")
    bool isIncompleteNumber =
        _incompleteDecimalRegex.hasMatch(numericPart) ||
        _incompleteFractionRegex.hasMatch(numericPart);

    setState(() {
      _quantityPart = numericPart;
      _hasValidQuantity = isValidCompleteNumber;
      _hasIncompleteQuantity = isIncompleteNumber;

      // Extract unit part (if any)
      if (text.length > numericPart.length) {
        _unitPart = text.substring(numericPart.length).trim();
      } else {
        _unitPart = '';
      }
    });
  }

  void _updateDropdownVisibility() {
    setState(() {
      _isDropdownOpen =
          _focusNode.hasFocus &&
          (
          // Show dropdown if we have valid quantity and unit part/selected unit
          (_hasValidQuantity &&
                  (_unitPart.isNotEmpty || _selectedUnit != null)) ||
              // OR if we have incomplete quantity (show all units when no unit part, filtered when typing)
              (_hasIncompleteQuantity &&
                  (_unitPart.isEmpty || _unitPart.isNotEmpty)));
    });
  }

  List<MapEntry<String, String>> _getFilteredUnits() {
    // If we have incomplete quantity and no unit part, show all units
    if (_hasIncompleteQuantity && _unitPart.isEmpty) {
      return widget.units.entries.toList();
    }

    // If we have unit part (either with valid or incomplete quantity), filter by it
    if (_unitPart.isNotEmpty) {
      return widget.units.entries
          .where(
            (entry) =>
                entry.key.toLowerCase().startsWith(_unitPart.toLowerCase()),
          )
          .toList();
    }

    // Default case: show all units
    return widget.units.entries.toList();
  }

  // Helper method to clean up incomplete quantities
  String _cleanIncompleteQuantity(String quantity) {
    // Handle fractions ending with /0
    if (quantity.endsWith('/0')) {
      return quantity.substring(0, quantity.length - 2);
    }

    // Handle decimals ending with .0
    if (quantity.endsWith('.0')) {
      return quantity.substring(0, quantity.length - 2);
    }

    // Handle incomplete fractions (ends with /)
    if (quantity.endsWith('/')) {
      return quantity.substring(0, quantity.length - 1);
    }

    // Handle incomplete decimals (ends with .)
    if (quantity.endsWith('.')) {
      return quantity.substring(0, quantity.length - 1);
    }

    return quantity;
  }

  void _selectUnit(String unitFullName, String unitAbbreviation) {
    setState(() {
      _selectedUnit = unitFullName;
      _selectedUnitAbbreviation = unitAbbreviation;

      // Clean the quantity before adding unit
      String cleanQuantity = _cleanIncompleteQuantity(_quantityPart);

      // Update the text controller with the new complete value (with space)
      final newValue = '$cleanQuantity $unitFullName';
      _controller.value = _controller.value.copyWith(
        text: newValue,
        selection: TextSelection.collapsed(offset: newValue.length),
      );

      // Close dropdown after selection
      _isDropdownOpen = false;
    });

    // Use cleaned quantity for callback
    String cleanQuantity = _cleanIncompleteQuantity(_quantityPart);

    if (widget.onChanged != null) {
      widget.onChanged!(cleanQuantity, unitFullName);
    }

    // Unfocus to close the dropdown
    _focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final filteredUnits = _getFilteredUnits();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.labelText != null) ...[
          Text(
            widget.labelText!,
            style: TextStyle(color: AppColors.secondaryText(context)),
          ),
          const SizedBox(height: 8),
        ],
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.border(context)),
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
          child: Column(
            children: [
              TextField(
                controller: _controller,
                focusNode: _focusNode,
                keyboardType: TextInputType.text, // Allow both numbers and text
                textInputAction: TextInputAction.done,
                style: TextStyle(
                  color: AppColors.primaryText(context),
                  fontSize: 13,
                ),
                inputFormatters: [
                  // Custom formatter to enforce our input rules
                  _FullUnitTextInputFormatter(),
                ],
                decoration: InputDecoration(
                  hintText:
                      widget.hintText ??
                      "Enter amount (e.g. 2 cups, 1.5 kilograms)",
                  hintStyle: TextStyle(
                    color: AppColors.hintText(context),
                    fontSize: 13,
                  ),
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  border: InputBorder.none,
                ),
              ),

              // Show units dropdown when conditions are met
              if (_isDropdownOpen && filteredUnits.isNotEmpty)
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: AppColors.lightGrey(context)),
                    ),
                  ),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 150),
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: filteredUnits.length,
                      itemBuilder: (context, index) {
                        final unitEntry = filteredUnits[index];
                        return InkWell(
                          onTap: () =>
                              _selectUnit(unitEntry.key, unitEntry.value),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: unitEntry.key == _selectedUnit
                                  ? AppColors.orange.withOpacity(0.1)
                                  : AppColors.transparent,
                            ),
                            child: Text(
                              unitEntry.key,
                              style: TextStyle(
                                fontSize: 13,
                                color: unitEntry.key == _selectedUnit
                                    ? AppColors.black(context)
                                    : AppColors.black(context),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
