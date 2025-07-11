import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class FullScreenImageViewerContainerWidget extends StatelessWidget {
  final XFile image;

  const FullScreenImageViewerContainerWidget({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          /// Full screen image
          Center(
            child: InteractiveViewer(
              child: Image.file(
                File(image.path),
                fit: BoxFit.contain,
              ),
            ),
          ),

          /// Close button
          Positioned(
            top: 40.h,
            right: 20.w,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.close, color: Colors.white, size: 24.w),
              ),
            ),
          ),
        ],
      ),
    );
  }
}