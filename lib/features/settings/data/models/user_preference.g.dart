// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_preference.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserPreferenceModelAdapter extends TypeAdapter<UserPreferenceModel> {
  @override
  final int typeId = 1;

  @override
  UserPreferenceModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserPreferenceModel(
      showEntryDate: fields[0] as bool,
      inboxAmount: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserPreferenceModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.showEntryDate)
      ..writeByte(1)
      ..write(obj.inboxAmount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserPreferenceModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
