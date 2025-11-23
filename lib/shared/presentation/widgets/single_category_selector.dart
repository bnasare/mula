import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/extension.dart';
import '../theme/app_colors.dart';

class SingleCategorySelector extends StatefulWidget {
  final String title;
  final String hintText;
  final List<String> options;
  final String? selectedOption;
  final Function(String?) onSelectionChanged;

  const SingleCategorySelector({
    super.key,
    required this.title,
    required this.hintText,
    required this.options,
    required this.selectedOption,
    required this.onSelectionChanged,
  });

  @override
  State<SingleCategorySelector> createState() => _SingleCategorySelectorState();
}

class _SingleCategorySelectorState extends State<SingleCategorySelector> {
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  List<String> _filteredOptions = [];
  bool _isActive = false;

  @override
  void initState() {
    super.initState();
    _textController.text = widget.selectedOption ?? '';
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void didUpdateWidget(SingleCategorySelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedOption != oldWidget.selectedOption) {
      _textController.text = widget.selectedOption ?? '';
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isActive = _focusNode.hasFocus;
      // When focused, show all available options
      if (_isActive) {
        _filterOptions(_textController.text);
      }
    });
  }

  void _filterOptions(String query) {
    final availableOptions = widget.options
        .where((option) => option.toLowerCase().contains(query.toLowerCase()))
        .toList();

    setState(() {
      _filteredOptions = availableOptions;
    });
  }

  void _selectOption(String option) {
    setState(() {
      _textController.text = option;
      widget.onSelectionChanged(option);
      _isActive = false;
      _focusNode.unfocus();
    });
  }

  void _clearSelection() {
    setState(() {
      _textController.clear();
      widget.onSelectionChanged(null);
      _filterOptions('');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(
            color: AppColors.secondaryText(context),
            fontSize: context.responsiveFontSize(mobile: 14),
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: context.responsiveSpacing(mobile: 8)),

        // Autocomplete text field
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.border(context)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              TextField(
                controller: _textController,
                focusNode: _focusNode,
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  hintStyle: TextStyle(
                    color: AppColors.hintText(context),
                    fontSize: context.responsiveFontSize(mobile: 13),
                  ),
                  isDense: true,
                  contentPadding: context.responsivePadding(
                    mobile: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 13,
                    ),
                  ),
                  border: InputBorder.none,
                  suffixIcon: _textController.text.isNotEmpty
                      ? GestureDetector(
                          onTap: _clearSelection,
                          child: Icon(
                            CupertinoIcons.clear_circled,
                            size: context.responsiveValue(mobile: 20.0),
                            color: AppColors.defaultText(context),
                          ),
                        )
                      : Icon(
                          Icons.keyboard_arrow_down,
                          size: context.responsiveValue(mobile: 20.0),
                          color: AppColors.hintText(context),
                        ),
                  constraints: BoxConstraints(
                    maxHeight: context.responsiveValue(mobile: 40.0),
                  ),
                ),
                style: TextStyle(
                  fontSize: context.responsiveFontSize(mobile: 14),
                  color: AppColors.primaryText(context),
                  height: 1.0,
                ),
                onChanged: (value) {
                  _filterOptions(value);
                  // If user types something that doesn't match current selection, clear it
                  if (value != widget.selectedOption) {
                    widget.onSelectionChanged(value.isEmpty ? null : value);
                  }
                },
              ),

              // Show suggestions when active
              if (_isActive && _filteredOptions.isNotEmpty)
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: AppColors.lightGrey(context)),
                    ),
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: context.responsiveValue(mobile: 120.0),
                    ),
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: _filteredOptions.length,
                      itemBuilder: (context, index) {
                        final option = _filteredOptions[index];
                        return InkWell(
                          onTap: () => _selectOption(option),
                          child: Container(
                            width: double.infinity,
                            padding: context.responsivePadding(
                              mobile: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                            ),
                            child: Text(
                              option,
                              style: TextStyle(
                                fontSize: context.responsiveFontSize(
                                  mobile: 13,
                                ),
                                color: AppColors.secondaryText(context),
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
