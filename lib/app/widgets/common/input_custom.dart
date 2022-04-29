import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputCustom extends StatefulWidget {
  final String? labelText, initialValue, hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode, nextFocus;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final Color? fillColor;
  final int maxLines;
  final bool isPassword,
      isCountryPicker,
      isIcon,
      isShowSuffixIcon,
      isShowPrefixIcon,
      isClear,
      isSearch,
      isEnabled,
      readOnly,
      isUnderBorder;
  final VoidCallback? onTap, onSuffixTap;
  final ValueChanged<String>? onChanged, onSubmit;
  final Widget? suffixIcon, prefixIcon;
  final TextCapitalization capitalization;
  final BorderSide? borderSide;
  final EdgeInsets? contentPadding;
  final EdgeInsets scrollPadding;
  final TextStyle? hintStyle, errorStyle, labelStyle;
  final double hintSize, radius;
  final String? Function(String?)? validator;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final TextAlign textAlign;
  final BoxConstraints? suffixIconConstraints;
  const InputCustom({
    Key? key,
    this.labelStyle,
    this.hintText = '',
    this.labelText,
    this.initialValue,
    this.controller,
    this.focusNode,
    this.nextFocus,
    this.isEnabled = true,
    this.isUnderBorder = false,
    this.isCountryPicker = false,
    this.isShowSuffixIcon = false,
    this.isShowPrefixIcon = false,
    this.isIcon = false,
    this.isPassword = false,
    this.isSearch = false,
    this.isClear = true,
    this.inputType = TextInputType.multiline,
    this.inputAction = TextInputAction.next,
    this.maxLines = 1,
    this.onSuffixTap,
    this.fillColor,
    this.onSubmit,
    this.onChanged,
    this.capitalization = TextCapitalization.none,
    this.onTap,
    this.suffixIcon,
    this.prefixIcon,
    this.borderSide,
    this.contentPadding,
    this.readOnly = false,
    this.hintStyle,
    this.hintSize = 16,
    this.validator,
    this.maxLength,
    this.inputFormatters,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.radius = 0,
    this.textAlign = TextAlign.start,
    this.errorStyle,
    this.suffixIconConstraints,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<InputCustom> {
  bool _obscureText = true;
  String _text = '';
  @override
  void initState() {
    _text = widget.controller?.text ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final style = (widget.hintStyle ?? textTheme.subtitle1!).copyWith(
      color: Colors.black,
      fontSize: widget.hintSize,
      fontWeight: FontWeight.normal,
    );
    final border = widget.isUnderBorder
        ? UnderlineInputBorder(
            borderSide: widget.borderSide ?? const BorderSide(),
            borderRadius: BorderRadius.circular(widget.radius),
          )
        : OutlineInputBorder(
            borderSide: widget.borderSide ?? const BorderSide(),
            borderRadius: BorderRadius.circular(widget.radius),
          );
    return TextFormField(
      initialValue: widget.initialValue,
      scrollPadding: widget.scrollPadding,
      maxLength: widget.maxLength,
      readOnly: widget.readOnly,
      maxLines: widget.maxLines,
      controller: widget.controller,
      focusNode: widget.focusNode,
      style: style,
      keyboardType: widget.inputType,
      textInputAction: widget.inputAction,
      cursorColor: Theme.of(context).primaryColor,
      textCapitalization: widget.capitalization,
      enabled: widget.isEnabled,
      autofocus: false,
      validator: widget.validator,
      obscureText: widget.isPassword ? _obscureText : false,
      inputFormatters: widget.inputFormatters,
      textAlign: widget.textAlign,
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: widget.labelStyle,
        counterText: '',
        contentPadding:
            widget.contentPadding ?? const EdgeInsets.fromLTRB(12, 20, 12, 14),
        isDense: true,
        hintText: widget.hintText,
        hintStyle: widget.hintStyle ??
            textTheme.headline2!.copyWith(
              fontSize: widget.hintSize,
              color: const Color(0xff9B9B9B),
              fontWeight: FontWeight.normal,
            ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 30,
          maxHeight: 30,
        ),
        border: border,
        enabledBorder: border,
        focusedBorder: border,
        filled: widget.fillColor != null,
        fillColor: widget.fillColor,
        errorStyle: widget.errorStyle,
        suffixIconConstraints: widget.suffixIconConstraints,
        prefixIcon: widget.isShowPrefixIcon
            ? Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: widget.prefixIcon,
              )
            : null,
        suffixIcon: widget.readOnly || !widget.isShowSuffixIcon
            ? null
            : Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.isShowSuffixIcon) ...[
                    if (widget.isPassword)
                      _IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: _toggle,
                      )
                    else if (widget.isSearch && _text.isNotEmpty)
                      IconButton(
                        onPressed: _clear,
                        icon: const Icon(Icons.cancel_outlined),
                      )
                    else if (widget.isIcon)
                      _IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: widget.onSuffixTap,
                        icon: widget.suffixIcon ?? const SizedBox(),
                      )
                    else if (widget.suffixIcon != null)
                      widget.suffixIcon!,
                  ],
                  if (widget.isClear)
                    _IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Colors.grey,
                      ),
                      onPressed: _clear,
                    )
                ],
              ),
      ),
      onChanged: (val) {
        widget.onChanged?.call(val);
        setState(() {
          _text = val;
        });
      },
      onTap: widget.onTap,
      onFieldSubmitted: widget.onSubmit,
    );
  }

  void _clear() {
    widget.controller?.clear();
    setState(() {
      _text = '';
    });
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}

class _IconButton extends StatelessWidget {
  const _IconButton({
    Key? key,
    required this.icon,
    this.onPressed,
    this.padding = const EdgeInsets.all(8.0),
  }) : super(key: key);
  final Widget icon;
  final VoidCallback? onPressed;
  final EdgeInsets padding;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      child: Padding(padding: padding, child: icon),
      onTap: onPressed,
    );
  }
}
