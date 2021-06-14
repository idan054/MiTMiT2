import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latlong/latlong.dart';

import 'schema_util.dart';
import 'serializers.dart';

part 'main_chat_record.g.dart';

abstract class MainChatRecord
    implements Built<MainChatRecord, MainChatRecordBuilder> {
  static Serializer<MainChatRecord> get serializer =>
      _$mainChatRecordSerializer;

  @nullable
  String get text;

  @nullable
  DateTime get timestamp;

  @nullable
  DocumentReference get user;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(MainChatRecordBuilder builder) =>
      builder..text = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('main_chat');

  static Stream<MainChatRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  MainChatRecord._();
  factory MainChatRecord([void Function(MainChatRecordBuilder) updates]) =
      _$MainChatRecord;
}

Map<String, dynamic> createMainChatRecordData({
  String text,
  DateTime timestamp,
  DocumentReference user,
}) =>
    serializers.toFirestore(
        MainChatRecord.serializer,
        MainChatRecord((m) => m
          ..text = text
          ..timestamp = timestamp
          ..user = user));

MainChatRecord get dummyMainChatRecord {
  final builder = MainChatRecordBuilder()
    ..text = dummyString
    ..timestamp = dummyTimestamp;
  return builder.build();
}

List<MainChatRecord> createDummyMainChatRecord({int count}) =>
    List.generate(count, (_) => dummyMainChatRecord);
