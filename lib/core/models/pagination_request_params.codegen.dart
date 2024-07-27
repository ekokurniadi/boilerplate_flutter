class PagingRequestParams<T>{

  factory PagingRequestParams.fromJson(Map<String, dynamic> map) {
    return PagingRequestParams(
      limit: map['limit'] as String,
      page: map['page'] as String,
      query: map['query'] as String,
      id: map['id'] as int,
      sort: map['sort'] as String,
      order: map['order'] as String,
    );
  }
  const PagingRequestParams({
    this.isOnline = false,
    this.limit = '50',
    this.page = '1',
    this.query,
    this.id,
    this.outletId,
    this.order,
    this.sort,
    this.filters,
  });

  final bool isOnline;
  final String? limit;
  final String? page;
  final String? query;
  final int? id;
  final String? outletId;
  final String? order;
  final String? sort;
  final T? filters;

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if(this.limit != null){
      json['limit'] = this.limit;
    }
    if(this.page != null){
      json['page'] = this.page;
    }
    if(this.query != null){
      json['query'] = this.query;
    }
    if(this.id != null){
      json['id'] = this.id;
    }
    if(this.outletId != null){
      json['outlet_id'] = this.outletId;
    }
    if(this.order != null){
      json['order'] = this.order;
    }
    if(this.sort != null){
      json['sort'] = this.sort;
    }
    return json;
  }

  PagingRequestParams copyWith({
    String? limit,
    String? page,
    String? query,
    int? id,
    String? outletId,
    String? order,
    String? sort,
    T? filters,
  }) {
    return PagingRequestParams(
      limit: limit ?? this.limit,
      page: page ?? this.page,
      query: query ?? this.query,
      id: id ?? this.id,
      outletId: outletId ?? this.outletId,
      order: order ?? this.order,
      sort: sort ?? this.sort,
      filters: filters ?? this.filters,
    );
  }
}
