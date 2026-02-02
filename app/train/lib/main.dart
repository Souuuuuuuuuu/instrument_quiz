import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: BandInstrumentTrainingApp()));
}

class Sample {
  final String imageUrl;
  final String answer;
  Sample(this.imageUrl, this.answer);

  factory Sample.fromList(List<String> list) {
    return Sample(list[0], list[1]);
  }
}

class BandInstrumentTrainingApp extends StatefulWidget {
  const BandInstrumentTrainingApp({super.key});
  @override
  State<BandInstrumentTrainingApp> createState() => _BandInstrumentTrainingAppState();
}

class _BandInstrumentTrainingAppState extends State<BandInstrumentTrainingApp> {
  static const String appTitle = 'バンドマン×楽器 判別トレーニング';

  /// ★ 確定データ（raw URL + 正解）
  final List<List<String>> data = [
    [
      "https://raw.githubusercontent.com/Souuuuuuuuuu/instrument_quiz/refs/heads/main/スクリーンショット%202026-02-02%2010.00.18.png",
      "〇 猪狩秀平（HEY-SMITH）— ギター"
    ],
    [
      "https://raw.githubusercontent.com/Souuuuuuuuuu/instrument_quiz/refs/heads/main/スクリーンショット%202026-02-02%2010.00.45.png",
      "〇 ゆうじ（HEY-SMITH）— ベース"
    ],
    [
      "https://raw.githubusercontent.com/Souuuuuuuuuu/instrument_quiz/refs/heads/main/スクリーンショット%202026-02-02%2010.01.20.png",
      "〇 マキシマムザ亮君（マキシマム ザ ホルモン）— ギター"
    ],
    [
      "https://raw.githubusercontent.com/Souuuuuuuuuu/instrument_quiz/refs/heads/main/スクリーンショット%202026-02-02%2010.02.01.png",
      "〇 上ちゃん（マキシマム ザ ホルモン）— ベース"
    ],
    [
      "https://raw.githubusercontent.com/Souuuuuuuuuu/instrument_quiz/refs/heads/main/スクリーンショット%202026-02-02%2010.02.22.png",
      "〇 Ryu-ta（04 Limited Sazabys）— ギター"
    ],
    [
      "https://raw.githubusercontent.com/Souuuuuuuuuu/instrument_quiz/refs/heads/main/スクリーンショット%202026-02-02%209.50.30.png",
      "〇 山中拓也（THE ORAL CIGARETTES）— ギター"
    ],
    [
      "https://raw.githubusercontent.com/Souuuuuuuuuu/instrument_quiz/refs/heads/main/スクリーンショット%202026-02-02%209.59.18.png",
      "〇 GEN（04 Limited Sazabys）— ベース"
    ],
    [
      "https://raw.githubusercontent.com/Souuuuuuuuuu/instrument_quiz/refs/heads/main/スクリーンショット%202026-02-02%209.59.58.png",
      "〇 あきらかにあきら（THE ORAL CIGARETTES）— ベース"
    ],
  ];

  late final List<Sample> _samples;
  int _index = 0;
  bool _showAnswer = false;

  @override
  void initState() {
    super.initState();
    _samples = data.map((e) => Sample.fromList(e)).toList();
    _samples.shuffle(Random());
  }

  void _onTap() {
    setState(() {
      if (_showAnswer) {
        _showAnswer = false;
        if (_index == _samples.length - 1) {
          _samples.shuffle(Random());
          _index = 0;
        } else {
          _index++;
        }
      } else {
        _showAnswer = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_samples.isEmpty) {
      return const Scaffold(
        body: Center(child: Text('データがありません')),
      );
    }

    final sample = _samples[_index];

    return Scaffold(
      appBar: AppBar(title: const Text(appTitle)),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _onTap,
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.network(
                sample.imageUrl,
                fit: BoxFit.contain,
                loadingBuilder: (c, w, p) =>
                    p == null ? w : const Center(child: CircularProgressIndicator()),
                errorBuilder: (e1, e2, e3) =>
                    const Center(child: Text('画像を読み込めません')),
              ),
            ),

            if (_showAnswer)
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  color: Colors.black54,
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    sample.answer,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

            Positioned(
              top: 10,
              right: 10,
              child: _hint(_showAnswer ? 'タップで次へ' : 'タップで答え表示'),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: _hint('${_index + 1}/${_samples.length}'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _hint(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(text, style: const TextStyle(color: Colors.white)),
    );
  }
}
