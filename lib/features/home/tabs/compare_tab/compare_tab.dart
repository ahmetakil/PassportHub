import 'package:flutter/material.dart';
import 'package:passport_hub/common/ui/hub_theme.dart';
import 'package:passport_hub/common/ui/widgets/hub_icon.dart';
import 'package:passport_hub/common/ui/widgets/hub_page_title.dart';

class CompareTab extends StatelessWidget {
  const CompareTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const HubPageTitle(title: "Compare"),
          const Spacer(),
          const HubImage(
            image: HubImages.comparePreview,
            width: 240,
          ),
          Text(
            "COMING SOON",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          Padding(
            padding: const EdgeInsets.all(
              HubTheme.hubMediumPadding,
            ),
            child: Text(
              'Compare and find out which passport gives you the most freedom to travel around the world!',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          const Spacer(
            flex: 2,
          ),
        ],
      ),
    );
  }
}
