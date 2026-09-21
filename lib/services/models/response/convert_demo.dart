// class ConvertDemo {
//   ConvertDemo({
//       this.status,
//       this.data,});
//
//   ConvertDemo.fromJson(dynamic json) {
//     status = json['status'];
//     data = json['data'] != null ? Data.fromJson(json['data']) : null;
//   }
//   num? status;
//   Data? data;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['status'] = status;
//     if (data != null) {
//       map['data'] = data?.toJson();
//     }
//     return map;
//   }
//
// }
//
// class Data {
//   Data({
//       this.id,
//       this.x,
//       this.y,
//       this.width,
//       this.height,
//       this.border,
//       this.borderWidth,
//       this.fill,
//       this.scaleX,
//       this.scaleY,
//       this.radius,
//       this.data,
//       this.label,
//       this.rotation,
//       this.status,
//       this.points,
//       this.type,
//       this.fontSize,
//       this.widgets,});
//
//   Data.fromJson(dynamic json) {
//     id = json['id'];
//     x = json['x'];
//     y = json['y'];
//     width = json['width'];
//     height = json['height'];
//     border = json['border'];
//     borderWidth = json['borderWidth'];
//     fill = json['fill'];
//     scaleX = json['scaleX'];
//     scaleY = json['scaleY'];
//     radius = json['radius'];
//     data = json['data'];
//     label = json['label'];
//     rotation = json['rotation'];
//     status = json['status'];
//     points = json['points'];
//     type = json['type'];
//     fontSize = json['fontSize'];
//     if (json['widgets'] != null) {
//       widgets = [];
//       json['widgets'].forEach((v) {
//         widgets?.add(Widgets.fromJson(v));
//       });
//     }
//   }
//   num? id;
//   dynamic x;
//   dynamic y;
//   num? width;
//   num? height;
//   dynamic border;
//   dynamic borderWidth;
//   dynamic fill;
//   dynamic scaleX;
//   dynamic scaleY;
//   dynamic radius;
//   dynamic data;
//   dynamic label;
//   dynamic rotation;
//   num? status;
//   dynamic points;
//   num? type;
//   dynamic fontSize;
//   List<Widgets>? widgets;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = id;
//     map['x'] = x;
//     map['y'] = y;
//     map['width'] = width;
//     map['height'] = height;
//     map['border'] = border;
//     map['borderWidth'] = borderWidth;
//     map['fill'] = fill;
//     map['scaleX'] = scaleX;
//     map['scaleY'] = scaleY;
//     map['radius'] = radius;
//     map['data'] = data;
//     map['label'] = label;
//     map['rotation'] = rotation;
//     map['status'] = status;
//     map['points'] = points;
//     map['type'] = type;
//     map['fontSize'] = fontSize;
//     if (widgets != null) {
//       map['widgets'] = widgets?.map((v) => v.toJson()).toList();
//     }
//     return map;
//   }
//
// }
//
// class Widgets {
//   Widgets({
//       this.id,
//       this.x,
//       this.y,
//       this.width,
//       this.height,
//       this.border,
//       this.borderWidth,
//       this.fill,
//       this.scaleX,
//       this.scaleY,
//       this.radius,
//       this.data,
//       this.label,
//       this.rotation,
//       this.status,
//       this.points,
//       this.type,
//       this.fontSize,
//       this.widgets,});
//
//   Widgets.fromJson(dynamic json) {
//     id = json['id'];
//     x = json['x'];
//     y = json['y'];
//     width = json['width'];
//     height = json['height'];
//     border = json['border'];
//     borderWidth = json['borderWidth'];
//     fill = json['fill'];
//     scaleX = json['scaleX'];
//     scaleY = json['scaleY'];
//     radius = json['radius'];
//     data = json['data'];
//     label = json['label'];
//     rotation = json['rotation'];
//     status = json['status'];
//     points = json['points'];
//     type = json['type'];
//     fontSize = json['fontSize'];
//     widgets = json['widgets'];
//   }
//   num? id;
//   num? x;
//   num? y;
//   dynamic width;
//   dynamic height;
//   dynamic border;
//   dynamic borderWidth;
//   String? fill;
//   num? scaleX;
//   num? scaleY;
//   dynamic radius;
//   dynamic data;
//   String? label;
//   dynamic rotation;
//   num? status;
//   dynamic points;
//   num? type;
//   num? fontSize;
//   dynamic widgets;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = id;
//     map['x'] = x;
//     map['y'] = y;
//     map['width'] = width;
//     map['height'] = height;
//     map['border'] = border;
//     map['borderWidth'] = borderWidth;
//     map['fill'] = fill;
//     map['scaleX'] = scaleX;
//     map['scaleY'] = scaleY;
//     map['radius'] = radius;
//     map['data'] = data;
//     map['label'] = label;
//     map['rotation'] = rotation;
//     map['status'] = status;
//     map['points'] = points;
//     map['type'] = type;
//     map['fontSize'] = fontSize;
//     map['widgets'] = widgets;
//     return map;
//   }
//
// }