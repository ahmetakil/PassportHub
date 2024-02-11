import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:passport_hub/common/ui/widgets/hub_back_icon.dart';
import 'package:passport_hub/common/ui/widgets/hub_scaffold.dart';

const _adUrlFilters = [
  ".*.doubleclick.net/.*",
  ".*.ads.pubmatic.com/.*",
  ".*.googlesyndication.com/.*",
  ".*.google-analytics.com/.*",
  ".*.adservice.google.*/.*",
  ".*.adbrite.com/.*",
  ".*.exponential.com/.*",
  ".*.quantserve.com/.*",
  ".*.scorecardresearch.com/.*",
  ".*.zedo.com/.*",
  ".*.adsafeprotected.com/.*",
  ".*.teads.tv/.*",
  ".*.outbrain.com/.*",
];

class NewsDetailsScreen extends StatefulWidget {
  final String newsUrl;

  const NewsDetailsScreen({
    super.key,
    required this.newsUrl,
  });

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  final GlobalKey webViewKey = GlobalKey();

  final List<ContentBlocker> contentBlockers = [];
  var contentBlockerEnabled = true;

  InAppWebViewController? webViewController;
  late InAppWebViewSettings settings;
  final urlController = TextEditingController();

  @override
  void initState() {
    super.initState();

    for (final adUrlFilter in _adUrlFilters) {
      contentBlockers.add(
        ContentBlocker(
          trigger: ContentBlockerTrigger(
            urlFilter: adUrlFilter,
          ),
          action: ContentBlockerAction(
            type: ContentBlockerActionType.BLOCK,
          ),
        ),
      );
    }

    contentBlockers.add(
      ContentBlocker(
        trigger: ContentBlockerTrigger(
          urlFilter: ".*",
        ),
        action: ContentBlockerAction(
          type: ContentBlockerActionType.CSS_DISPLAY_NONE,
          selector: ".banner, .banners, .ads, .ad, .advert",
        ),
      ),
    );

    settings = InAppWebViewSettings(
      isInspectable: kDebugMode,
      mediaPlaybackRequiresUserGesture: false,
      allowsInlineMediaPlayback: true,
      iframeAllow: "camera; microphone",
      iframeAllowFullscreen: true,
      contentBlockers: contentBlockers,
    );
  }

  @override
  Widget build(BuildContext context) {
    return HubScaffold(
      appBar: AppBar(
        leading: const HubBackIcon(),
        title: const Text("Hub News"),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Stack(
                children: [
                  InAppWebView(
                    key: webViewKey,
                    initialUrlRequest: URLRequest(
                      url: WebUri(
                        widget.newsUrl,
                      ),
                    ),
                    initialSettings: settings,
                    onWebViewCreated: (controller) {
                      webViewController = controller;
                    },
                    onPermissionRequest: (controller, request) async {
                      return PermissionResponse(
                        resources: request.resources,
                        action: PermissionResponseAction.GRANT,
                      );
                    },
                    onConsoleMessage: (controller, consoleMessage) {
                      if (kDebugMode) {
                        print(consoleMessage);
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
