// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:nourex/core/cache_helper/cache_helper.dart';
// import 'package:nourex/core/cache_helper/cache_keys.dart';
// import 'package:nourex/core/extensions/navigation_extension.dart';
// import 'package:nourex/core/networks_helper/errors/exceptions.dart';
// import 'package:nourex/core/services/di/di.dart';
// import 'package:nourex/core/themes/text_colors.dart';
// import 'package:nourex/core/widgets/appbar/main_app_bar_2_widget.dart';
// import 'package:nourex/core/widgets/bottom_nav_bar/custom_bottom_nav_bar_have_buttons_widget.dart';
// import 'package:nourex/core/widgets/text_field/custom_text_form_field_widget.dart';
// import 'package:nourex/features/products/business_logic/products_cubit.dart';
// import 'package:nourex/features/profile/business_logic/profile_cubit.dart';
// import 'package:nourex/features/support/business_logic/support_cubit.dart';
// import 'package:nourex/features/support/data/models/get_ticket_details_data_model.dart';
//
// class SupportDetailsScreen extends StatelessWidget {
//   const SupportDetailsScreen({super.key, required this.data});
//
//   final Map<String, dynamic> data;
//
//   @override
//   Widget build(BuildContext context) {
//     final ImagePicker picker = ImagePicker();
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(74.h),
//         child: MainAppBar2Widget(
//           title: data['ticketSeq'] ?? '',
//           isSubScreen: true,
//           onTapBack: () {
//             context.pop();
//           },
//           onTapNotification: () {},
//         ),
//       ),
//       body: BlocConsumer<SupportCubit, SupportState>(
//         listener: (context, state) {
//           if (state is SendMessageSuccessState) {
//             context.read<SupportCubit>().getTicketDetails(id: data['ticketId']);
//           }
//         },
//         builder: (context, state) {
//           final cubit = context.read<SupportCubit>();
//
//           return Padding(
//             padding: EdgeInsets.only(
//               left: 18.w,
//               right: 18.w,
//               bottom: 34.h,
//             ),
//             child: Column(
//               children: [
//                 18.verticalSpace,
//                 Expanded(
//                   child: ListView.builder(
//                     reverse: true,
//                     itemCount: cubit.ticketDetails.length ?? 0,
//                     itemBuilder: (context, index) {
//                       final ticket = cubit.ticketDetails[index];
//                       return Padding(
//                         padding: EdgeInsets.only(bottom: 16.h),
//                         child: _buildMessageBasedOnType(ticket),
//                       );
//                     },
//                   ),
//                 ),
//                 Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     if (data['status'] == 'In Progress')
//                       CustomBottomNavBarHaveButtonsWidget(
//                         haveText: false,
//                         buttonTitle: 'solvedProblem'.tr(),
//                         onPressed: () {},
//                       ),
//                     Row(
//                       spacing: 12.w,
//                       children: [
//                         Expanded(
//                           child: CustomTextFormFieldWidget(
//                             hintText: 'theMessage'.tr(),
//                             hintStyle: Styles.contentEmphasis,
//                             controller: cubit.contentController,
//                             suffixIcon: IconButton(
//                               onPressed: () async {
//                                 final XFile? image = await picker.pickImage(
//                                   source: ImageSource.gallery,
//                                 );
//                                 if (image != null) {
//                                   cubit.setSelectedImage(image);
//                                 }
//                               },
//                               icon: SvgPicture.asset(
//                                 'assets/svgs/gallery_icon.svg',
//                               ),
//                             ),
//                           ),
//                         ),
//                         IconButton(
//                           onPressed: () {
//                             final content = cubit.contentController.text.trim();
//                             final hasText = content.isNotEmpty;
//                             final hasImage = cubit.selectedImage != null;
//
//                             if (!hasText && !hasImage) {
//                               ToastManager.showCustomToast(
//                                 message: 'Please enter a message or select an image'.tr(),
//                                 backgroundColor: Colors.red,
//                                 icon: Icons.error_outline,
//                                 duration: const Duration(seconds: 3),
//                               );
//                               return;
//                             }
//
//                             String messageType;
//                             if (hasText && hasImage) {
//                               messageType = 'text_and_image';
//                             } else if (hasText) {
//                               messageType = 'text';
//                             } else {
//                               messageType = 'image';
//                             }
//
//                             cubit.sendMessage(
//                               id: data['ticketId'],
//                               messageType: messageType,
//                               content: hasText ? content : null,
//                               supportImages: cubit.selectedImage,
//                             );
//                           },
//                           icon: SvgPicture.asset(
//                             'assets/svgs/send_icon.svg',
//                             fit: BoxFit.scaleDown,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _buildMessageBasedOnType(TicketDetailModel ticket) {
//     final isMine = ticket.isMine ?? false;
//     if (ticket.messageType == 'text') {
//       return _buildTextMessageBubble(
//         message: ticket.content ?? '',
//         isMine: isMine,
//         createdAt: ticket.createdAt ?? '',
//         createdDateTime: ticket.createdDateTime ?? '',
//       );
//     } else if (ticket.messageType == 'image') {
//       return _buildImageMessageBubble(
//         images: ticket.images ?? [],
//         isMine: isMine,
//         createdAt: ticket.createdAt ?? '',
//         createdDateTime: ticket.createdDateTime ?? '',
//       );
//     } else {
//       return _buildTextMessageBubble(
//         message: ticket.content ?? 'Unknown message type',
//         isMine: isMine,
//         createdAt: ticket.createdAt ?? '',
//         createdDateTime: ticket.createdDateTime ?? '',
//       );
//     }
//   }
//
//   Widget _buildTextMessageBubble({
//     required String message,
//     required bool isMine,
//     required String createdAt,
//     required String createdDateTime,
//   }) {
//     return Align(
//       alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
//       child: Row(
//         mainAxisAlignment:
//             isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // if (isMine) ...[
//           //   _buildAvatar(),
//           //   SizedBox(width: 12.w),
//           // ],
//           if (!isMine) ...[
//             Image.asset(
//               'assets/pngs/admin_image.png',
//               width: 40.w,
//               height: 40.w,
//               fit: BoxFit.cover,
//             ),
//             SizedBox(width: 12.w),
//           ],
//           Flexible(
//             child: Container(
//               constraints: BoxConstraints(maxWidth: 0.7.sw),
//               padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
//               decoration: BoxDecoration(
//                 color: isMine ? Colors.blue[100] : const Color(0xFFF5F5F5),
//                 borderRadius: BorderRadius.circular(12.r),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.1),
//                     spreadRadius: 1,
//                     blurRadius: 4,
//                     offset: const Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 crossAxisAlignment:
//                     isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     message,
//                     style: TextStyle(
//                       fontSize: 14.sp,
//                       color: Colors.black87,
//                       height: 1.4,
//                     ),
//                   ),
//                   SizedBox(height: 8.h),
//                   Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Text(
//                         createdAt,
//                         style: TextStyle(
//                           fontSize: 10.sp,
//                           color: Colors.grey[600],
//                           fontStyle: FontStyle.italic,
//                         ),
//                       ),
//                       SizedBox(width: 8.w),
//                       Text(
//                         createdDateTime,
//                         style: TextStyle(
//                           fontSize: 10.sp,
//                           color: Colors.grey[600],
//                           fontStyle: FontStyle.italic,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           if (isMine) ...[
//             SizedBox(width: 12.w),
//             _buildAvatar(),
//           ],
//         ],
//       ),
//     );
//   }
//
//   Widget _buildImageMessageBubble({
//     required List<String> images,
//     required bool isMine,
//     required String createdAt,
//     required String createdDateTime,
//   }) {
//     return Align(
//       alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
//       child: Row(
//         mainAxisAlignment:
//             isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // if (!isMine) ...[
//           //   // _buildAvatar(),
//           //
//           //   SizedBox(width: 12.w),
//           // ],
//           if (!isMine) ...[
//             Image.asset(
//               'assets/pngs/admin_image.png',
//               width: 40.w,
//               height: 40.w,
//               fit: BoxFit.cover,
//             ),
//             SizedBox(width: 12.w),
//           ],
//           Flexible(
//             child: Container(
//               constraints: BoxConstraints(maxWidth: 0.7.sw),
//               padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
//               decoration: BoxDecoration(
//                 color: isMine ? Colors.blue[100] : const Color(0xFFF5F5F5),
//                 borderRadius: BorderRadius.circular(12.r),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.1),
//                     spreadRadius: 1,
//                     blurRadius: 4,
//                     offset: const Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 crossAxisAlignment:
//                     isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//                 children: [
//                   ...images.isNotEmpty
//                       ? images
//                           .map((imageUrl) => Container(
//                                 margin: EdgeInsets.only(bottom: 8.h),
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(8.r),
//                                   child: Image.network(
//                                     imageUrl,
//                                     width: double.infinity,
//                                     fit: BoxFit.cover,
//                                     errorBuilder: (context, error, stackTrace) {
//                                       return Container(
//                                         height: 100.h,
//                                         color: Colors.grey[300],
//                                         child: Icon(
//                                           Icons.broken_image,
//                                           size: 40.sp,
//                                           color: Colors.grey[600],
//                                         ),
//                                       );
//                                     },
//                                     loadingBuilder:
//                                         (context, child, loadingProgress) {
//                                       if (loadingProgress == null) return child;
//                                       return Container(
//                                         height: 100.h,
//                                         color: Colors.grey[200],
//                                         child: Center(
//                                           child: CircularProgressIndicator(
//                                             value: loadingProgress
//                                                         .expectedTotalBytes !=
//                                                     null
//                                                 ? loadingProgress
//                                                         .cumulativeBytesLoaded /
//                                                     loadingProgress
//                                                         .expectedTotalBytes!
//                                                 : null,
//                                           ),
//                                         ),
//                                       );
//                                     },
//                                   ),
//                                 ),
//                               ))
//                           .toList()
//                       : [
//                           Text(
//                             'No images available',
//                             style: TextStyle(
//                               fontSize: 14.sp,
//                               color: Colors.grey[600],
//                               fontStyle: FontStyle.italic,
//                             ),
//                           ),
//                         ],
//                   SizedBox(height: 8.h),
//                   Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Text(
//                         createdAt,
//                         style: TextStyle(
//                           fontSize: 10.sp,
//                           color: Colors.grey[600],
//                           fontStyle: FontStyle.italic,
//                         ),
//                       ),
//                       SizedBox(width: 8.w),
//                       Text(
//                         createdDateTime,
//                         style: TextStyle(
//                           fontSize: 10.sp,
//                           color: Colors.grey[600],
//                           fontStyle: FontStyle.italic,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           if (isMine) ...[
//             SizedBox(width: 12.w),
//             _buildAvatar(),
//           ],
//         ],
//       ),
//     );
//   }
//
//   Widget _buildAvatar() {
//     return Container(
//       width: 40.w,
//       height: 40.w,
//       decoration: BoxDecoration(
//         color: Color(0xFFE0E0E0),
//         borderRadius: BorderRadius.circular(50),
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(50),
//         child: CachedNetworkImage(
//           width: double.infinity,
//           height: double.infinity,
//           fit: BoxFit.cover,
//           imageUrl: CacheHelper.getData(key: CacheKeys.userImage),
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nourex/core/cache_helper/cache_helper.dart';
import 'package:nourex/core/cache_helper/cache_keys.dart';
import 'package:nourex/core/extensions/navigation_extension.dart';
import 'package:nourex/core/networks_helper/errors/exceptions.dart';
import 'package:nourex/core/services/di/di.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/core/widgets/appbar/main_app_bar_2_widget.dart';
import 'package:nourex/core/widgets/bottom_nav_bar/custom_bottom_nav_bar_have_buttons_widget.dart';
import 'package:nourex/core/widgets/text_field/custom_text_form_field_widget.dart';
import 'package:nourex/features/products/business_logic/products_cubit.dart';
import 'package:nourex/features/profile/business_logic/profile_cubit.dart';
import 'package:nourex/features/support/business_logic/support_cubit.dart';
import 'package:nourex/features/support/data/models/get_ticket_details_data_model.dart';

