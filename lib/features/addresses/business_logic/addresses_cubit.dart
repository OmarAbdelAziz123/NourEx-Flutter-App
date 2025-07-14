import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'addresses_state.dart';

class AddressesCubit extends Cubit<AddressesState> {
  AddressesCubit() : super(AddressesInitial());

  final formKey = GlobalKey<FormState>();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController apartmentController = TextEditingController();
  TextEditingController buildingNumberController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  @override
  Future<void> close() {
    fullNameController.dispose();
    phoneController.dispose();
    countryController.dispose();
    cityController.dispose();
    streetController.dispose();
    apartmentController.dispose();
    buildingNumberController.dispose();
    floorController.dispose();
    notesController.dispose();
    return super.close();
  }
}
