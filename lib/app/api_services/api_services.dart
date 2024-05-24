abstract class ApiServices{
static const String _baseUrl = 'https://kumele-backend.vercel.app/api';
static String signUpUrl = '$_baseUrl/auth/signup';
static String signInUrl = '$_baseUrl/auth/login';
static String getUserDataUrl = '$_baseUrl/auth/getUserData';
static String generatePassKeyUrl = '$_baseUrl/auth/passkey/generate/challenge';

}