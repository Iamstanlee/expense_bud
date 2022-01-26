import 'package:expense_tracker/exports.dart';

class ExpenseListItem extends StatelessWidget {
  const ExpenseListItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      height: 64,
      child: Row(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(Insets.sm),
                decoration: BoxDecoration(
                    color: AppColors.kPrimary, shape: BoxShape.circle),
                child: const Icon(
                  PhosphorIcons.dogFill,
                  color: Colors.white,
                ),
              ),
              Gap.md,
              Text(
                'Food & Drinks',
                style: textTheme.bodyText2!.copyWith(
                  fontSize: FontSizes.s12,
                ),
              )
            ],
          ),
          const Spacer(),
          Text(
            '\$3,400',
            style: textTheme.bodyText2!.copyWith(
              fontSize: FontSizes.s14,
              color: const Color(0xFFE58D67),
            ),
          )
        ],
      ),
    );
  }
}
