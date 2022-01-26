import 'package:expense_tracker/exports.dart';

final mainProvider = StateNotifierProvider<MainStateProvider, int>((ref) {
  return MainStateProvider();
});

class MainStateProvider extends StateNotifier<int> {
  MainStateProvider() : super(0);

  void changeTab(int index) => state = index;
}
