import 'package:flutter/material.dart';
import 'package:passport_hub/common/models/country.dart';
import 'package:passport_hub/common/ui/hub_theme.dart';
import 'package:passport_hub/common/ui/widgets/hub_country_flag.dart';
import 'package:passport_hub/common/ui/widgets/hub_passport_image.dart';

class CompareContentHeader extends StatelessWidget {
  final Country left;
  final Country right;

  const CompareContentHeader({
    super.key,
    required this.left,
    required this.right,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            HubPassportImage(
              country: left,
              size: 72,
            ),
            const Expanded(
              child: Icon(
                Icons.compare_arrows,
                size: 40,
              ),
            ),
            HubPassportImage(
              country: right,
              size: 72,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: HubTheme.hubLargePadding,
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: HubTheme.hubTinyPadding),
                child: HubCountryFlag(
                  country: left,
                ),
              ),
              Text(
                "${left.name}",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: HubTheme.hubTinyPadding),
                child: Text(
                  "${right.name}",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              HubCountryFlag(
                country: right,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