class SupportDetailsScreen extends StatelessWidget {
  const SupportDetailsScreen({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    final ImagePicker picker = ImagePicker();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(74.h),
        child: MainAppBar2Widget(
          title: data['ticketSeq'] ?? '',
          isSubScreen: true,
          onTapBack: () {
            context.pop();
          },
          onTapNotification: () {},
        ),
      ),
      body: BlocConsumer<SupportCubit, SupportState>(
        listener: (context, state) {
          if (state is SendMessageSuccessState) {
            context.read<SupportCubit>().getTicketDetails(id: data['ticketId']);
          }
          if(state is CompleteTicketSuccessState) {
            context.pop();
          }
        },
        builder: (context, state) {
          final cubit = context.read<SupportCubit>();

          return Padding(
            padding: EdgeInsets.only(
              left: 18.w,
              right: 18.w,
              bottom: 34.h,
            ),
            child: Column(
              children: [
                18.verticalSpace,
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    itemCount: cubit.ticketDetails.length,
                    itemBuilder: (context, index) {
                      final ticket = cubit.ticketDetails[index];
                      return Padding(
                        padding: EdgeInsets.only(bottom: 16.h),
                        child: _buildMessageBasedOnType(ticket),
                      );
                    },
                  ),
                ),
                // Image Preview Section
                if (cubit.selectedImage != null) ...[
                  16.verticalSpace,
                  Container(
                    constraints: BoxConstraints(maxHeight: 200.h, maxWidth: 0.7.sw),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: Image.file(
                        File(cubit.selectedImage!.path),
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 100.h,
                            color: Colors.grey[300],
                            child: Icon(
                              Icons.broken_image,
                              size: 40.sp,
                              color: Colors.grey[600],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  12.verticalSpace,
                  Row(
                    spacing: 12.w,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          cubit.sendMessage(
                            id: data['ticketId'],
                            messageType: 'image',
                            content: null,
                            supportImages: cubit.selectedImage,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor700,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                        ),
                        child: Text(
                          'sendImage'.tr(), // Ensure you have this translation key
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          cubit.setSelectedImage(null); // Use cubit method to clear image
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.redColor100,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                        ),
                        child: Text(
                          'clear'.tr(), // Ensure you have this translation key
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  16.verticalSpace,
                ],
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (data['status'] == 'In Progress')
                      CustomBottomNavBarHaveButtonsWidget(
                        haveText: false,
                        buttonTitle: 'solvedProblem'.tr(),
                        onPressed: () {
                          cubit.completeTicket(
                            id: data['ticketId'],
                          );
                        },
                      ),
                    Row(
                      spacing: 12.w,
                      children: [
                        Expanded(
                          child: CustomTextFormFieldWidget(
                            hintText: 'theMessage'.tr(),
                            hintStyle: Styles.contentEmphasis,
                            controller: cubit.contentController,
                            suffixIcon: IconButton(
                              onPressed: () async {
                                final XFile? image = await picker.pickImage(
                                  source: ImageSource.gallery,
                                );
                                if (image != null) {
                                  cubit.setSelectedImage(image);
                                }
                              },
                              icon: SvgPicture.asset(
                                'assets/svgs/gallery_icon.svg',
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            final content = cubit.contentController.text.trim();
                            final hasText = content.isNotEmpty;
                            final hasImage = cubit.selectedImage != null;

                            if (!hasText && !hasImage) {
                              ToastManager.showCustomToast(
                                message: 'Please enter a message or select an image'.tr(),
                                backgroundColor: Colors.red,
                                icon: Icons.error_outline,
                                duration: const Duration(seconds: 3),
                              );
                              return;
                            }

                            String messageType;
                            if (hasText && hasImage) {
                              messageType = 'text_and_image';
                            } else if (hasText) {
                              messageType = 'text';
                            } else {
                              messageType = 'image';
                            }

                            cubit.sendMessage(
                              id: data['ticketId'],
                              messageType: messageType,
                              content: hasText ? content : null,
                              supportImages: cubit.selectedImage,
                            );
                          },
                          icon: SvgPicture.asset(
                            'assets/svgs/send_icon.svg',
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMessageBasedOnType(TicketDetailModel ticket) {
    final isMine = ticket.isMine ?? false;
    if (ticket.messageType == 'text') {
      return _buildTextMessageBubble(
        message: ticket.content ?? '',
        isMine: isMine,
        createdAt: ticket.createdAt ?? '',
        createdDateTime: ticket.createdDateTime ?? '',
      );
    } else if (ticket.messageType == 'image') {
      return _buildImageMessageBubble(
        images: ticket.images ?? [],
        isMine: isMine,
        createdAt: ticket.createdAt ?? '',
        createdDateTime: ticket.createdDateTime ?? '',
      );
    } else {
      return _buildTextMessageBubble(
        message: ticket.content ?? 'Unknown message type',
        isMine: isMine,
        createdAt: ticket.createdAt ?? '',
        createdDateTime: ticket.createdDateTime ?? '',
      );
    }
  }

  Widget _buildTextMessageBubble({
    required String message,
    required bool isMine,
    required String createdAt,
    required String createdDateTime,
  }) {
    return Align(
      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: Row(
        mainAxisAlignment:
        isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMine) ...[
            Image.asset(
              'assets/pngs/admin_image.png',
              width: 40.w,
              height: 40.w,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 12.w),
          ],
          Flexible(
            child: Container(
              constraints: BoxConstraints(maxWidth: 0.7.sw),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: isMine ? Colors.blue[100] : const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment:
                isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    message,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.black87,
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        createdAt,
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: Colors.grey[600],
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        createdDateTime,
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: Colors.grey[600],
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (isMine) ...[
            SizedBox(width: 12.w),
            _buildAvatar(),
          ],
        ],
      ),
    );
  }

  Widget _buildImageMessageBubble({
    required List<String> images,
    required bool isMine,
    required String createdAt,
    required String createdDateTime,
  }) {
    return Align(
      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: Row(
        mainAxisAlignment:
        isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMine) ...[
            Image.asset(
              'assets/pngs/admin_image.png',
              width: 40.w,
              height: 40.w,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 12.w),
          ],
          Flexible(
            child: Container(
              constraints: BoxConstraints(maxWidth: 0.7.sw),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: isMine ? Colors.blue[100] : const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment:
                isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  ...images.isNotEmpty
                      ? images
                      .map((imageUrl) => Container(
                    margin: EdgeInsets.only(bottom: 8.h),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: Image.network(
                        imageUrl,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 100.h,
                            color: Colors.grey[300],
                            child: Icon(
                              Icons.broken_image,
                              size: 40.sp,
                              color: Colors.grey[600],
                            ),
                          );
                        },
                        loadingBuilder:
                            (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            height: 100.h,
                            color: Colors.grey[200],
                            child: Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress
                                    .expectedTotalBytes !=
                                    null
                                    ? loadingProgress
                                    .cumulativeBytesLoaded /
                                    loadingProgress
                                        .expectedTotalBytes!
                                    : null,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ))
                      .toList()
                      : [
                    Text(
                      'No images available',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey[600],
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        createdAt,
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: Colors.grey[600],
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        createdDateTime,
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: Colors.grey[600],
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (isMine) ...[
            SizedBox(width: 12.w),
            _buildAvatar(),
          ],
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: 40.w,
      height: 40.w,
      decoration: BoxDecoration(
        color: Color(0xFFE0E0E0),
        borderRadius: BorderRadius.circular(50),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: CachedNetworkImage(
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
          imageUrl: CacheHelper.getData(key: CacheKeys.userImage),
        ),
      ),
    );
  }
}