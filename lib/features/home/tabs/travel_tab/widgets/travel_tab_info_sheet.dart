import 'package:flutter/material.dart';
import 'package:passport_hub/common/models/visa_requirement.dart';
import 'package:passport_hub/common/ui/hub_theme.dart';
import 'package:passport_hub/common/ui/widgets/hub_scaffold.dart';

class TravelTabInfoSheet extends StatelessWidget {
  const TravelTabInfoSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final List<VisaRequirementType> values = VisaRequirementType.values
        .where(
          (val) =>
              val != VisaRequirementType.none &&
              val != VisaRequirementType.noAdmission,
        )
        .toList();

    return HubScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: HubTheme.hubMediumPadding,
          vertical: HubTheme.hubMediumPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                bottom: HubTheme.hubSmallPadding,
              ),
              child: Text(
                'Travel Together ',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: HubTheme.hubSmallPadding,
              ),
              child: Text(
                'Select one or more passport to see where all selected passport holders can travel together.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            Text(
              'Visa requirements will be shown on the map according to the color code.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(
                bottom: HubTheme.hubMediumPadding,
              ),
              child: Text(
                'Map Legend',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
            ListView.separated(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (_, i) => _InfoSheetRow(
                color: values[i].color,
                title: values[i].label,
              ),
              separatorBuilder: (_, __) => const SizedBox(
                height: HubTheme.hubMediumPadding,
              ),
              itemCount: values.length,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: HubTheme.hubMediumPadding,
              ),
              child: _InfoSheetRow(
                title: "Selected Country",
                color: VisaRequirementTypeExtension.self,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoSheetRow extends StatelessWidget {
  final Color color;
  final String title;

  const _InfoSheetRow({required this.color, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            right: HubTheme.hubSmallPadding,
          ),
          child: Icon(Icons.circle, color: color),
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}
