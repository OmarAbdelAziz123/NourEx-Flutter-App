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

  /// Settings
  static const String getProfile = 'user/userProfile';
  static const String updateProfile = 'user/updateProfile';
  static const String logout = 'auth/logOut';

  /// Home
  /// Products
  static const String products = 'product/getAllProducts';
  static const String productById = 'product/getProductById';
  static const String productsByCategory = 'product/getProductsByCategoryId';

  /// Category
  static const String categories = 'category/getAllCategories';

  /// Cart
  static const String addProductToCart = 'Cart/addToCart';
  static const String removeProductFromCart = 'Cart/clearCartItem';
  static const String removeAllProductsFromCart = 'Cart/clearCart';
  static const String getCart = 'Cart';
  static const String updateCart = 'Cart/updateCartItemQuantity';

  /// Addresses
  static const String addAddress = 'user/addAddress';
  static const String updateAddress = 'user/updateAddress';
  static const String deleteAddress = 'user/deleteAddress';
  static const String getAllAddresses = 'user/getAllAddress';






}
