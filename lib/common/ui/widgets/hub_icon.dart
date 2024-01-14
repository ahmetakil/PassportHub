import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

extension HubIconsExtension on HubIcons {
  String get path {
    switch (this) {
      case HubIcons.medal:
        return "assets/icons/medal.svg";
    }
  }
}

extension HubImagesExtension on HubImages {
  String get path {
    switch (this) {
      case HubImages.cartoonAirplane:
        return "assets/images/cartoon_airplane.png";
      case HubImages.comparePreview:
        return "assets/images/compare_preview.png";
    }
  }
}

enum HubIcons {
  medal,
}

enum HubImages {
  cartoonAirplane,
  comparePreview,
}

class HubImage extends StatefulWidget {
  final HubImages image;
  final double? width;
  final double? height;
  final BoxFit fit;

  const HubImage({
    super.key,
    required this.image,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  });

  @override
  State<HubImage> createState() => _HubImageState();
}

class _HubImageState extends State<HubImage> {
  late Image assetImage;

  @override
  void initState() {
    assetImage = Image.asset(
      widget.image.path,
      width: widget.width,
      height: widget.height,
      fit: widget.fit,
      cacheWidth: 200,
      frameBuilder: (
        BuildContext context,
        Widget child,
        int? frame,
        bool wasSynchronouslyLoaded,
      ) {
        if (wasSynchronouslyLoaded) {
          return child;
        }

        if (frame == null) {
          return const SizedBox(
            width: 200,
            height: 200,
          );
        }
        return child;
      },
    );
    super.initState();
  }

  @override
  void didChangeDependencies() {
    precacheImage(assetImage.image, context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return assetImage;
  }
}

class HubIcon extends StatelessWidget {
  final HubIcons icon;
  final double? width;
  final double? height;

  const HubIcon(
    this.icon, {
    this.width,
    this.height,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      icon.path,
      width: width,
      height: height,
    );
  }
}
