import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_response_model.g.dart';

@JsonSerializable(genericArgumentFactories: true, explicitToJson: true)
class SearchResponseModel<T> {
  const SearchResponseModel(this.records, this.totalRecord,);

  factory SearchResponseModel.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$SearchResponseModelFromJson<T>(json, fromJsonT);

  final List<T> records;
  final int totalRecord;

  Map<String, dynamic> toJson(Object Function(T) tJson) => _$SearchResponseModelToJson<T>(this, tJson);
}
