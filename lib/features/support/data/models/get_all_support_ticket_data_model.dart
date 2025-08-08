import 'package:json_annotation/json_annotation.dart';

part 'get_all_support_ticket_data_model.g.dart';

@JsonSerializable()
class GetAllSupportTicketDataModel {
  @JsonKey(name: 'status')
  String? status;

  @JsonKey(name: 'pagination')
  PaginationModel? pagination;

  @JsonKey(name: 'result')
  List<SupportDModel>? result;

  GetAllSupportTicketDataModel({
    this.status,
    this.pagination,
    this.result,
  });

  factory GetAllSupportTicketDataModel.fromJson(Map<String, dynamic> json) =>
      _$GetAllSupportTicketDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllSupportTicketDataModelToJson(this);
}

@JsonSerializable()
class PaginationModel {
  @JsonKey(name: 'total')
  int? total;

  @JsonKey(name: 'page')
  int? page;

  @JsonKey(name: 'size')
  int? size;

  @JsonKey(name: 'pages')
  int? pages;

  PaginationModel({
    this.total,
    this.page,
    this.size,
    this.pages,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) =>
      _$PaginationModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationModelToJson(this);
}

@JsonSerializable()
class SupportDModel {
  @JsonKey(name: '_id')
  String? id;

  @JsonKey(name: 'messageType')
  String? messageType;

  @JsonKey(name: 'content')
  String? content;

  @JsonKey(name: 'images')
  List<String>? images;

  @JsonKey(name: 'ticketSeq')
  String? ticketSeq;

  @JsonKey(name: 'status')
  String? status;

  SupportDModel({
    this.id,
    this.messageType,
    this.content,
    this.images,
    this.ticketSeq,
    this.status,
  });

  factory SupportDModel.fromJson(Map<String, dynamic> json) =>
      _$SupportDModelFromJson(json);

  Map<String, dynamic> toJson() => _$SupportDModelToJson(this);
}