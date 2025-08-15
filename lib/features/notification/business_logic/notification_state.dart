part of 'notification_cubit.dart';

@immutable
sealed class NotificationState {}

final class NotificationInitial extends NotificationState {}

/// Get All Notifications
final class GetNotificationsLoadingState extends NotificationState {}

final class GetNotificationsSuccessState extends NotificationState {
  final List<NotificationItem> notificationsDataModel;
  final bool isLastPage;

  GetNotificationsSuccessState(this.notificationsDataModel, this.isLastPage);
}

final class GetNotificationsErrorState extends NotificationState {
  final String message;

  GetNotificationsErrorState(this.message);
}

final class GetNotificationsPaginationLoadingState extends NotificationState {}