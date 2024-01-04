import 'dart:math';

import 'package:flutter/material.dart';
import 'package:passport_hub/common/ui/hub_theme.dart';

class CountryDetailsActionButtons extends StatelessWidget {
  const CountryDetailsActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: HubTheme.hubMediumPadding,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF262626),
              borderRadius: BorderRadius.circular(
                HubTheme.hubBorderRadius,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: HubTheme.hubSmallPadding,
                vertical: HubTheme.hubTinyPadding,
              ),
              child: Row(
                children: [
                  Text(
                    "COMPARE PASSPORTS",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.compare_arrows,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: HubTheme.hubSmallPadding,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: HubTheme.blueLight,
              borderRadius: BorderRadius.circular(HubTheme.hubBorderRadius),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: HubTheme.hubSmallPadding,
                vertical: HubTheme.hubTinyPadding,
              ),
              child: Row(
                children: [
                  Text(
                    "CHECK VISA ACCESS",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const Spacer(),
                  Transform.rotate(
                    angle: pi / 6,
                    child: const Icon(
                      Icons.airplanemode_active_rounded,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
