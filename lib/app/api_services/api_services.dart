abstract class ApiServices{
static const String _baseUrl = 'https://kumele-backend.vercel.app/api';
static String signUpUrl = '$_baseUrl/auth/signup';
static String signInUrl = '$_baseUrl/auth/login';
static String getUserDataUrl = '$_baseUrl/auth/getUserData';
static String generatePassKeyUrl = '$_baseUrl/auth/passkey/generate/challenge';
static String getAllBlogsUrl = '$_baseUrl/blog/getall';
static String blogByIdUrl = '$_baseUrl/blog/';
static String getAllEventsUrl = '$_baseUrl/event/getall';
static String eventByIdUrl = '$_baseUrl/event/';
static String eventUpdateUrl = '$_baseUrl/event/update/';
static String eventDeleteUrl = '$_baseUrl/event/delete/';
static String eventUploadImageUrl = '$_baseUrl/event/upload';

}