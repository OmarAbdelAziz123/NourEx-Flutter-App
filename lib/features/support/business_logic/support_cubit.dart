import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:nourex/core/utils/easy_loading.dart';
import 'package:nourex/features/support/data/models/get_all_support_ticket_data_model.dart';
import 'package:nourex/features/support/data/models/get_ticket_details_data_model.dart';
import 'package:nourex/features/support/data/models/make_support_response_data_model.dart';
import 'package:nourex/features/support/data/repos/repos.dart';

part 'support_state.dart';

class SupportCubit extends Cubit<SupportState> {
  SupportCubit(this.supportRepos) : super(SupportInitial()) {
    _initScrollListener();

    /// ✅ Add scroll listener on cubit creation
    getInitialSupportData(status: 'Completed');

    /// ✅ Load initial data when cubit is created
  }

  int selectedTabIndex = 0;

  final SupportRepos supportRepos;

  int currentPage = 1;
  int totalPages = 1;
  final ScrollController scrollController = ScrollController();
  final refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  XFile? selectedImage;
  // List<SupportTicketModel> supportTickets = [];
  List<SupportDModel> supports = [];
  List<TicketDetailModel> ticketDetails = [];

  // AllSupportDataModel? allSupportDataModel;
  GetAllSupportTicketDataModel? getAllSupportTicketDataModel;
  bool isFetching = false;

  final formKey = GlobalKey<FormState>();
  TextEditingController messageController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  SupportResponseModel? supportResponseModel;
  GetTicketDetailsDataModel? getTicketDetailsDataModel;

  void setSelectedImage(XFile? image) {
    selectedImage = image;
    emit(SupportImageSelected());
  }

