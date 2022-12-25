import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'order_record.g.dart';

abstract class OrderRecord implements Built<OrderRecord, OrderRecordBuilder> {
  static Serializer<OrderRecord> get serializer => _$orderRecordSerializer;

  String? get name;

  double? get price;

  @BuiltValueField(wireName: 'created_at')
  DateTime? get createdAt;

  String? get userID;

  @BuiltValueField(wireName: 'PaymentStatus')
  String? get paymentStatus;

  String? get productImage;

  @BuiltValueField(wireName: 'gcash_url')
  String? get gcashUrl;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  static void _initializeBuilder(OrderRecordBuilder builder) => builder
    ..name = ''
    ..price = 0.0
    ..userID = ''
    ..paymentStatus = ''
    ..productImage = ''
    ..gcashUrl = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('order');

  static Stream<OrderRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<OrderRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  OrderRecord._();
  factory OrderRecord([void Function(OrderRecordBuilder) updates]) =
      _$OrderRecord;

  static OrderRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createOrderRecordData({
  String? name,
  double? price,
  DateTime? createdAt,
  String? userID,
  String? paymentStatus,
  String? productImage,
  String? gcashUrl,
}) {
  final firestoreData = serializers.toFirestore(
    OrderRecord.serializer,
    OrderRecord(
      (o) => o
        ..name = name
        ..price = price
        ..createdAt = createdAt
        ..userID = userID
        ..paymentStatus = paymentStatus
        ..productImage = productImage
        ..gcashUrl = gcashUrl,
    ),
  );

  return firestoreData;
}
