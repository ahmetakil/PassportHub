import 'package:flutter/material.dart';
import 'package:passport_hub/common/ui/hub_theme.dart';

class HubFakeTextField extends StatelessWidget {
  final VoidCallback? onTap;
  final Widget child;
  final bool showEmpty;

  const HubFakeTextField({
    super.key,
    this.onTap,
    required this.child,
    this.showEmpty = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: HubTheme.hubMediumPadding,
      ),
      child: Container(
        padding: const EdgeInsets.only(
          left: HubTheme.hubSmallPadding,
          right: 12.0,
          top: 8.0,
          bottom: 8.0,
        ),
        decoration: BoxDecoration(
          color: HubTheme.textFieldBackground,
          borderRadius: BorderRadius.circular(HubTheme.hubBorderRadius),
        ),
        child: InkWell(
          onTap: onTap,
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  right: HubTheme.hubMediumPadding,
                  top: 2,
                  bottom: 2,
                ),
                child: Icon(
                  Icons.search,
                  size: 24,
                ),
              ),
              showEmpty
                  ? Text(
                      "Search",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).hintColor,
                          ),
                    )
                  : Expanded(
                      child: child,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
