import 'package:flutter/material.dart';

enum FieldType { text, email, password, phone, number }

class CustomFormFieldWidget extends StatefulWidget {
  final String label;
  final String? hintText;
  final TextEditingController controller;
  final FieldType fieldType;
  final bool enabled;
  final bool enableObscureToggle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputAction? inputAction;
  final FormFieldValidator<String>? validatorOverride;
  final void Function(String)? onChanged;

  const CustomFormFieldWidget({
    super.key,
    required this.label,
    required this.controller,
    this.fieldType = FieldType.text,
    this.hintText,
    this.enabled = true,
    this.enableObscureToggle = true,
    this.validatorOverride,
    this.prefixIcon,
    this.suffixIcon,
    this.inputAction,
    this.onChanged,
  });

  @override
  State<CustomFormFieldWidget> createState() => _CustomFormFieldWidgetState();
}

class _CustomFormFieldWidgetState extends State<CustomFormFieldWidget> {
  bool _obscureText = true;

  TextInputType _keyboardTypeFor(FieldType type) {
    switch (type) {
      case FieldType.email:
        return TextInputType.emailAddress;
      case FieldType.password:
        return TextInputType.visiblePassword;
      case FieldType.phone:
        return TextInputType.phone;
      case FieldType.number:
        return TextInputType.number;
      default:
        return TextInputType.text;
    }
  }

  Iterable<String>? _autofillHintsFor(FieldType type) {
    switch (type) {
      case FieldType.email:
        return const [AutofillHints.email];
      case FieldType.password:
        return const [AutofillHints.password];
      case FieldType.phone:
        return const [AutofillHints.telephoneNumber];
      case FieldType.number:
        return const [AutofillHints.creditCardNumber];
      default:
        return null;
    }
  }

  String? _defaultValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '${widget.label} is required';
    }

    switch (widget.fieldType) {
      case FieldType.email:
        final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
        if (!emailRegex.hasMatch(value)) return 'Enter a valid email';
        break;
      case FieldType.password:
        if (value.length < 6) return 'Password must be at least 6 characters';
        break;
      default:
        break;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final isPassword = widget.fieldType == FieldType.password;

    return TextFormField(
      controller: widget.controller,
      obscureText: isPassword && _obscureText,
      keyboardType: _keyboardTypeFor(widget.fieldType),
      enabled: widget.enabled,
      autofillHints: _autofillHintsFor(widget.fieldType),
      textInputAction: widget.inputAction,
      onChanged: widget.onChanged,
      validator: widget.validatorOverride ?? _defaultValidator,
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hintText,
        prefixIcon: widget.prefixIcon,
        suffixIcon: isPassword && widget.enableObscureToggle
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  size: 20,
                ),
                onPressed: () => setState(() => _obscureText = !_obscureText),
              )
            : widget.suffixIcon,
        filled: true,
        fillColor:
            Theme.of(context).inputDecorationTheme.fillColor ??
            Theme.of(context).colorScheme.surfaceContainerHighest,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Theme.of(context).dividerColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Theme.of(context).dividerColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 1.8,
          ),
        ),
      ),
    );
  }
}
