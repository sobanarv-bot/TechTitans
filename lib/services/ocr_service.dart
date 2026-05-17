import 'dart:io';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class OCRService {
  final _textRecognizer = TextRecognizer();

  Future<String> extractText(File imageFile) async {
    final inputImage = InputImage.fromFile(imageFile);
    final recognizedText = await _textRecognizer.processImage(inputImage);
    return recognizedText.text;
  }

  double? extractTotalAmount(String text) {
    final regex = RegExp(r'(\d+[\.,]?\d{0,2})');
    final matches = regex.allMatches(text);

    double max = 0;

    for (final m in matches) {
      final value = double.tryParse(m.group(0)!.replaceAll(',', '.')) ?? 0;
      if (value > max) max = value;
    }

    return max == 0 ? null : max;
  }

  String guessCategory(String text) {
    text = text.toLowerCase();

    if (text.contains('mcd') || text.contains('kfc')) return 'Food';
    if (text.contains('grab') || text.contains('taxi')) return 'Transport';
    if (text.contains('tesco') || text.contains('mall')) return 'Shopping';

    return 'Other';
  }

  void dispose() {
    _textRecognizer.close();
  }
}