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
      currency: fields[2] as CurrencyModel,
      onboardingComplete: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, UserPreferenceModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.showEntryDate)
      ..writeByte(1)
      ..write(obj.inboxAmount)
      ..writeByte(2)
      ..write(obj.currency)
      ..writeByte(3)
      ..write(obj.onboardingComplete);
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
