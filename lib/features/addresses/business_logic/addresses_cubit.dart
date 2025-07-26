import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:meta/meta.dart';
import 'package:nourex/core/utils/easy_loading.dart';
import 'package:nourex/features/addresses/data/models/addresses_data_model.dart';
import 'package:nourex/features/addresses/data/repos/repos.dart';

part 'addresses_state.dart';

class AddressesCubit extends Cubit<AddressesState> {
  AddressesCubit(this.addressesRepos) : super(AddressesInitial()) {
    _initScrollListener();
    /// ✅ Add scroll listener on cubit creation
    getInitialAddresses();
    /// ✅ Load initial data when cubit is created
  }

  final AddressesRepos addressesRepos;

  int currentPage = 1;
  int totalPages = 1;
  final ScrollController scrollController = ScrollController();
  final refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  List<AddressModel> allAddresses = [];
  AddressModel? addressModel;
  bool isFetching = false;

  final formKey = GlobalKey<FormState>();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController zoneController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  /// Add this in your cubit class
  bool isMain = false;

  /// Optional: toggle method
  // void toggleIsMain(bool value) {
  //   isMain = value ?? false;
  //   emit(AddressesInitial());
  //
  //   /// or a new specific state if needed
  // }
  void toggleIsMain() {
    isMain = !isMain;
    emit(AddressesInitial());
  }

  /// Add Address
  Future<void> addAddress() async {
    showLoading();
    emit(AddAddressLoadingState());
    final result = await addressesRepos.addAddress(
      name: fullNameController.text,
      phoneNo: '+963${phoneController.text}',
      city: cityController.text,
      zone: zoneController.text,
      street: streetController.text,
      type: isMain ? 'Main' : 'Sub',
      notes: notesController.text,
    );
    result.when(
      success: (data) {
        hideLoading();
        emit(AddAddressSuccessState());
      },
      failure: (error) {
        hideLoading();
        print('Error in addAddress: ${error.toString()}');
        emit(AddAddressErrorState(error.message.toString()));
      },
    );
  }

  /// Update Address
  Future<void> updateAddress({required String id}) async {
    final name = fullNameController.text.trim();
    final phoneNo = phoneController.text.trim();
    final city = cityController.text.trim();
    final zone = zoneController.text.trim();
    final street = streetController.text.trim();
    final type = isMain ? "Main" : "Sub"; // if you're using checkbox
    final notes = notesController.text.trim();

    final Map<String, dynamic> data = {
      if (name.isNotEmpty) "name": name,
      if (phoneNo.isNotEmpty) "phoneNo": phoneNo,
      if (city.isNotEmpty) "city": city,
      if (zone.isNotEmpty) "zone": zone,
      if (street.isNotEmpty) "street": street,
      if (type.isNotEmpty) "type": type,
      if (notes.isNotEmpty) "notes": notes,
    };

    showLoading();
    emit(UpdateAddressLoadingState());
    final result = await addressesRepos.updateAddress(id: id, data: data);
    result.when(
      success: (data) {
        hideLoading();
        emit(UpdateAddressSuccessState());
      },
      failure: (error) {
        hideLoading();
        print('Error in updateAddress: ${error.toString()}');
        emit(UpdateAddressErrorState(error.message.toString()));
      },
    );
  }

  /// Delete Address
  Future<void> deleteAddress({required String id}) async {
    showLoading();
    emit(DeleteAddressLoadingState());
    final result = await addressesRepos.deleteAddress(id: id);
    result.when(
      success: (data) {
        hideLoading();
        emit(DeleteAddressSuccessState());
      },
      failure: (error) {
        hideLoading();
        print('Error in deleteAddress: ${error.toString()}');
        emit(DeleteAddressErrorState(error.message.toString()));
      },
    );
  }

  /// Init Scroll Listener
  void _initScrollListener() {
    scrollController.addListener(() {
      final position = scrollController.position;

      /// ✅ Only trigger when user scrolls down
      if (position.userScrollDirection == ScrollDirection.reverse &&
          position.pixels >= position.maxScrollExtent - 100 &&
          !isFetching &&
          currentPage < totalPages) {
        getMoreAddresses();
      }
    });
  }

  /// Get Initial Addresses
  Future<void> getInitialAddresses() async {
    emit(GetAllAddressesLoadingState());
    currentPage = 1;
    allAddresses.clear();
    isFetching = false; // ✅ Reset fetching state

    final result = await addressesRepos.getAllAddresses(page: currentPage);

    result.when(
      success: (data) {
        allAddresses = data.result ?? [];
        totalPages = data.pagination?.pages ?? 1;
        emit(
          GetAllAddressesSuccessState(allAddresses, currentPage >= totalPages),
        );
      },
      failure: (error) {
        emit(GetAllAddressesErrorState(error.message));
      },
    );
  }

  /// Fetch More for Pagination
  Future<void> getMoreAddresses() async {
    if (isFetching || currentPage >= totalPages) return;

    isFetching = true;
    emit(AddressesPaginationLoading());
    currentPage++;

    final result = await addressesRepos.getAllAddresses(page: currentPage);

    result.when(
      success: (data) {
        allAddresses.addAll(data.result ?? []);
        emit(
          GetAllAddressesSuccessState(allAddresses, currentPage >= totalPages),
        );
      },
      failure: (error) {
        currentPage--; // ✅ Revert page increment on error
        emit(GetAllAddressesErrorState(error.message));
      },
    );

    isFetching = false;
  }

  @override
  Future<void> close() {
    scrollController.dispose(); // ✅ Clean up scroll controller
    fullNameController.dispose();
    phoneController.dispose();
    zoneController.dispose();
    cityController.dispose();
    streetController.dispose();
    notesController.dispose();
    return super.close();
  }
}
