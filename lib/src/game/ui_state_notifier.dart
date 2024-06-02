


import 'package:flutter_riverpod/flutter_riverpod.dart';


enum UIState {
  notStarted,
  loading,
  loaded,
  correct,
  incorrect,
}

class UIStateNotifier extends Notifier<UIState> {
  @override
  UIState build() => UIState.notStarted;

  void updateState(UIState uiState) => state = uiState;
}

// enum UIState{
//   notStarted,
//   loading,
//   loaded
// }
//
//
// class UIStateNotifier extends Notifier<UIState>{
//
//   @override
//   UIState build() {
//     // TODO: implement ==
//     return UIState.notStarted;
//   }
//   // @override
//   // UIState build()=> UIState.notStarted;
//
// }