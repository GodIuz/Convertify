import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class ConverterDocService {
  final String apiKey = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZjAwMzU5YTViZDgxMmE1ZmFkMmExMmIzMjk1ZWMwNzZkNDJlYjFjNWM4ZjUzMjY4OTcyNTUxNTgyMjk5ZDMxY2JhZGRkYWRhMWI3M2U4OWYiLCJpYXQiOjE3Nzc4NjA5MjQuNDMyMjM2LCJuYmYiOjE3Nzc4NjA5MjQuNDMyMjM4LCJleHAiOjQ5MzM1MzQ1MjQuNDI0OTUzLCJzdWIiOiI3NTM5MjQ3OCIsInNjb3BlcyI6WyJ0YXNrLnJlYWQiLCJ0YXNrLndyaXRlIl19.cp7aUQQs2quelBAsNxpT6awH0TWWXhT4j9mGczIHuZO0NLeoCDfFI6LXlyPt8eiVmLaFrpA32rJvXDxE2UYiihcIZmGaDGXjrgEt7oZt-cJHHOgfabEQOramLG8H2bnHl3eje-sV56UIeCz3arVC71fR1BJ63tOaptpTVmaHbSsseDp1V0fAMaSFnEP5Q23Mxjw4vXU-WCbYKuLYNAzgNEG0qEI-QHQvnFEcN_bx0KNxgeYeveYAlEWl0Nhjg2zKjfLblpObZOZxq1U2ZWMM-9Xko5G_BLkUoBZkm-W7_JF1elj12wvue5A9iM3LwMdncBJjkltseiJRnizdQSy7iPRTe_6TKrlkqmtZCiNYNGjuFVG-QP2nbocp1HSziz4l9yNAcCIcEGcUaCtmjogWDS4QyZC-1pBKF9IykaMBOwAZPhTukbboVR-rJg78DvDmw6FIGd-wXocJyeb5F26JsG7uAoBwhwcfbgP-2r87n5JRbO7HgsZQx5Mgk-eSTUoT-j7eAIhEMskusQHYy0EzFsfSFBXD4aIJk3Cbf2kzs6G-GHixDDbSF-Ja2nwo5i28srHTGYW8qBx0BDUY4vezr3TQQN3djb-TOCUaRnE5gNzVmHshuJMoLJSl2rF8WhhZOIa9NOUwhfyw-t5sKfOmPbt3qcJlrkCMlkvcoSaMsMk";
  Future<Uint8List?> convertDocument({
    required Uint8List fileBytes,
    required String fileName,
    required String targetFormat,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('https://api.cloudconvert.com/v2/jobs'),
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "tasks": {
            "import-1": {
              "operation": "import/base64",
              "file": base64Encode(fileBytes),
              "filename": fileName
            },
            "convert-1": {
              "operation": "convert",
              "input": "import-1",
              "output_format": targetFormat,
            },
            "export-1": {
              "operation": "export/url",
              "input": "convert-1"
            }
          }
        }),
      );
      if (response.statusCode == 201) {
        var jobData = jsonDecode(response.body);
        String jobId = jobData['data']['id'];
        String? downloadUrl;
        while (downloadUrl == null) {
          await Future.delayed(const Duration(seconds: 2));
          final statusRes = await http.get(
            Uri.parse('https://api.cloudconvert.com/v2/jobs/$jobId'),
            headers: {'Authorization': 'Bearer $apiKey'},
          );
          var statusData = jsonDecode(statusRes.body);
          var tasks = statusData['data']['tasks'] as List;
          var exportTask = tasks.firstWhere((t) => t['operation'] == 'export/url');
          if (exportTask['status'] == 'finished') {
            downloadUrl = exportTask['result']['files'][0]['url'];
          } else if (exportTask['status'] == 'error') {
            throw Exception("CloudConvert Failed");
          }
        }
        final fileRes = await http.get(Uri.parse(downloadUrl));
        return fileRes.bodyBytes;
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}