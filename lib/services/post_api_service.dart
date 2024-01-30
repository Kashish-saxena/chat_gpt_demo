import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class ChatApi {
  static Future<String> generateText(String prompt, String version) async {
    try {
      var url = Uri.parse('https://api.openai.com/v1/chat/completions');
      var response = await http.post(url,
          headers: {
            "Content-Type": "application/json",
            "Authorization":
                "Bearer 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",
          },
          body: json.encode({
            "model": version,
            "messages": [
              {"role": "user", "content": prompt}
            ],
            "temperature": 0.7
          }));
      if (response.statusCode == 200) {
        log(response.body);
        return response.body;
      } else {
        log("Failed >>>>>>>>>>>>>>>>> ${response.statusCode}");
        return "Failed: ${response.body}";
      }
    } catch (e) {
      return "Failed: $e";
    }
  }
}
