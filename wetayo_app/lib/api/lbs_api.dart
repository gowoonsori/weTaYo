const String _urlPrefix =
    'http://openapi.gbis.go.kr/ws/rest/busstationservice/searcharound?serviceKey=';
const String _serviceKey =
    'Q2kheZxOB4Se5Iqm4ZVPAaA6Vaf9%2BdfUAIvymf%2BBWd3VoYvRmkjMQrQmE9LrIyizUYlkkW65HDZTmswAPgDDVA%3D%3D';
const String _xPrefix = '&x=';
const String _defaultX = '126.7309';
const String _yPrefix = '&y=';
const String _defaultY = '37.3412';

const int STATUS_OK = 00;

String buildUrl(String x, String y) {
  StringBuffer sb = StringBuffer();
  sb.write(_urlPrefix);
  sb.write(_serviceKey);
  sb.write(_xPrefix);
  sb.write(x);
  sb.write(_yPrefix);
  sb.write(y);
  return sb.toString();
}
