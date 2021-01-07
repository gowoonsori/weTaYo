# 내 위치를 기반으로 x, y를 입력받아 200m 반경의 정류소를 모두 표시해줌

import requests, xmltodict, json
import pandas as pd
from pandas import DataFrame as df

serviceKey = 'Q2kheZxOB4Se5Iqm4ZVPAaA6Vaf9%2BdfUAIvymf%2BBWd3VoYvRmkjMQrQmE9LrIyizUYlkkW65HDZTmswAPgDDVA%3D%3D'

# 10진수 도로 표시 (내 위치 x, y 값)
my_x = 126.7309 # -90~90사이의 값
my_y = 37.3412  # -180~180사이의 값

endpoint = 'http://openapi.gbis.go.kr/ws/rest/busstationservice/searcharound?serviceKey={}&x={}&y={}'.format(serviceKey, my_x, my_y)
print(endpoint)

content = requests.get(endpoint).content # GET요청
dict=xmltodict.parse(content) # XML을 dictionary로 파싱
# 파싱은 어떤 페이지(문서, html 등)에서 내가 원하는 데이터를 특정 패턴이나 순서로 추출해 가공하는 것

jsonString = json.dumps(dict['response']['msgBody']['busStationAroundList'], ensure_ascii=False) # dict을 json으로 변환
jsonObj = json.loads(jsonString) # json을 dict으로 변환

df1 = pd.DataFrame(jsonObj)
print(df1)