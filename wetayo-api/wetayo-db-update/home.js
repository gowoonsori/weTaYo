const parse = require('./dbParser');
const mysql = require('mysql');
const request = require('request');
const convert = require('xml-js');

const serviceKey = process.env.service_key;
const url = `http://openapi.gbis.go.kr/ws/rest/baseinfoservice?serviceKey=${serviceKey}`;
const connection = mysql.createConnection({
  host: process.env.mysql_host,
  user: process.env.mysql_user,
  password: process.env.mysql_passwd,
  database: process.env.mysql_table,
});

let apiJson = null;
let routeStations, routes, stations, busses;

let routeStationResult = [];
let stationResult = new Map();
let routeResult = [];

exports.handler = (event, context, callback) => {
  connection.connect();

  request.get({ url: url }, function (err, res, body) {
    if (err) {
      console.log(err.stack);
      return 0;
    }
    if (res) apiJson = convert.xml2json(body);
    if (apiJson !== null) {
      request.get(
        {
          //url: 'http://openapi.gbis.go.kr/ws/download?route20210227.txt',
          url: apiJson.response.msgBody.baseInfoItem.routeStationDownloadUrl,
        },
        function (err, res, body) {
          if (err) console.error(err.stack);
          routes = parse.dbParser(body);
        }
      );

      request.get(
        {
          //url: 'http://openapi.gbis.go.kr/ws/download?routeStation20210227.txt',
          url: apiJson.response.msgBody.baseInfoItem.routeStationDownloadUrl,
        },
        function (err, res, body) {
          if (err) console.error(err.stack);
          routeStations = parse.dbParser(body);
        }
      );

      request.get(
        {
          //url: 'http://openapi.gbis.go.kr/ws/download?station20210227.txt',
          url: apiJson.response.msgBody.baseInfoItem.routeStationDownloadUrl,
        },
        function (err, res, body) {
          if (err) console.error(err.stack);
          stations = parse.dbParser(body);
        }
      );
      request.get(
        {
          //url: 'http://openapi.gbis.go.kr/ws/download?vehicle20210227.txt',
          url: apiJson.response.msgBody.baseInfoItem.routeStationDownloadUrl,
        },
        function (err, res, body) {
          if (err) console.error(err.stack);
          busses = parse.dbParser(body);
        }
      );

      setTimeout(() => {
        routeResult = routes.filter((route) => -1 != route['REGION_NAME'].indexOf('시흥'));

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

        console.log('시흥시 route 개수 : ' + routeResult.length);
        console.log('시흥시 route station 개수 : ' + routeStationResult.length);
        console.log('시흥시 station 개수 : ' + stationResult.size);

        //Station
        stationResult.forEach((value, key) => {
          let mobileNumber = value.MOBILE_NO === '' ? -1 : value.MOBILE_NO;

          const stationQuery = `INSERT INTO STATION(STATION_ID,STATION_NAME,CENTER_ID,CENTER_YN,REGION_NAME,MOBILE_NUMBER,GPS,DISTRICT_CODE)
    VALUES (${value.STATION_ID},"${value.STATION_NM}",${value.CENTER_ID},"${value.CENTER_YN}","${value.REGION_NAME}",${mobileNumber},
    ST_GeomFromText('POINT(${value.Y} ${value.X})'),${value.DISTRICT_CD})
    ON DUPLICATE KEY
    UPDATE
    STATION_ID = ${value.STATION_ID},
    STATION_NAME = "${value.STATION_NM}",
    CENTER_ID = ${value.CENTER_ID},
    CENTER_YN = "${value.CENTER_YN}",
    REGION_NAME = "${value.REGION_NAME}",
    MOBILE_NUMBER = ${mobileNumber},
    GPS = ST_GeomFromText('POINT(${value.Y} ${value.X})'),
    DISTRICT_CODE = ${value.DISTRICT_CD}`;
          connection.query(stationQuery, function (err) {
            if (err) {
              console.log('station MergeInto err : ' + key + '\n' + stationQuery + '\n' + err.stack);
              console.log(value);
            } else {
              console.log('station Table Merge Success');
            }
          });
        });

        //Route
        routeResult.forEach((route, index) => {
          let start_station_number = route.ㄴㅆ_STA_NO === '' ? -1 : route.ST_STA_NO;
          let end_station_number = route.ED_STA_NO === '' ? -1 : route.ED_STA_NO;

          const routeQuery = `INSERT INTO ROUTE( ROUTE_ID ,ROUTE_NUMBER ,ROUTE_TP,
            START_STATION_ID,START_STATION_NAME,START_STATION_NUMBER,
            END_STATION_ID,END_STATION_NAME,END_STATION_NUMBER,
            UP_FIRST_TIME,UP_LAST_TIME,DOWN_FIRST_TIME,DOWN_LAST_TIME,
            PEEK_ALLOC,NPEEK_ALLOC,
            COMPANY_ID,COMPANY_NAME,TEL_NUMBER,REGION_NAME,DISTRICT_CODE)
    VALUES (${route.ROUTE_ID} ,"${route.ROUTE_NM}" ,${route.ROUTE_TP},${route.ST_STA_ID},
        "${route.ST_STA_NM}","${start_station_number}",${route.ED_STA_ID},"${route.ED_STA_NM}","${end_station_number}",
        "${route.UP_FIRST_TIME}","${route.UP_LAST_TIME}","${route.DOWN_FIRST_TIME}","${route.DOWN_LAST_TIME}",
        ${route.PEEK_ALLOC},${route.NPEEK_ALLOC},${route.COMPANY_ID},"${route.COMPANY_NM}","${route.TEL_NO}",
        "${route.REGION_NAME}",${route.DISTRICT_CD})
    ON DUPLICATE KEY
    UPDATE
        ROUTE_ID = ${route.ROUTE_ID},
        ROUTE_NUMBER = "${route.ROUTE_NM}",
        ROUTE_TP = ${route.ROUTE_TP},
        START_STATION_ID = ${route.ST_STA_ID},
        START_STATION_NAME = "${route.ST_STA_NM}",
        START_STATION_NUMBER = "${start_station_number}",
        END_STATION_ID = ${route.ED_STA_ID},
        END_STATION_NAME = "${route.ED_STA_NM}",
        END_STATION_NUMBER = "${end_station_number}",
        UP_FIRST_TIME = "${route.UP_FIRST_TIME}",
        UP_LAST_TIME = "${route.UP_LAST_TIME}",
        DOWN_FIRST_TIME = "${route.DOWN_FIRST_TIME}",
        DOWN_LAST_TIME = "${route.DOWN_LAST_TIME}",
        PEEK_ALLOC = ${route.PEEK_ALLOC},
        NPEEK_ALLOC = ${route.NPEEK_ALLOC},
        COMPANY_ID = ${route.COMPANY_ID},
        COMPANY_NAME = "${route.COMPANY_NM}",
        TEL_NUMBER = "${route.TEL_NO}",
        REGION_NAME = "${route.REGION_NAME}",
        DISTRICT_CODE = ${route.DISTRICT_CD}`;

          connection.query(routeQuery, function (err) {
            if (err) {
              console.log(index + '. route MergeInto err : ' + route.ROUTE_ID + '\n' + routeQuery + '\n' + err.stack);
              console.log(route);
            } else {
              console.log('route Table Merge Success');
            }
          });
        });

        //RouteStation
        routeStationResult.forEach((routeStation, index) => {
          const routeStationQuery = `INSERT INTO ROUTE_STATION( STATION_ID, ROUTE_ID, UP_DOWN, STATION_ORDER, ROUTE_NUMBER,STATION_NAME)
      VALUES (${routeStation.STATION_ID}, ${routeStation.ROUTE_ID}, "${routeStation.UPDOWN}", ${routeStation.STA_ORDER},
       "${routeStation.ROUTE_NM}", "${routeStation.STATION_NM}")
      ON DUPLICATE KEY
      UPDATE
        STATION_ID = ${routeStation.STATION_ID},
        ROUTE_ID = ${routeStation.ROUTE_ID},
        UP_DOWN = "${routeStation.UPDOWN}",
        STATION_ORDER = ${routeStation.STA_ORDER},
        ROUTE_NUMBER = "${routeStation.ROUTE_NM}",
        STATION_NAME = "${routeStation.STATION_NM}"`;

          connection.query(routeStationQuery, function (err) {
            if (err) {
              console.log(
                index +
                  '. routeStation MergeInto err : ' +
                  routeStation.STATION_ID +
                  ' ' +
                  routeStation.ROUTE_ID +
                  '\n' +
                  routeStationQuery +
                  '\n' +
                  err.stack
              );
              console.log(routeStation);
            } else {
              console.log('route station Table Merge Success');
            }
          });
        });

        connection.end();
      }, 30000);
    }
  });
};
