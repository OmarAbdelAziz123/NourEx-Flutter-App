part of 'support_cubit.dart';

@immutable
sealed class SupportState {}

final class SupportInitial extends SupportState {}

/// Change Tab State
final class ChangeTabState extends SupportState {}