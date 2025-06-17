class QueryParams {
  int? skip;
  int? limit;
  int? page;
  String? sort;
  String? startDate;
  String? endDate;
  List<String>? statuses;

  QueryParams({
    this.skip,
    this.limit,
    this.page,
    this.sort,
    this.startDate,
    this.endDate,
    this.statuses,
  });

  factory QueryParams.fromJson(Map<String, dynamic> json) => QueryParams(
        skip: json["skip"],
        limit: json["limit"],
        page: json["page"],
        sort: json["sort"],
        startDate: json["startDate"],
        endDate: json["endDate"],
        statuses: json["statuses"] == null
            ? []
            : List<String>.from(json["statuses"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "skip": skip,
        "limit": limit,
        "page": page,
        "sort": sort,
        "startDate": startDate,
        "endDate": endDate,
        "statuses[]":
            statuses == null ? [] : List<String>.from(statuses!.map((x) => x)),
      };
}
