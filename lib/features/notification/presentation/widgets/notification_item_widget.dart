import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/features/notification/data/models/all_notifications_data_model.dart';

class NotificationItemWidget extends StatelessWidget {
  final NotificationItem notification;
  final VoidCallback onTap;

  const NotificationItemWidget({
    super.key,
    required this.notification,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isRead = notification.isRead ?? false;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isRead ? Colors.white : Colors.blue[50],
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isRead ? Colors.grey[200]! : Colors.blue[100]!,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Notification Icon
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: isRead ? Colors.grey[100] : Colors.blue[100],
                shape: BoxShape.circle,
              ),
              child: Icon(
                _getNotificationIcon(),
                size: 20.sp,
                color: isRead ? Colors.grey[600] : Colors.blue[600],
              ),
            ),
            12.horizontalSpace,
            // Notification Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          notification.message ?? 'إشعار جديد',
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: isRead ? FontWeight.w500 : FontWeight.w600,
                            color: isRead ? Colors.grey[700] : Colors.black87,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (!isRead) ...[
                        4.horizontalSpace,
                        Container(
                          width: 8.w,
                          height: 8.w,
                          decoration: BoxDecoration(
                            color: Colors.blue[600],
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ],
                  ),
                  if (notification.description != null) ...[
                    6.verticalSpace,
                    Text(
                      notification.description!,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.grey[600],
                        height: 1.3,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  8.verticalSpace,
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 14.sp,
                        color: Colors.grey[500],
                      ),
                      4.horizontalSpace,
                      Text(
                        _formatTime(notification.time),
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey[500],
                        ),
                      ),
                      const Spacer(),
                      if (isRead)
                        Icon(
                          Icons.done,
                          size: 16.sp,
                          color: Colors.grey[400],
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getNotificationIcon() {
    // You can customize icons based on notification type
    return Icons.notifications_rounded;
  }

  String _formatTime(String? time) {
    if (time == null) return 'الآن';

    try {
      final dateTime = DateTime.parse(time);
      final now = DateTime.now();
      final difference = now.difference(dateTime);

      if (difference.inDays > 0) {
        return 'منذ ${difference.inDays} ${difference.inDays == 1 ? 'يوم' : 'أيام'}';
      } else if (difference.inHours > 0) {
        return 'منذ ${difference.inHours} ${difference.inHours == 1 ? 'ساعة' : 'ساعات'}';
      } else if (difference.inMinutes > 0) {
        return 'منذ ${difference.inMinutes} ${difference.inMinutes == 1 ? 'دقيقة' : 'دقائق'}';
      } else {
        return 'الآن';
      }
    } catch (e) {
      return time;
    }
  }
}