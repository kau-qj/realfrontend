import 'package:cookie_jar/cookie_jar.dart';

void saveTokenToCookie(String token) {
  final cookieJar = CookieJar();
  final uri = Uri.parse('https://kauqj.shop');
  final cookie = Cookie('jwt_token', token);
  cookie.domain = uri.host;
  cookie.path = uri.path;
  cookie.httpOnly = true;
  cookieJar.saveFromResponse(uri, [cookie]);
  
  print('토큰이 쿠키에 저장되었습니다.');
}