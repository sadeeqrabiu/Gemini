import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini/src/game/ui_state_notifier.dart';


class Providers {
  static final uiStateNotifier =
  NotifierProvider<UIStateNotifier, UIState>(UIStateNotifier.new);
}
