class EndPoints {
  /// BaseUrl
  static const String baseUrl = 'https://ecommerce.backend.tanfeethi.com.sa/';

  /// User Application EndPoints
  /// Auth
  static const String login = 'api/user/auth/login';
  static const String register = 'api/user/auth/register';
  static const String logout = 'api/user/auth/logout';

  /// Home
  static const String showAllBanners = 'api/frontend/sliders';
  static const String searchforproduct = 'api/frontend/products/filter';
  static const String getVariationFilter =
      'api/frontend/products/filter/attributes';
  static const String getBestSeller = 'api/frontend/products/bestSeller';
  static const String getBestOffers = 'api/frontend/products/bestOffers';
  static const String getDeliveredOrders = 'api/frontend/orders/delivered';
  static const String getCanceledOrders = 'api/frontend/orders/canceled';
  static const String getProgressOrders = 'api/frontend/orders/progress';
  static String showProductDetails(int productId) =>
      'api/frontend/products/show/$productId';
  static String getProductReviews(int productId) =>
      'api/frontend/rates/getProductRates/$productId';
  static const String makeRateToProduct = 'api/frontend/rates/rateProduct';

  /// Category
  static const String getAllCategories = 'api/frontend/categories/main';
  static String getProductsByCategory(int brandId) =>
      'api/frontend/categories/fetchProducts/$brandId';
  static String getChildrenCategories(int mainCategoryId) =>
      'api/frontend/categories/children/$mainCategoryId';

  /// Cart
  static const String addToCart = 'api/frontend/cart/product/add';
  static const String applyCoupon = 'api/frontend/coupon/apply';
  static const String removeCoupon = 'api/frontend/coupon/remove';
  static const String removeFromCart = 'api/frontend/cart/product/delete';
  static const String plusIncrementCart =
      'api/frontend/cart/product/plusQuantity';
  static const String minusIncrementCart =
      'api/frontend/cart/product/minusQuantity';
  static const String getCartDetails = 'api/frontend/cart/invoice';
  static const String getCart = 'api/frontend/cart/details';
  static const String removeAllCartItems = 'api/frontend/cart/clearCart';
  static const String addOrder = 'api/frontend/orders/make';

  /// Brands
  static const String getAllBrands = 'api/frontend/brands/homepage';
  static const String makeRateBrand = 'api/frontend/rates/rateBrand';
  static String getBrandsByCategory(int categoryId) =>
      'api/frontend/categories/fetchBrands/$categoryId';
  static String showBrandsDetails(int brandId) =>
      'api/frontend/brands/$brandId';

  /// Profile
  static const String getProfileDetails = 'api/user/profile/details';
  static const String updateProfile = 'api/user/profile/updateData';
  static const String updatePassword = 'api/user/profile/updatePassword';
  static const String getAllAddresses = 'api/frontend/addresses';
  static const String addAddress = 'api/frontend/addresses/add';
  static String editAddress(int addressId) =>
      'api/frontend/addresses/add/$addressId';
  static String deleteAddress(int addressId) =>
      'api/frontend/addresses/delete/$addressId';
  static String getSimilarProducts(int productId) =>
      'api/frontend/products/getProductSimilarProductsPaginated/$productId';
  static String getProductsByBrands(int brandId) =>
      'api/frontend/brands/fetchProducts/$brandId';
  static const String addToFavorite =
      'api/frontend/products/favourites/toggleFavourite';
  static const String getFavorite = 'api/frontend/products/favourites';

  static String showOrderDetails(int addressId) =>
      'api/frontend/orders/details/$addressId';

  static const String createTicket = 'api/frontend/userTicket/create';
  static const String getAllTickets = 'api/frontend/userTicket/list';
  static const String sendMessage = 'api/frontend/userTicket/createMessage';
  static String getSpecificTicket(int ticketId) =>
      'api/frontend/userTicket/show/$ticketId';
  static String getSettings(String title) => 'api/frontend/staticPages/$title';
}
