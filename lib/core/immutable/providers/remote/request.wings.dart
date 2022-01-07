class WingsRequest {
  String url;
  bool shouldCache;
  Map<String, dynamic> queryString;
  WingsRequestHeader? header;
  Map<String, dynamic> body;
  bool nullable;

  WingsRequest({
    required this.url,
    this.shouldCache = false,
    this.nullable = false,
    this.queryString = const {},
    this.body = const {},
    this.header,
  }) {
    header ??= WingsRequestHeader.instance;
  }

  String get urlQueryString => url + _queryStringFormat();

  String _queryStringFormat() {
    String query = '';

    if (queryString.isNotEmpty) {
      query = '?';

      queryString.forEach((key, value) {
        query += '$key=$value&';
      });

      query = query.substring(0, query.length - 1);
    }

    return query;
  }
}

class WingsRequestHeader {
  static WingsRequestHeader? _instance;

  static WingsRequestHeader get instance {
    _instance ??= const WingsRequestHeader();

    return _instance!;
  }

  final String contentType;
  final String authorization;
  final Map<String, dynamic> options;

  const WingsRequestHeader({
    this.authorization = '',
    this.contentType = 'application/json',
    this.options = const {},
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'Content-Type': contentType,
      'Authorization': authorization,
    };

    map.addAll(options);

    return map;
  }

  WingsRequestHeader copyWith({
    String? contentType,
    String? authorization,
    Map<String, dynamic>? options,
  }) {
    return WingsRequestHeader(
      authorization: authorization ?? this.authorization,
      contentType: contentType ?? this.contentType,
      options: options ?? this.options,
    );
  }
}
