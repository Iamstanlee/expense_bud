import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:expense_bud/config/constants.dart';
import 'package:expense_bud/core/utils/safe_print.dart';
import 'package:expense_bud/features/expense/presentation/add_entry.dart';
import 'package:expense_bud/injector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

final List<String> notificationMessages = [
  "Don’t forget to log your expenses today—your future self will thank you!",
  "Just spent money? Make sure to track it now before you forget!",
  "Your wallet’s talking—track your spending to stay on budget!",
  "Consistency is key! Log your expenses today and keep your streak alive!",
  "A quick check-in can save big bucks. Review your spending now!",
  "How’s your week looking? A 2-minute budget review might surprise you!",
  "Hey! Haven’t seen you in a while—ready to track some expenses?",
  "Your financial goals miss you. Let’s get back on track today!",
  "Take control of your money again. Track your spending now!"
];

abstract class ILocalNotificationService {
  Future<void> init();

  Future<void> scheduleNotificationsForSpecificTimes(int daysToSchedule);
}

class LocalNotificationService implements ILocalNotificationService {
  final AwesomeNotifications notification;
  final Box box;

  LocalNotificationService(this.notification, this.box);

  @override
  Future<void> init() async {
    final isNotificationAllowed = await notification.isNotificationAllowed();
    if (!isNotificationAllowed) {
      await notification.requestPermissionToSendNotifications();
    }

    notification.initialize(
      'resource://drawable/app_icon',
      [
        NotificationChannel(
          channelKey: 'default_channel',
          channelName: 'Default Notifications',
          channelDescription: 'Notification channel for general reminders',
          defaultColor: AppColors.kPrimary,
          importance: NotificationImportance.High,
        )
      ],
    );

    notification.setListeners(
      onActionReceivedMethod: LocalNotificationService.onNotificationClick,
    );

    if (isNotificationAllowed) {
      scheduleNotificationsForSpecificTimes(14);
    }
  }

  /// Schedules notifications at specific times (9 AM, 12 PM, 3 PM, 6 PM) for the given number of days
  @override
  Future<void> scheduleNotificationsForSpecificTimes(int daysToSchedule) async {
    if (!(await _needsRescheduling(daysToSchedule))) {
      safePrint('No notification rescheduling needed');
      return; // Exit if no rescheduling is needed
    }

    final localTimezone = await notification.getLocalTimeZoneIdentifier();

    final notificationTimes = [
      const TimeOfDay(hour: 9, minute: 0), // 9 AM
      const TimeOfDay(hour: 12, minute: 0), // 12 PM
      const TimeOfDay(hour: 15, minute: 0), // 3 PM
      const TimeOfDay(hour: 18, minute: 0), // 6 PM
    ];

    for (int dayOffset = 0; dayOffset < daysToSchedule; dayOffset++) {
      for (final time in notificationTimes) {
        final message =
            notificationMessages[Random().nextInt(notificationMessages.length)];
        final notificationId = Random().nextInt(10000);

        final scheduledDateTime = DateTime.now()
            .add(Duration(days: dayOffset))
            .toLocal()
            .copyWith(hour: time.hour, minute: time.minute, second: 0);

        final scheduled = await notification.createNotification(
          content: NotificationContent(
            id: notificationId,
            channelKey: 'default_channel',
            title: 'Friendly Reminder 🛎️',
            body: message,
            criticalAlert: true,
            payload: {
              'route': '/ADD_EXPENSE',
            },
          ),
          schedule: NotificationCalendar(
            year: scheduledDateTime.year,
            month: scheduledDateTime.month,
            day: scheduledDateTime.day,
            hour: scheduledDateTime.hour,
            minute: scheduledDateTime.minute,
            timeZone: localTimezone,
          ),
        );

        if (!scheduled) {
          safePrint('Failed to schedule notification');
        }
      }
    }

    // Update the last scheduled date
    await _setNotificationsScheduled(DateTime.now());
  }

  static const _lastScheduledDateKey = 'lastScheduledDate';

  /// Marks notifications as scheduled
  Future<void> _setNotificationsScheduled(DateTime lastScheduledDate) async {
    await box.put(_lastScheduledDateKey, lastScheduledDate.toIso8601String());
  }

  /// Gets the last scheduled date
  Future<DateTime?> _getLastScheduledDate() async {
    final lastScheduledDate = box.get(_lastScheduledDateKey);
    if (lastScheduledDate == null) return null;
    return DateTime.parse(lastScheduledDate);
  }

  /// Clears scheduling status
  Future<void> resetNotifications() async {
    await box.delete(_lastScheduledDateKey);
  }

  /// Checks if rescheduling is needed
  Future<bool> _needsRescheduling(int daysToSchedule) async {
    final lastScheduledDate = await _getLastScheduledDate();
    if (lastScheduledDate == null) return true;

    final endOfSchedule = lastScheduledDate.add(Duration(days: daysToSchedule));
    return DateTime.now().isAfter(endOfSchedule);
  }

  @pragma("vm:entry-point")
  static Future<void> onNotificationClick(ReceivedAction action) async {
    final payload = action.payload;
    if (payload != null) {
      if (payload['route'] == '/ADD_EXPENSE') {
        showCupertinoModalPopup(
          context: globalRoutingContextKey.currentContext!,
          builder: (BuildContext context) => const AddEntryPage(),
        );
      }
    }
  }
}
