import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_showcase/core/extensions/extensions.dart';

/// Customized text field
///
class AppTextField extends StatefulWidget {
  /// Creates a customized text field with various properties.
  const AppTextField({
    required this.label,
    required this.hint,
    this.hasLabel = false,
    this.prefixText,
    this.prefix,
    this.suffixIcon,
    this.obscureText = false,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.onTap,
    this.keyboardType,
    this.inputFormatters,
    this.disabled = false,
    this.editable = false,
    this.autofocus = false,
    this.heroTag,
    this.isFloatingLabel = true,
    this.fillColor,
    this.minLines = 1,
    this.maxLines,
    this.textCapitalization,
    super.key,
  });

  /// The label of the text field
  final String label;

  /// flag to show/ hide the label
  final bool hasLabel;

  /// The hint of the text field
  final String hint;

  /// The prefix text
  final String? prefixText;

  /// The prefix widget
  final Widget? prefix;

  /// The suffix icon
  final Widget? suffixIcon;

  /// Flag to enable/ disable text obscurement
  final bool obscureText;

  /// Text editing controller
  final TextEditingController? controller;

  /// Focus node
  final FocusNode? focusNode;

  /// On changed
  final ValueChanged<String>? onChanged;

  /// On submitted
  final ValueChanged<String>? onSubmitted;

  /// Validator
  final FormFieldValidator<String>? validator;

  /// On tap callback
  final GestureTapCallback? onTap;

  /// Keyboard type
  final TextInputType? keyboardType;

  /// Input formatters
  final List<TextInputFormatter>? inputFormatters;

  /// Flag to disable/ enable the text field
  final bool disabled;

  /// Flag to enable/ disable the text field
  /// Only works when [disabled] is 'false'
  final bool editable;

  /// Flag to autofocus
  final bool autofocus;

  /// Hero tag
  final String? heroTag;

  /// Floating label behavior
  final bool isFloatingLabel;

  /// Background color
  final Color? fillColor;

  /// Minimum lines
  final int minLines;

  /// Maximum lines
  final int? maxLines;

  /// Text capitalization
  final TextCapitalization? textCapitalization;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool obscuring = false;

  @override
  void initState() {
    obscuring = widget.obscureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AbsorbPointer(
        absorbing: widget.onTap != null,
        child: Builder(
          builder: (context) {
            final field = Material(
              type: MaterialType.transparency,
              child: Container(
                decoration: BoxDecoration(
                  color: widget.fillColor ?? context.theme.inputDecorationTheme.fillColor,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                padding: EdgeInsets.only(top: widget.isFloatingLabel ? 10 : 0),
                child: Stack(
                  children: [
                    // [field]
                    TextFormField(
                      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
                      autofocus: widget.autofocus,
                      enabled: !widget.disabled,
                      style: context.textTheme.titleMedium,
                      obscureText: obscuring,
                      controller: widget.controller,
                      focusNode: widget.focusNode,
                      onChanged: widget.onChanged,
                      validator: widget.validator,
                      onFieldSubmitted: widget.onSubmitted,
                      keyboardType: widget.keyboardType ?? TextInputType.text,
                      inputFormatters: widget.inputFormatters,
                      minLines: widget.minLines,
                      maxLines: widget.maxLines ?? widget.minLines,
                      textCapitalization: widget.textCapitalization ?? TextCapitalization.none,
                      decoration: InputDecoration(
                        fillColor: widget.fillColor ?? context.theme.inputDecorationTheme.fillColor,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        labelText: widget.isFloatingLabel ? null : widget.label,
                        hintText: widget.hint,
                        prefixText: widget.prefixText,
                        suffixIconConstraints: const BoxConstraints(minWidth: 40),
                        prefixIcon: widget.prefix,
                        suffixIcon: widget.obscureText
                            ? GestureDetector(
                                onTap: () => setState(() => obscuring = !obscuring),
                                child: Icon(obscuring ? Icons.visibility_off : Icons.visibility),
                              )
                            : widget.suffixIcon,
                      ),
                    ),

                    // [label]
                    if (widget.isFloatingLabel)
                      Positioned(
                        left: 10,
                        child: Text(
                          widget.label,
                          style: context.theme.inputDecorationTheme.labelStyle?.copyWith(
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );

            if (widget.heroTag != null) return Hero(tag: widget.heroTag!, child: field);
            return field;
          },
        ),
      ),
    );
  }
}
