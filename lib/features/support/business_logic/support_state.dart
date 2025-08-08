part of 'support_cubit.dart';

@immutable
sealed class SupportState {}

final class SupportInitial extends SupportState {}

/// Change Tab State
final class ChangeTabState extends SupportState {}

/// Get All Support Data States
final class GetAllSupportDataLoadingState extends SupportState {}

final class GetAllSupportDataSuccessState extends SupportState {
  final List<SupportDModel> supportDataModel;
  final bool isLastPage;
  GetAllSupportDataSuccessState(this.supportDataModel, this.isLastPage);
}

final class GetAllSupportDataErrorState extends SupportState {
  final String error;
  GetAllSupportDataErrorState(this.error);
}

final class GetAllSupportDataPaginationLoadingState extends SupportState {}

/// Make Support Ticket State
final class MakeSupportTicketLoadingState extends SupportState {}

final class MakeSupportTicketSuccessState extends SupportState {
  final SupportResponseModel supportResponseModel;
  MakeSupportTicketSuccessState(this.supportResponseModel);
}

final class MakeSupportTicketErrorState extends SupportState {
  final String error;
  MakeSupportTicketErrorState(this.error);
}

/// Get Ticket Details State
final class GetTicketDetailsLoadingState extends SupportState {}

final class GetTicketDetailsSuccessState extends SupportState {
  final GetTicketDetailsDataModel getTicketDetailsDataModel;
  GetTicketDetailsSuccessState(this.getTicketDetailsDataModel);
}

final class GetTicketDetailsErrorState extends SupportState {
  final String error;
  GetTicketDetailsErrorState(this.error);
}

/// Send Message State
final class SendMessageLoadingState extends SupportState {}

final class SendMessageSuccessState extends SupportState {}

final class SendMessageErrorState extends SupportState {
  final String error;
  SendMessageErrorState(this.error);
}

final class SupportImageSelected extends SupportState {}

/// Complete Ticket State
final class CompleteTicketLoadingState extends SupportState {}

final class CompleteTicketSuccessState extends SupportState {}

final class CompleteTicketErrorState extends SupportState {
  final String error;
  CompleteTicketErrorState(this.error);
}