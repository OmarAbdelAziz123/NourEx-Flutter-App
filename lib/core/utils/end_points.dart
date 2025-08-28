class EndPoints {
  /// BaseUrl
  static const String baseUrl = 'https://noorex.vercel.app/';

  /// User Application EndPoints
  /// Auth
  static const String login = 'auth/login';
  static const String register = 'auth/register';
  static const String emailOTP = 'auth/emailOTP';
  static String confirmPhoneEmailOTP(String email) => 'auth/confirmPhoneEmailOTP/$email';
  static String setPassword(String email) => 'auth/setPassword/$email';

  /// Notifications
  static const String getAllNotifications = 'notification/getAllNotifications';

  /// Settings
  static const String getProfile = 'user/userProfile';
  static const String getAllSupportData = 'support/getMyProblems';
  static const String makeSupportTicket = 'support/sendSupportMessage';
  static const String getTicketDetails = 'support/getSupportChat';
  static const String sendMessage = 'support/sendSupportReply';
  static const String completeTicket = 'support/complete';
  static const String updateProfile = 'user/updateProfile';
  static const String allMyReviews = 'review/myReviews';
  static String deleteMyReview(String productId, String deleteMyReview) => 'review/deleteReview/$productId/$deleteMyReview';
  static String updateMyReview(String productId, String reviewId) => 'review/updateReview/$productId/$reviewId';
  static String makeReportReview(String reviewId) => 'review/reportReview/$reviewId';
  static const String getAllMyReturnedOrders = 'return/getMyReturnRequests';
  static const String logout = 'auth/logOut';

  /// Home
  /// Products
  static const String getAllBanners = 'banner/getAllBanners';
  static const String products = 'product/getAllProducts';
  static const String bestOffers = 'product/bestOffer';
  static const String bestSeller = 'product/mostOrdered';
  static const String search = 'product/searchProducts';
  static const String productById = 'product/getProductById';
  static const String productReviews = 'review/getReviews/';
  static const String productsByCategory = 'product/getProductsCategory';
  static String createReview(String productId) => 'review/createReview/$productId';

  /// Category
  static const String categories = 'category/getAllCategories';

  /// Cart
  static const String addProductToCart = 'Cart/addToCart';
  static const String removeProductFromCart = 'Cart/clearCartItem';
  static const String removeAllProductsFromCart = 'Cart/clearCart';
  static const String getCart = 'Cart';
  static const String updateCart = 'Cart/updateCartItemQuantity';
  static const String applyCoupon = 'coupon/applyCoupon';
  static const String getMainAddress = 'user/mainAddress';
  static const String makeOrder = 'order/createOrder';

  /// Addresses
  static const String addAddress = 'user/addAddress';
  static const String updateAddress = 'user/updateAddress';
  static const String deleteAddress = 'user/deleteAddress';
  static const String getAllAddresses = 'user/getAllAddress';

  /// Wallet
  static const String getWalletHistory = 'wallet/walletHistory';
  static const String makePreviewRedeemPoints = 'wallet/preview';
  static const String redeemPoints = 'wallet/redeem';

  /// My Orders
  static const String getAllMyOrders = 'order/getMyOrders';
  static String makeReturnOrder(String orderId) => 'return/returnProduct/$orderId';
  static String makeCancelOrder(String orderId) => 'order/cancelOrder/$orderId';
  static String makeDeliveryOrder(String orderId) => 'order/deliveredOrder/$orderId';
}
