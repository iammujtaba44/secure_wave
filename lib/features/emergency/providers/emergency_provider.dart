import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:secure_wave/features/emergency/mapper/faq_mapper.dart';
import 'package:secure_wave/features/emergency/models/faq_model.dart';
import 'package:secure_wave/features/emergency/models/support_model.dart';
import 'package:secure_wave/services/database_service/i_database_service.dart';

class EmergencyProvider extends ChangeNotifier {
  final IDatabaseService _databaseService;

  EmergencyProvider({required IDatabaseService databaseService})
      : _databaseService = databaseService;

  SupportModel? _support;
  List<FAQModel>? _faq;

  SupportModel? get support => _support;
  List<FAQModel>? get faq => _faq;

  Future<void> getSupportContact() async {
    try {
      final supportContact = await _databaseService.getData('support');
      _support = SupportModel.fromJson(supportContact);
      notifyListeners();
    } catch (e) {
      log('supportContact error: $e');
    }
  }

  Future<void> getFAQ() async {
    try {
      final faq = await _databaseService.getData('FAQ');

      _faq = FaqMapper.mapQuestions(faq);
      notifyListeners();
    } catch (e) {
      log('FAQ error: $e');
    }
  }

  Future<void> sendEmergencyAlert(String message) async {
    await _databaseService.setData('emergency', {'message': message});
  }
}
