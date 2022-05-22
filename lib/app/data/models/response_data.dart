class ResponseData<T> {
  final Meta? meta;
  final T data;

  ResponseData({
    required this.data,
    this.meta,
  });
}

class Meta {
  final int limit;
  final int page;

  Meta({
    this.limit = 10,
    this.page = 0,
  });
}
