import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:gemini/src/game/fruit.dart';
import 'package:gemini/src/game/providers.dart';
import 'package:gemini/src/game/ui_state_notifier.dart';

class ViewResult extends ConsumerWidget {
  final bool correct;
  final Fruit fruit;

  const ViewResult(this.correct, this.fruit, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: correct ? fruit.color : Colors.red,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          fruit.lottie,
          Text(
            correct ? 'Bingo!' : 'sorry :(',
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(color: Colors.white),
          ),
          Text(
            correct ? 'Your picked ${fruit.name}.' : 'The Answer is ${fruit.name}',
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(color: Colors.white),
          ),
          const Gap(32),
          ElevatedButton(onPressed: (){
            ref
                .read(Providers.uiStateNotifier.notifier)
                .updateState(UIState.notStarted);
          }, child: const Text('Try Again'))
        ],
      ),
    );
  }
}

// class ViewResult extends ConsumerStatefulWidget {
//   final bool correct;
//   final Fruit fruit;
//   const ViewResult(this.correct, this.fruit, {super.key});
//
//   @override
//   ConsumerState<ViewResult> createState() => _ViewResultState();
// }
//
// class _ViewResultState extends ConsumerState<ViewResult> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: double.infinity,
//       width: double.infinity,
//       color: fruit.colo
//     );
//   }
// }
