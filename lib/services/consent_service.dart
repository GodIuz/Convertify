import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class ConsentService {
  static Future<void> initConsent() async {
    final completer = Completer<void>();
    debugPrint("UMP: Ξεκινάει η διαδικασία...");
    await ConsentInformation.instance.reset();
    debugPrint("UMP: Η μνήμη καθαρίστηκε (Reset)");
    final debugSettings = ConsentDebugSettings(
      debugGeography: DebugGeography.debugGeographyEea,
      testIdentifiers: ['695E3A4DC66B22C568B75540C43E4992'],
    );
    final params = ConsentRequestParameters(consentDebugSettings: debugSettings);
    ConsentInformation.instance.requestConsentInfoUpdate(
      params,
          () async {
        bool isAvailable = await ConsentInformation.instance.isConsentFormAvailable();
        debugPrint("UMP: Είναι η φόρμα διαθέσιμη; $isAvailable");
        if (isAvailable) {
          _loadAndShowForm(completer);
        } else {
          debugPrint("UMP: Η Google είπε ότι ΔΕΝ υπάρχει φόρμα για να δείξω.");
          completer.complete();
        }
      },
          (FormError error) {
        debugPrint("UMP Update Error: ${error.message}");
        completer.complete();
      },
    );
    return completer.future;
  }

  static void _loadAndShowForm(Completer<void> completer) {
    debugPrint("UMP: Ξεκινάει το φόρτωμα της φόρμας...");
    ConsentForm.loadConsentForm(
          (ConsentForm consentForm) {
        debugPrint("UMP: Η φόρμα φορτώθηκε! Τώρα την εμφανίζω...");
        consentForm.show((FormError? error) {
          if (error != null) {
            debugPrint("UMP Show Error: ${error.message}");
          } else {
            debugPrint("UMP: Ο χρήστης έκλεισε τη φόρμα επιτυχώς.");
          }
          completer.complete();
        });
      },
          (FormError error) {
        debugPrint("UMP Load Error: ${error.message}");
        completer.complete();
      },
    );
  }
}