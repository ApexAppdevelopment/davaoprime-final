import 'dart:async';

import '../index.dart';
import '../serializers.dart';
import 'package:built_value/built_value.dart';

part 'plan_struct.g.dart';

abstract class PlanStruct implements Built<PlanStruct, PlanStructBuilder> {
  static Serializer<PlanStruct> get serializer => _$planStructSerializer;

  String? get name;

  String? get description;

  String? get specifications;

  double? get price;

  @BuiltValueField(wireName: 'created_at')
  DateTime? get createdAt;

  @BuiltValueField(wireName: 'modified_at')
  DateTime? get modifiedAt;

  @BuiltValueField(wireName: 'on_sale')
  bool? get onSale;

  @BuiltValueField(wireName: 'sale_price')
  double? get salePrice;

  int? get quantity;

  /// Utility class for Firestore updates
  FirestoreUtilData get firestoreUtilData;

  static void _initializeBuilder(PlanStructBuilder builder) => builder
    ..name = ''
    ..description = ''
    ..specifications = ''
    ..price = 0.0
    ..onSale = false
    ..salePrice = 0.0
    ..quantity = 0
    ..firestoreUtilData = FirestoreUtilData();

  PlanStruct._();
  factory PlanStruct([void Function(PlanStructBuilder) updates]) = _$PlanStruct;
}

PlanStruct createPlanStruct({
  String? name,
  String? description,
  String? specifications,
  double? price,
  DateTime? createdAt,
  DateTime? modifiedAt,
  bool? onSale,
  double? salePrice,
  int? quantity,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    PlanStruct(
      (p) => p
        ..name = name
        ..description = description
        ..specifications = specifications
        ..price = price
        ..createdAt = createdAt
        ..modifiedAt = modifiedAt
        ..onSale = onSale
        ..salePrice = salePrice
        ..quantity = quantity
        ..firestoreUtilData = FirestoreUtilData(
          clearUnsetFields: clearUnsetFields,
          create: create,
          delete: delete,
          fieldValues: fieldValues,
        ),
    );

PlanStruct? updatePlanStruct(
  PlanStruct? plan, {
  bool clearUnsetFields = true,
}) =>
    plan != null
        ? (plan.toBuilder()
              ..firestoreUtilData =
                  FirestoreUtilData(clearUnsetFields: clearUnsetFields))
            .build()
        : null;

void addPlanStructData(
  Map<String, dynamic> firestoreData,
  PlanStruct? plan,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (plan == null) {
    return;
  }
  if (plan.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  if (!forFieldValue && plan.firestoreUtilData.clearUnsetFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final planData = getPlanFirestoreData(plan, forFieldValue);
  final nestedData = planData.map((k, v) => MapEntry('$fieldName.$k', v));

  final create = plan.firestoreUtilData.create;
  firestoreData.addAll(create ? mergeNestedFields(nestedData) : nestedData);

  return;
}

Map<String, dynamic> getPlanFirestoreData(
  PlanStruct? plan, [
  bool forFieldValue = false,
]) {
  if (plan == null) {
    return {};
  }
  final firestoreData = serializers.toFirestore(PlanStruct.serializer, plan);

  // Add any Firestore field values
  plan.firestoreUtilData.fieldValues.forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getPlanListFirestoreData(
  List<PlanStruct>? plans,
) =>
    plans?.map((p) => getPlanFirestoreData(p, true)).toList() ?? [];
