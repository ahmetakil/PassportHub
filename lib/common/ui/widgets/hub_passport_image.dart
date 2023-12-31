import 'package:flutter/material.dart';
import 'package:passport_hub/common/models/country.dart';
import 'package:passport_hub/common/ui/hub_theme.dart';

const _targetAspectRatio = 86 / 60;

class HubPassportImage extends StatelessWidget {
  final Country country;
  final double? size;

  const HubPassportImage({
    super.key,
    required this.country,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    final double width = size ?? 60;

    return Image.asset(
      "assets/images/passport_images/${country.iso3code}.webp",
      width: width,
      height: width * _targetAspectRatio,
      errorBuilder: (context, _, __) => Container(
        width: width,
        height: width * _targetAspectRatio,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(HubTheme.hubBorderRadius),
          border: Border.all(
            color: Colors.grey.withOpacity(0.5),
          ),
        ),
        child: const Icon(Icons.error_outline),
      ),
    );
  }
}
