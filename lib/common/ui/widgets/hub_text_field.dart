import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passport_hub/common/bloc/country_search_bloc/country_search_bloc.dart';
import 'package:passport_hub/common/ui/hub_theme.dart';

class HubTextField extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final InputDecoration? decoration;
  final TextEditingController? controller;
  final TextInputType? keyboardType;

  final bool debounce;
  final Duration? debounceDuration;
  final bool enabled;
  final VoidCallback? onTap;
  final bool autofocus;
  final EdgeInsets padding;

  const HubTextField({
    super.key,
    this.onChanged,
    this.decoration,
    this.controller,
    this.keyboardType,
    this.debounce = false,
    this.enabled = true,
    this.onTap,
    this.autofocus = false,
    EdgeInsets? padding,
  })  : padding = padding ??
            const EdgeInsets.symmetric(
              horizontal: HubTheme.hubMediumPadding,
            ),
        debounceDuration =
            debounce == true ? const Duration(milliseconds: 200) : null;

  @override
  State<HubTextField> createState() => _HubTextFieldState();
}

class _HubTextFieldState extends State<HubTextField> {
  Timer? _debounce;

  bool showClear = false;

  @override
  void didChangeDependencies() {
    showClear = widget.controller?.text.isNotEmpty ?? false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ValueChanged<String>? onChanged = widget.onChanged;

    return Padding(
      padding: widget.padding,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: HubTheme.textFieldBackground,
          borderRadius: BorderRadius.circular(HubTheme.hubBorderRadius),
        ),
        child: GestureDetector(
          onTap: widget.onTap,
          child: TextField(
            autofocus: widget.autofocus,
            enabled: widget.enabled,
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

                      setState(() {
                        showClear = val.isNotEmpty;
                      });
                    });
                  },
            decoration: widget.decoration ??
                InputDecoration(
                  suffix: showClear
                      ? GestureDetector(
                          onTap: () {
                            setState(() {
                              showClear = false;
                            });
                            widget.controller?.clear();
                            context
                                .read<CountrySearchBloc>()
                                .add(const ClearSearchEvent());
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                              right: HubTheme.hubMediumPadding,
                            ),
                            child: Icon(
                              Icons.clear,
                              size: 16,
                              color: Colors.grey.withOpacity(0.8),
                            ),
                          ),
                        )
                      : null,
                  icon: const Padding(
                    padding: EdgeInsets.only(
                      left: HubTheme.hubSmallPadding,
                    ),
                    child: Icon(Icons.search),
                  ),
                  hintText: "Search",
                  border: InputBorder.none,
                  fillColor: HubTheme.textFieldBackground,
                ),
            controller: widget.controller,
          ),
        ),
      ),
    );
  }
}
