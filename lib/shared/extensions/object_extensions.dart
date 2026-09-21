import 'package:smart_warehouse/shared/common/error_entity.dart';

extension ObjectExt on Object {
  T? as<T>({T? defaultValue}) {
    if (this is T) {
      return this as T;
    }

    return defaultValue;
  }
}

extension ObjectNullableExt on Object? {
  T value<T>() {
    if (this == null) {
      throw NullPointerErrorEntity();
    }

    return this! as T;
  }
}

extension ObjectKotlinExt<T> on T? {
  R? let<R>(R Function(T that) op) {
   if (this != null) {
     return op(this as T);
   }
   return null;
  }
}
