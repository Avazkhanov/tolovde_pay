import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:tolovde_pay/utils/constants/app_constants.dart';

class ApiProvider {
  static Future<String> sendNotificationToUsers({
    String? topicName,
    String? fcmToken,
    required String title,
    required String body,
  }) async {
    try {
      debugPrint("Kirdi");
      http.Response response = await http.post(
        Uri.parse(AppConstants.baseUrl),
        headers: {
          "Authorization":
          "key= ${AppConstants.apiKey}",
          "Content-Type": "application/json",
        },
        body: jsonEncode(
          {
            "to": topicName != null ? "/topics/$topicName" : fcmToken,
            "notification": {
              "title": title,
              "body": body,
              "sound": "default",
              "priority": "high"
            },
            "data": {
              "news_image":
              "https://top.uz/upload/iblock/0de/0dec725e4583a0698a8732ca646a4994.png",
              "news_title": "Test",
              "news_text":
              "Finland's national carrier Finnair has started weighing passengers on its flights from the capital city of Helsinki. The weigh-ins are being done on a voluntary basis and are completely anonymous. A company spokesperson said the new initiative is to ensure safety standards on flights are adhered to. He said any airplane should not exceed the prescribed maximum weight for safe take-offs and landings."
            }
          },
        ),
      );
      debugPrint("yuborildi");
      if (response.statusCode == HttpStatus.ok) {
        debugPrint("DATA:${response.body}");
        return response.body.toString();
      }
    } catch (err) {
      debugPrint(err.toString());
    }

    return "ERROR";
  }
}