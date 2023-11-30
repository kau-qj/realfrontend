import 'package:cookie_jar/cookie_jar.dart';

final CookieJar cookieJar = CookieJar(); // 공통 CookieJar 인스턴스 생성

Future<void> saveTokenToCookie(String token) async {
  final uri = Uri.parse('https://kauqj.shop');
  final cookie = Cookie('access_token', token); // "; HttpOnly" 부분을 제거

  await cookieJar.saveFromResponse(uri, [cookie]);
}
