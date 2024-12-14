import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../../core/responses/no_params.dart';
import '../../../core/utils/helper.dart';

class SMSService {
  Future<Either<String, NoParams>> doSendSMS({
    required String message,
    required String phoneNumber,
    required bool smsCoolDownFinished,
    required bool isManager,
    required bool showConfirmDialog,
    required bool isInquiry,
  }) async {
    try {
      /// Cannot send SMS rapidly. It has cooldown
      if (!smsCoolDownFinished) return Left(translate('sms_cooldown'));

      /// Only managers should be able to change anything.
      /// None managers only can inquiry in home page
      if (!isManager && !isInquiry) return Left(translate('not_manager'));

      if (Platform.isAndroid) {
        /// Hnadle sms permission
        if (!await hasSMSPermission()) {
          if (!await requestForSMSPermission()) {
            return Left(translate('no_sms_permission'));
          }
        }
      }

      if (showConfirmDialog) {
        /// Should ask for confirmation
        if (!(await askForConfirmation())) return const Left('');
      }

      String sendSMSResult = await sendSMS(
        message: message,
        recipients: [phoneNumber],
        sendDirect: Platform.isAndroid,
      );
      if (sendSMSResult.toLowerCase().contains('sent')) {
        toastGenerator(translate('message_sended'));
        return const Right(NoParams());
      }
      return Left(translate('internal_error'));
    } catch (e) {
      return Left(translate('internal_error'));
    }
  }
}
