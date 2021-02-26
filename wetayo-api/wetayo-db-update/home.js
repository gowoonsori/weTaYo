const { getTxt } = require('./getTxt');
const { stations, routeStations, routes, buses } = require('./txtParse');
const fs = require('fs');
const mysql = require('mysql');

/*공공 api에서 txt 다운 */
//getTxt();

/* route에서 시흥만 뽑아낸 후 route에 해당하는 routeStatio 조회
    -> station 조회해서 최종 gps정보 get 
*/
let routeStationResult = [];
let stationResult = new Map();
//route
let routeResult = routes.filter((route) => -1 != route['REGION_NAME'].indexOf('시흥'));

let start = new Date();
//routeStation
for (let i = 0; i < routeResult.length; i++) {
  let routId = routeResult[i].ROUTE_ID;
  for (let j = 0; j < routeStations.length; j++) {
    if (routId === routeStations[j].ROUTE_ID) {
      routeStationResult.push(routeStations[j]);
    }
  }
}
//station
for (let i = 0; i < routeStationResult.length; i++) {
  let stationId = routeStationResult[i].STATION_ID;

  for (let j = 0; j < stations.length; j++) {
    if (stationId === stations[j].STATION_ID) {
      stationResult.set(stationId, stations[j]);
      break;
    }
  }
}
let end = new Date();

console.log('시흥시 route 개수 : ' + routeResult.length);
console.log('시흥시 route station 개수 : ' + routeStationResult.length);
console.log('시흥시 station 개수 : ' + stationResult.size);
console.log('txt 객체 map으로 파싱하는데 걸린 시간 : ' + (end - start) / 1000 + '초');

connection.end().then(console.log('끝났습니다.'));
