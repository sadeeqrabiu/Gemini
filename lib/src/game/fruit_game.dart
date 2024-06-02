import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:gemini/src/game/global.dart';
import 'package:gemini/src/game/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini/src/game/ui_state_notifier.dart';
import 'package:gemini/src/game/view_result.dart';
import 'dart:core';

import 'fruit.dart';

class FruitGame extends ConsumerStatefulWidget {
  const FruitGame({super.key});

  @override
  ConsumerState<FruitGame> createState() => _FruitGameState();
}

class _FruitGameState extends ConsumerState<FruitGame> {
  final gemini = Gemini.instance;
  final controller = TextEditingController();

  late Fruit fruit;

  // final ref = Ref;

  Widget _buildButton(UIState uiState) {
    switch (uiState) {
      case UIState.notStarted:
        return ElevatedButton(
          onPressed: () {
            ref
                .read(Providers.uiStateNotifier.notifier)
                .updateState(UIState.loading);

            _streamGenerativeContent();
          },
          child: const Text('Let\'s Get Started'),
        );
      case UIState.loading:
        return const ElevatedButton(
          onPressed: null,
          child: Text('Loading...'),
        );
      case UIState.loaded:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: 'Which fruit is this rap about?',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              prefix: IconButton(
                onPressed: () => controller.clear(),
                icon: const Icon(
                  Icons.cancel,
                ),
              ),
              suffix: IconButton(
                onPressed: () {
                  if (controller.text == fruit.name) {
                    ref
                        .read(Providers.uiStateNotifier.notifier)
                        .updateState(UIState.correct);
                  } else {
                    ref
                        .read(Providers.uiStateNotifier.notifier)
                        .updateState(UIState.incorrect);
                  }

                  controller.clear();
                },
                icon: const Icon(
                  Icons.send,
                ),
              ),
            ),
          ),
        );
      case UIState.correct:
      case UIState.incorrect:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    final uiState = ref.watch(Providers.uiStateNotifier);

    if (uiState == UIState.correct) {
      return ViewResult(true, fruit);
    }
    if (uiState == UIState.incorrect) {
      return ViewResult(false, fruit);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('fruit rap'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  child: GeminiResponseTypeView(
                      builder: ((context, child, response, loading) {
                    if (loading) {
                      return Globals.lottieFruitBasket;
                    }
                    if (response != null) {
                      return Text(response);
                    }
                    return const SizedBox();
                  })),
                ),
              ),
            ),
            _buildBtn(uiState),
          ],
        ),
      ),
    );
  }

  Widget _buildBtn(UIState uiState) {
    switch (uiState) {
      case UIState.notStarted:
        return ElevatedButton(
            onPressed: () {
              ref
                  .read(Providers.uiStateNotifier.notifier)
                  .updateState(UIState.loading);
              _streamGenerativeContent();
            },
            child: const Text('Let\'s get started'));

      case UIState.loading:
        return const ElevatedButton(
            onPressed: null, child: Text('Loading....'));
      case UIState.loaded:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
                labelText: 'what\'s your rap About',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                prefix: IconButton(
                  onPressed: () => controller.clear(),
                  icon: const Icon(Icons.cancel),
                ),
                suffix: IconButton(
                  onPressed: () {
                    if (controller.text == fruit.name) {
                      ref
                          .read(Providers.uiStateNotifier.notifier)
                          .updateState(UIState.correct);
                    } else {
                      ref
                          .read(Providers.uiStateNotifier.notifier)
                          .updateState(UIState.incorrect);
                    }
                    controller.clear();
                  },
                  icon: const Icon(Icons.send),
                )),
          ),
        );
      case UIState.correct:
        return ElevatedButton(onPressed: () {}, child: const Text('Correct'));
      case UIState.incorrect:
        return ElevatedButton(onPressed: () {}, child: const Text('Correct'));
    }
  }

  void _streamGenerativeContent() {
    fruit = Globals.fruits[Random().nextInt(Globals.fruits.length)];
    final prompt =
        'Give me a rap about the fruit ${fruit.name}, but do not use the word ${fruit.name} in the rap';

    print(prompt);
    gemini.streamGenerateContent(prompt,
        generationConfig: GenerationConfig(
          temperature: 1,
        ),
        safetySettings: [
          SafetySetting(
              category: SafetyCategory.hateSpeech,
              threshold: SafetyThreshold.blockLowAndAbove),
          SafetySetting(
              category: SafetyCategory.harassment,
              threshold: SafetyThreshold.blockLowAndAbove)
        ]).listen((event) {
      ref.read(Providers.uiStateNotifier.notifier).updateState(UIState.loaded);
    });
  }
}
