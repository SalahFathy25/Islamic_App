// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'downloaded_surah.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DownloadedSurahAdapter extends TypeAdapter<DownloadedSurah> {
  @override
  final int typeId = 0;

  @override
  DownloadedSurah read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DownloadedSurah(
      sheikhId: fields[0] as String,
      surahNumber: fields[1] as int,
      surahName: fields[2] as String,
      filePath: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DownloadedSurah obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.sheikhId)
      ..writeByte(1)
      ..write(obj.surahNumber)
      ..writeByte(2)
      ..write(obj.surahName)
      ..writeByte(3)
      ..write(obj.filePath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DownloadedSurahAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
