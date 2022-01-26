import 'package:expense_tracker/exports.dart';
import 'package:expense_tracker/providers/main_provider.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  final List<Widget> _items = const [HomePage(), HomePage(), HomePage()];

  @override
  Widget build(BuildContext context) {
    final index = ref.watch(mainProvider);
    return Scaffold(
        body: IndexedStack(
          index: index,
          children: _items,
        ),
        bottomNavigationBar: BottomNavigationBar(
          iconSize: 29,
          currentIndex: index,
          onTap: ref.watch(mainProvider.notifier).changeTab,
          backgroundColor: AppColors.kDark,
          items: _bottomNavigationBarItems
              .map(
                (item) => BottomNavigationBarItem(
                  icon: Icon(item.icon),
                  activeIcon: Icon(item.activeIcon),
                  label: item.label,
                ),
              )
              .toList(),
        ));
  }
}

const _bottomNavigationBarItems = <_Item>[
  _Item(
    'Home',
    icon: PhosphorIcons.houseSimple,
    activeIcon: PhosphorIcons.houseSimpleFill,
  ),
  _Item(
    'Insights',
    icon: PhosphorIcons.trendUp,
    activeIcon: PhosphorIcons.trendUpFill,
  ),
  _Item(
    'Settings',
    icon: PhosphorIcons.nut,
    activeIcon: PhosphorIcons.nutFill,
  ),
];

class _Item {
  final String label;
  final IconData icon, activeIcon;
  const _Item(this.label, {required this.icon, required this.activeIcon});
}
