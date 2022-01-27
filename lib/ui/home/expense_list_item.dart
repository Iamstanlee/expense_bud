import 'package:expense_tracker/exports.dart';

class ExpenseListItem extends StatelessWidget {
  const ExpenseListItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                style: context.textTheme.bodyText1!,
              ),
            ],
          ),
          const Spacer(),
          Text(
            '\$3,400',
            style: context.textTheme.bodyText2!.copyWith(
              color: const Color(0xFFE58D67),
            ),
          )
        ],
      ),
    );
  }
}
