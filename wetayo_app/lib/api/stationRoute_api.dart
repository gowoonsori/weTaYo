const String _urlPrefix =
    'http://openapi.gbis.go.kr/ws/rest/busstationservice/route?serviceKey=';
const String _serviceKey =
    'Q2kheZxOB4Se5Iqm4ZVPAaA6Vaf9%2BdfUAIvymf%2BBWd3VoYvRmkjMQrQmE9LrIyizUYlkkW65HDZTmswAPgDDVA%3D%3D';
const String _idPrefix = '&stationId=';
const String _defaultid = '123456789';

const String STATUS_OK = '0';

String buildUrl(String id) {
  StringBuffer sb = StringBuffer();
  sb.write(_urlPrefix);
  sb.write(_serviceKey);
  sb.write(_idPrefix);
  sb.write('200000078');

  return sb.toString();
}
