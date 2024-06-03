abstract class Urls {
  static const String _baseUrl = 'https://kumele-backend.vercel.app/api';
  static String signUpUrl = '$_baseUrl/auth/signup';
  static String signInUrl = '$_baseUrl/auth/login';
  static String getUserDataUrl = '$_baseUrl/auth/getUserData';

  static String generatePassKeyUrl =
      '$_baseUrl/auth/passkey/generate/challenge';
  static String verifyPassKeyLoginUrl =
      '$_baseUrl/auth/passkey/verify/challenge';
  static String verifyPassKeySignupUrl =
      '$_baseUrl/auth/passkey/verify/signup/challenge';

  static String getAllBlogsUrl = '$_baseUrl/blog/getall';
  static String blogByIdUrl = '$_baseUrl/blog/';
  static String getAllEventsUrl = '$_baseUrl/event/getall';
  static String eventByIdUrl = '$_baseUrl/event/';
  static String eventUpdateUrl = '$_baseUrl/event/update/';
  static String eventDeleteUrl = '$_baseUrl/event/delete/';
  static String eventCreateUrl = '$_baseUrl/event/create';
  static String eventUploadImageUrl = '$_baseUrl/event/upload';
  static String allEventCategoryUrl = '$_baseUrl/event-category/getall';
  static String eventCategoryById = '$_baseUrl/event-category/';
  static String eventCategoryUpdate = '$_baseUrl/event-category/update/';
  static String chatByEventId = '$_baseUrl/chat/getall/';
  static String createChat = '$_baseUrl/chat/create';
  static String allMessagesByChatId = '$_baseUrl/chat/';
  static String createMessage = '$_baseUrl/chat/message/create';
  static String updateMessage = '$_baseUrl/chat/message/update/';
}
