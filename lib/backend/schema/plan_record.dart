import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'plan_record.g.dart';

abstract class PlanRecord implements Built<PlanRecord, PlanRecordBuilder> {
  static Serializer<PlanRecord> get serializer => _$planRecordSerializer;

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

  @BuiltValueField(wireName: 'gcash_url')
  String? get gcashUrl;

  String? get image;

  bool? get paymentstatus;

  @BuiltValueField(wireName: 'user_email')
  DocumentReference? get userEmail;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  static void _initializeBuilder(PlanRecordBuilder builder) => builder
    ..name = ''
    ..description = ''
    ..specifications = ''
    ..price = 0.0
    ..onSale = false
    ..salePrice = 0.0
    ..quantity = 0
    ..gcashUrl = ''
    ..image = ''
    ..paymentstatus = false;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Plan');

  static Stream<PlanRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<PlanRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  PlanRecord._();
  factory PlanRecord([void Function(PlanRecordBuilder) updates]) = _$PlanRecord;

  static PlanRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createPlanRecordData({
  String? name,
  String? description,
  String? specifications,
  double? price,
  DateTime? createdAt,
  DateTime? modifiedAt,
  bool? onSale,
  double? salePrice,
  int? quantity,
  String? gcashUrl,
  String? image,
  bool? paymentstatus,
  DocumentReference? userEmail,
}) {
  final firestoreData = serializers.toFirestore(
    PlanRecord.serializer,
    PlanRecord(
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
        ..gcashUrl = gcashUrl
        ..image = image
        ..paymentstatus = paymentstatus
        ..userEmail = userEmail,
    ),
  );

  return firestoreData;
}
