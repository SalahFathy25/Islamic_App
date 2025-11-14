import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../data/models/sheikh_model.dart';

part 'sheikhs_state.dart';

class SheikhsCubit extends Cubit<SheikhsState> {
  SheikhsCubit() : super(SheikhsInitial());

  Future<List<SheikhModel>> getSheikhs() async {
    emit(SheikhsLoading());
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('sheikhs')
          .get();

      final sheikhs = snapshot.docs
          .map((doc) => SheikhModel.fromJson(doc.data(), doc.id))
          .toList();

      emit(SheikhsLoaded(sheikhs));
      return sheikhs;
    } catch (e) {
      emit(SheikhsError(e.toString()));
      rethrow;
    }
  }

  Future<File> downloadAudio(String url, String fileName) async {
    final dir = await getApplicationDocumentsDirectory();
    final filePath = '${dir.path}/$fileName.mp3';
    final file = File(filePath);

    if (await file.exists()) return file;

    try {
      await Dio().download(url, file.path);
      return file;
    } catch (e) {
      throw Exception("فشل تحميل الملف: $e");
    }
  }
}
