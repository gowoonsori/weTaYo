const String _urlPrefix =
    'http://openapi.gbis.go.kr/ws/rest/busrouteservice/info?serviceKey=';
const String _serviceKey = '1234567890';
const String _idPrefix = '&routeId=';
const String _defaultid = '123456789';

const String STATUS_OK = '0';

String buildUrl(String id) {
  StringBuffer sb = StringBuffer();
  sb.write(_urlPrefix);
  sb.write(_serviceKey);
  sb.write(_idPrefix);
  sb.write('200000085');

  return sb.toString();
}