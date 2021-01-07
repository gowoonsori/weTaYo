# 정류소에서 원하는 버스를 선택하면 실시간 버스 정보가 표시

import requests, xmltodict, json
import pandas as pd
from pandas import DataFrame as df

serviceKey = 'Q2kheZxOB4Se5Iqm4ZVPAaA6Vaf9%2BdfUAIvymf%2BBWd3VoYvRmkjMQrQmE9LrIyizUYlkkW65HDZTmswAPgDDVA%3D%3D'

# 노선 ID
routeId = 224000011

endpoint = 'http://openapi.gbis.go.kr/ws/rest/buslocationservice?serviceKey={}&routeId={}'.format(serviceKey, routeId)
print(endpoint)

content = requests.get(endpoint).content # GET요청
dict=xmltodict.parse(content) # XML을 dictionary로 파싱
# 파싱은 어떤 페이지(문서, html 등)에서 내가 원하는 데이터를 특정 패턴이나 순서로 추출해 가공하는 것

if json.loads(json.dumps(dict['response']['msgHeader'], ensure_ascii=False))['resultCode'] == 4:
    print('도착 정보가 없습니다.')
else:
    jsonString = json.dumps(dict['response']['msgBody']['busLocationList'], ensure_ascii=False) # dict을 json으로 변환
    jsonObj = json.loads(jsonString) # json을 dict으로 변환

df1 = pd.DataFrame(jsonObj)
print(df1)