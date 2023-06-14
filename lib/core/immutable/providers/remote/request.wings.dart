import '../../../mutable/helpers/phone.info.helper.dart';

class WingsRequest {
  String url;
  dynamic id;
  bool shouldCache;
  Map<String, dynamic> queryString;
  Map<String, dynamic> _header;
  dynamic body;
  bool nullable;
  bool withPagination;
  int limit;

  WingsRequest({
    required this.url,
    this.id,
    this.shouldCache = false,
    this.nullable = false,
    this.queryString = const {},
    this.body = const {},
    this.withPagination = false,
    Map<String, dynamic> header = const {},
    this.limit = 20,
  }) : _header = header;

  String get withId => id != null ? '/$id' : '';

  String get urlQueryString => url + withId + _queryStringFormat();

  Map<String, dynamic> get header {
    var head = Map<String, dynamic>.from(_header);

    if (WingsDeviceInfo().haveDeviceData) {
      head.addAll(WingsDeviceInfo().deviceInfoRequestHeader);
    }

    return head;
  }

  String _queryStringFormat() {
    bool showPagination = withPagination && !queryString.containsKey('limit');

    String query = showPagination ? '?limit=$limit' : '';

    if (queryString.isNotEmpty) {
      query = showPagination ? '$query&' : '?';

      queryString.forEach((key, value) {
        query += '$key=$value&';
      });

      query = query.substring(0, query.length - 1);
    }

    return query;
  }

  WingsRequest copyWith({
    String? url,
    dynamic id,
    bool? shouldCache,
    bool? nullable,
    Map<String, dynamic>? queryString,
    dynamic body,
    Map<String, dynamic>? header,
    bool? withPagination,
  }) {
    return WingsRequest(
      url: url ?? this.url,
      id: id ?? this.id,
      shouldCache: shouldCache ?? this.shouldCache,
      nullable: nullable ?? this.nullable,
      queryString: queryString ?? this.queryString,
      body: body ?? this.body,
      header: header ?? this.header,
      withPagination: withPagination ?? this.withPagination,
    );
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
