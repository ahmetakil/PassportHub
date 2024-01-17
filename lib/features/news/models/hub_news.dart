import 'package:equatable/equatable.dart';

class HubNews extends Equatable {
  final String title;
  final String url;
  final DateTime publishedAt;

  final String? source;

  const HubNews({
    required this.title,
    required this.url,
    required this.publishedAt,
    this.source,
  });

  @override
  List<Object?> get props => [title, url, publishedAt];
}
