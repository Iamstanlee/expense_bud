enum InboxAmount { today, week, month }

class UserPreferenceEntity {
  final bool showEntryDate;
  final InboxAmount inboxAmount;

  UserPreferenceEntity({
    required this.showEntryDate,
    required this.inboxAmount,
  });

  UserPreferenceEntity copyWith({
    bool? showEntryDate,
    InboxAmount? inboxAmount,
  }) {
    return UserPreferenceEntity(
      showEntryDate: showEntryDate ?? this.showEntryDate,
      inboxAmount: inboxAmount ?? this.inboxAmount,
    );
  }

  @override
  String toString() =>
      'UserPreferenceEntity(showEntryDate: $showEntryDate, inboxAmount: $inboxAmount)';
}
