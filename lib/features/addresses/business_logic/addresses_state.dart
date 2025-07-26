part of 'addresses_cubit.dart';

@immutable
sealed class AddressesState {}

final class AddressesInitial extends AddressesState {}

/// Add Address States
class AddAddressLoadingState extends AddressesState {}

class AddAddressSuccessState extends AddressesState {}

class AddAddressErrorState extends AddressesState {
  final String error;

  AddAddressErrorState(this.error);
}

/// Update Address States
class UpdateAddressLoadingState extends AddressesState {}

class UpdateAddressSuccessState extends AddressesState {}

class UpdateAddressErrorState extends AddressesState {
  final String error;

  UpdateAddressErrorState(this.error);
}

/// Delete Address States
class DeleteAddressLoadingState extends AddressesState {}

class DeleteAddressSuccessState extends AddressesState {}

class DeleteAddressErrorState extends AddressesState {
  final String error;

  DeleteAddressErrorState(this.error);
}


/// Get All Addresses States
class GetAllAddressesLoadingState extends AddressesState {}

class GetAllAddressesSuccessState extends AddressesState {
  final List<AddressModel> addresses;
  final bool isLastPage;

  GetAllAddressesSuccessState(this.addresses, this.isLastPage);
}

class GetAllAddressesErrorState extends AddressesState {
  final String error;

  GetAllAddressesErrorState(this.error);
}

final class AddressesPaginationLoading extends AddressesState {}
