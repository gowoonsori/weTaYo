## Wetayo-api

Server Endpoint : http://3.35.30.64/wetayo

<br>
<br>

## GraphQL Schema

### ◾ Query

1. getStation

   gps 위도, 경도, 측정 범위를 파라미터로 특정 범위내 정류장 정보 조회

   ```js
   getStation(
       gpsY: Float!
       gpsX: Float!
       distance: Float!
   ): [Station]

   type Station {
       stationId: Int
       stationName: String
       mobileNumber: String
       distance: Int
   }
   ```

   - 요청 예시

     ```js
     query{
         getStation(gpsY: 37.3740667 gpsX: 126.8424833 distance: 0.02){
           stationId
           stationName
           mobileNumber
           distance
             }
         }
     ```

   - 응답 예시

     ```js
     {
     "data": {
         "getStation": [
             {
             "stationId": 224000876,
             "stationName": "목감호수품애.중흥S클래스",
             "mobileNumber": "25894",
             "distance": 0
             }
         ]}
     }
     ```

<br>

2. getStationAndRoute

   gps 위도, 경도, 측정 범위를 파라미터로 특정 범위내 정류장과 정류장에 속한 버스번호들 조회

   ```js
   getStationAndRoute(
       gpsY: Float!
       gpsX: Float!
       distance: Float!
   ): [StationAndRoute]

   type StationAndRoute {
       stationId: Int
       stationName: String
       mobileNumber: String
       distance: Int
       routes: [Route]!
   }
   ```

   - 요청 예시

     ```js
     query{
         getStationAndRoute(gpsY: 37.3740667, gpsX: 126.8424833, distance: 0.02){
             stationId
             stationName
             mobileNumber
             distance
               routes{
               routeId
               routeNumber
             }
         }
     }
     ```

   - 응답 예시

     ```js
     {
         "data": {
             "getStationAndRoute": [
                 {
                     "stationId": 224000876,
                     "stationName": "목감호수품애.중흥S클래스",
                     "mobileNumber": "25894",
                     "distance": 0,
                     "routes": [
                         {
                             "routeId": 208000009,
                             "routeNumber": "81"
                         }
                     ]
                 }
             ]
         }
     }
     ```

<br>

3. getRide

   버스기사가 이용하며 해당 정류장에 탑승을 희망하는 고객이 있는지 boolean 형으로 조회

   ```js
   getRide(
       stationId: Int!
       routeId: Int!
   ): Boolean!
   ```

   - 요청 예시

     ```js
     query{
         getRide(stationId: 224000876 routeId: 208000008)
     }
     ```

   - 응답 예시

     ```js
     {
         "data": {
             "getRide": false
         }
     }
     ```

<br>

4. getRoute

   버스기사가 이용하며 지역이름으로 버스노선들 조회

   ```js
   getRoute(
       regionName: String!
   ): [Route]

   type Route {
       routeId: Int
       routeNumber: String
   }
   ```

   - 요청 예시

     ```js
     query{
         getRoute(regionName: "시흥"){
             routeId
             routeNumber
         }
     }
     ```

   - 응답 예시

     ```js
     {
         "data": {
             "getRoute": [
                 {
                     "routeId": 208000009,
                     "routeNumber": "81"
                 }
             ]
         }
     }
     ```

<br><br>

### ◾ Mutation

1. createRide

   사용자가 특정 정류장의 버스노선을 탑승하고자 선택하는 이벤트

   ```js
   createRide(
       stationId: Int
       routeId: Int
   ): Ride!

   type Ride {
       stationId: Int!
       routeId: Int!
   }
   ```

   - 요청 예시

     ```js
     mutation{
         createRide(stationId: 224000876 routeId:    208000009){
             stationId
             routeId
         }
     }
     ```

   - 응답 예시

     ```js
     {
         "data": {
             "createRide": {
                 "stationId": 224000876,
                 "routeId": 208000009
             }
         }
     }
     ```

<br>

2. deleteRide

   기사가 이용하며 탑승희망자를 삭제하는 이벤트

   ```js
   deleteRide(
       stationId: Int
       routeId: Int
   ): Boolean!
   ```

   - 요청 예시

     ```js
     mutation{
         deleteRide(stationId: 224000876 routeId: 208000009)
     }
     ```

   - 응답 예시

     ```js
     {
         "data": {
             "deleteRide": true
         }
     }
     ```
