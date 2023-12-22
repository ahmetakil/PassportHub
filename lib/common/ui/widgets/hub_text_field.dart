import 'dart:async';

import 'package:flutter/material.dart';

class HubTextField extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final InputDecoration? decoration;
  final TextEditingController? controller;
  final TextInputType? keyboardType;

  final bool debounce;
  final Duration? debounceDuration;

  const HubTextField({
    super.key,
    this.onChanged,
    this.decoration,
    this.controller,
    this.keyboardType,
    this.debounce = false,
  }) : debounceDuration =
            debounce == true ? const Duration(milliseconds: 200) : null;

  @override
  State<HubTextField> createState() => _HubTextFieldState();
}

class _HubTextFieldState extends State<HubTextField> {
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ValueChanged<String>? onChanged = widget.onChanged;

    return TextField(
      keyboardType: widget.keyboardType,
      textCapitalization: TextCapitalization.none,
      autocorrect: false,
      onChanged: onChanged == null
          ? null
          : (String val) {
              final Duration? debounceDuration = widget.debounceDuration;

              if (debounceDuration == null) {
                onChanged(val);
                return;
              }

              if (_debounce?.isActive ?? false) {
                _debounce?.cancel();
              }
              _debounce = Timer(debounceDuration, () {
                onChanged(val);
              });
            },
      decoration: widget.decoration,
      controller: widget.controller,
    );
  }
}