  /// Make Support Ticket
  Future<void> makeSupportTicket({
    required String subject,
  }) async {
    showLoading();
    emit(MakeSupportTicketLoadingState());
    final result = await supportRepos.makeSupportTicket(
      subject: subject,
      content: messageController.text,
    );
    result.when(
      success: (data) {
        supportResponseModel = data;
        hideLoading();
        emit(MakeSupportTicketSuccessState(supportResponseModel!));
      },
      failure: (error) {
        hideLoading();
        emit(MakeSupportTicketErrorState(error.message));
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
        getMoreSupportData(status: _getStatusForTab(selectedTabIndex));
      }
    });
  }

  /// Helper method to map tab index to status string
  String _getStatusForTab(int index) {
    switch (index) {
      case 0:
        return 'Completed';
      case 1:
        return 'In Progress';
      case 2:
        return 'Rejected';
      default:
        return 'Completed';
    }
  }

  /// Get Initial Support Data
  Future<void> getInitialSupportData({
    required String status,
  }) async {
    emit(GetAllSupportDataLoadingState());
    currentPage = 1;
    supports.clear();
    isFetching = false; // ✅ Reset fetching state

    final result = await supportRepos.getAllSupportData(
      page: currentPage,
      status: status,
    );

    result.when(
      success: (data) {
        getAllSupportTicketDataModel = data;
        supports = data.result ?? [];
        totalPages = data.pagination?.pages ?? 1;
        emit(
            GetAllSupportDataSuccessState(supports, currentPage >= totalPages));
      },
      failure: (error) {
        emit(GetAllSupportDataErrorState(error.message));
      },
    );
  }

  /// Get More Support Data
  Future<void> getMoreSupportData({required String status}) async {
    if (isFetching || currentPage >= totalPages) return;

    isFetching = true;
    emit(GetAllSupportDataPaginationLoadingState());
    currentPage++;

    final result = await supportRepos.getAllSupportData(
      page: currentPage,
      status: status,
    );

    result.when(
      success: (data) {
        getAllSupportTicketDataModel = data;
        supports.addAll(data.result ?? []);
        emit(
            GetAllSupportDataSuccessState(supports, currentPage >= totalPages));
      },
      failure: (error) {
        currentPage--; // ✅ Revert page increment on error
        emit(GetAllSupportDataErrorState(error.message));
      },
    );

    isFetching = false;
  }

  /// Get Ticket Details
  Future<void> getTicketDetails({required String id}) async {
    emit(GetTicketDetailsLoadingState());
    final result = await supportRepos.getTicketDetails(id: id);
    result.when(
      success: (data) {
        getTicketDetailsDataModel = data;
        ticketDetails = data.data ?? [];
        emit(GetTicketDetailsSuccessState(data));
      },
      failure: (error) {
        emit(GetTicketDetailsErrorState(error.message));
      },
    );
  }

  // /// Send Message
  // Future<void> sendMessage({
  //   required String id,
  //   required String messageType,
  //   String? content,
  //   XFile? supportImages,
  // }) async {
  //   showLoading();
  //   emit(SendMessageLoadingState());
  //
  //   XFile? compressedImage = supportImages;
  //   if (supportImages != null) {
  //     // Compress the image
  //     final tempDir = await Directory.systemTemp.createTemp();
  //     final compressedFilePath = '${tempDir.path}/${supportImages.name}';
  //     final compressedFile = await FlutterImageCompress.compressAndGetFile(
  //       supportImages.path,
  //       compressedFilePath,
  //       quality: 80, // Adjust quality (0-100, lower means smaller size)
  //       minWidth: 1024, // Maximum width
  //       minHeight: 1024, // Maximum height
  //     );
  //     if (compressedFile != null) {
  //       compressedImage = XFile(compressedFile.path);
  //     } else {
  //       // Fallback to original image if compression fails
  //       compressedImage = supportImages;
  //     }
  //   }
  //
  //   final result = await supportRepos.sendMessage(
  //     id: id,
  //     content: content,
  //     messageType: messageType,
  //     supportImages: compressedImage,
  //   );
  //   result.when(
  //     success: (data) {
  //       contentController.clear();
  //       setSelectedImage(null);
  //       hideLoading();
  //       getTicketDetails(id: id); // Refresh ticket details
  //       emit(SendMessageSuccessState());
  //     },
  //     failure: (error) {
  //       hideLoading();
  //       emit(SendMessageErrorState(error.message));
  //     },
  //   );
  // }
  /// Send Message
  Future<void> sendMessage({
    required String id,
    required String messageType,
    String? content,
    XFile? supportImages,
  }) async {
    showLoading();
    emit(SendMessageLoadingState());

    XFile? compressedImage = supportImages;
    if (supportImages != null) {
      // Ensure the output file name ends with .jpg
      final tempDir = await Directory.systemTemp.createTemp();
      final fileName = supportImages.name.split('.').first; // Get file name without extension
      final compressedFilePath = '${tempDir.path}/$fileName.jpg'; // Force .jpg extension
      final compressedFile = await FlutterImageCompress.compressAndGetFile(
        supportImages.path,
        compressedFilePath,
        quality: 80, // Adjust quality (0-100, lower means smaller size)
        minWidth: 1024, // Maximum width
        minHeight: 1024, // Maximum height
        format: CompressFormat.jpeg, // Explicitly set JPEG format
      );
      if (compressedFile != null) {
        compressedImage = XFile(compressedFile.path);
      } else {
        // Fallback to original image if compression fails
        compressedImage = supportImages;
      }
    }

    final result = await supportRepos.sendMessage(
      id: id,
      content: content,
      messageType: messageType,
      supportImages: compressedImage,
    );
    result.when(
      success: (data) {
        contentController.clear();
        setSelectedImage(null);
        hideLoading();
        getTicketDetails(id: id); // Refresh ticket details
        emit(SendMessageSuccessState());
      },
      failure: (error) {
        hideLoading();
        emit(SendMessageErrorState(error.message));
      },
    );
  }

  /// Complete Ticket
  Future<void> completeTicket({required String id}) async {
    showLoading();
    emit(CompleteTicketLoadingState());
    final result = await supportRepos.completeTicket(id: id);
    result.when(
      success: (data) {
        hideLoading();
        emit(CompleteTicketSuccessState());
      },
      failure: (error) {
        hideLoading();
        emit(CompleteTicketErrorState(error.message));
      },
    );
  }

  /// Change Tab
  void changeTab(int index) {
    if (index == selectedTabIndex) return; // Prevent re-fetch if same tab

    selectedTabIndex = index;
    emit(ChangeTabState());
    getInitialSupportData(status: _getStatusForTab(index));
  }

  @override
  Future<void> close() {
    contentController.dispose();
    scrollController.dispose();
    return super.close();
  }
}
