import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:passport_hub/common/hub_logger.dart';
import 'package:passport_hub/common/ui/hub_theme.dart';
import 'package:passport_hub/common/ui/widgets/hub_scaffold.dart';

class HubErrorScreen extends StatelessWidget {
  final String? errorMessage;

  const HubErrorScreen({
    Key? key,
    this.errorMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HubLogger.log(
      "ErrorScreen has been loaded with message: $errorMessage",
      severity: Severity.error,
    );

    return SafeArea(
      child: HubScaffold(
        appBar: AppBar(
          title: const Icon(
            Icons.error,
            size: 100,
          ),
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(HubTheme.hubSmallPadding),
                child: Text(
                  kDebugMode
                      ? "Error: $errorMessage"
                      : "Something went wrong, please try again later!",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
