import 'package:expense_tracker/exports.dart';
import 'package:expense_tracker/ui/home/expense_list_item.dart';

enum Tabs { today, month }

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            floating: true,
            expandedHeight: 220,
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  PhosphorIcons.plusFill,
                  color: Colors.white,
                ),
              )
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Spent this week',
                    style: textTheme.overline!.copyWith(
                      color: Colors.white60,
                      fontSize: FontSizes.s8,
                    ),
                  ),
                  Text(
                    '\$2,445,100',
                    style: textTheme.headline5!.copyWith(color: Colors.white),
                  ),
                ],
              ),
              titlePadding: const EdgeInsets.only(
                left: Insets.lg,
                bottom: Insets.lg,
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate(
            [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Insets.lg,
                  vertical: Insets.md,
                ),
                child: Container(
                  height: 40,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: AppColors.kLightGrey,
                    borderRadius: Corners.lgBorder,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.kDark,
                            borderRadius: Corners.lgBorder,
                          ),
                          child: Center(
                              child: Text('Today',
                                  style: textTheme.bodyText1!.copyWith(
                                    color: Colors.white,
                                  ))),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            // color: AppColors.kDark,
                            color: AppColors.kLightGrey,

                            borderRadius: Corners.lgBorder,
                          ),
                          child: Center(
                            child: Text(
                              'Month',
                              style: textTheme.bodyText1!.copyWith(
                                  // color: Colors.white,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Insets.lg),
                child: Text('25th Jan 2022', style: textTheme.bodyText1!),
              ),
              const SizedBox(height: Insets.sm),
              for (int i = 0; i < 27; i++)
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: Insets.lg),
                  child: ExpenseListItem(),
                )
            ],
          )),
        ],
      ),
    );
  }
}
