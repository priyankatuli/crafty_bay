class Urls{
  static const String _baseUrl = 'https://ecommerce-api.codesilicon.com/api';
  static const String sliderListUrl = '$_baseUrl/ListProductSlider';
  static const String categoryListUrl = '$_baseUrl/CategoryList';

  static String productListByRemarksUrl(String remark)
  => '$_baseUrl/ListProductByRemark/$remark';
  static String listProductByCategory(int categoryId)
       => '$_baseUrl/ListProductByCategory/$categoryId';
  static String productDetailsById (int productId)
              => '$_baseUrl/ProductDetailsById/$productId';

  static String userLogin(String email) => '$_baseUrl/UserLogin/$email';
  static String verifyLogin(String email,String otp) => '$_baseUrl/VerifyLogin/$email/$otp';
  static const String readProfile = '$_baseUrl/ReadProfile';

  static const String createCartList = '$_baseUrl/CreateCartList';
  static const String getCartList = '$_baseUrl/CartList';
  static String deleteCartList(int cartId) => '$_baseUrl/DeleteCartList/$cartId';


  static const String createInvoice = '$_baseUrl/InvoiceCreate';
  static String reviewList(String productId) => '$_baseUrl/ListReviewByProduct/$productId';
  static const String getWishList ='$_baseUrl/ProductWishList';
  static String createWishList(int productId) => '$_baseUrl/CreateWishList/$productId';
  static String deleteWishList(String productId) => '$_baseUrl/RemoveWishList/$productId';


}