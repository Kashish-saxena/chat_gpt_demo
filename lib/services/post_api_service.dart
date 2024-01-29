import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class ChatApi {
  static Future<String> generateText(String prompt) async {
    try {
      var url = Uri.parse('https://api.openai.com/v1/chat/completions');
      var response = await http.post(url,
          headers: {
            "Content-Type": "application/json",
            "Authorization":
                "Bearer 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",
          },
          body: json.encode({
            "model": "gpt-3.5-turbo",
            "messages": [
              {"role": "user", "content": prompt}
            ],
            "temperature": 0.7
          }));
      if (response.statusCode == 200) {
        log(response.body);
        return response.body;
      } else {
        return "Failed: ${response.body}";
      }
    } catch (e) {
      return "Failed: $e";
    }
  }
}
