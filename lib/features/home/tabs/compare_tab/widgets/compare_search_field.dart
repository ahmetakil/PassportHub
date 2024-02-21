import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passport_hub/common/ui/widgets/hub_text_field.dart';
import 'package:passport_hub/features/home/tabs/compare_tab/bloc/compare_bloc.dart';

class CompareSearchField extends StatefulWidget {
  final bool autofocus;
  final EdgeInsets? padding;

  const CompareSearchField({
    super.key,
    this.autofocus = false,
    this.padding,
  });

  @override
  State<CompareSearchField> createState() => _CompareSearchFieldState();
}

class _CompareSearchFieldState extends State<CompareSearchField> {
  final TextEditingController _compareNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return HubTextField(
      padding: widget.padding,
      autofocus: widget.autofocus,
      keyboardType: TextInputType.text,
      debounce: true,
      onChanged: (String value) {
        if (value.isEmpty) {
          /*TODO  context.read<CompareBloc>().add(
            const ClearSearchEvent(),
          );*/
          return;
        }

        if (value.length < 2) {
          return;
        }

        context.read<CompareBloc>().add(
              CompareSearchQueryEvent(
                searchQuery: value,
              ),
            );
      },
      controller: _compareNameController,
    );
  }
}
