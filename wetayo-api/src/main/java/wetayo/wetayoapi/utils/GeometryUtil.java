package wetayo.wetayoapi.utils;

import static java.lang.Math.acos;

public class GeometryUtil {
    public static Location calculateRangeGps(Double baseX, Double baseY, Double distance,
                                    Double bearing) {
        Double radianX = toRadian(baseX);
        Double radianY = toRadian(baseY);
        Double radianAngle = toRadian(bearing);

        Double distanceRadius = distance / 6371.01;

        Double gpsX = Math.asin(sin(radianX) * cos(distanceRadius) +
                cos(radianX) * sin(distanceRadius) * cos(radianAngle));
        Double gpsY = radianY + Math.atan2(sin(radianAngle) * sin(distanceRadius) *
                cos(radianX), cos(distanceRadius) - sin(radianX) * sin(gpsX));

        gpsY = normalizeY(gpsY);

        return new Location(toDegree(gpsX), toDegree(gpsY));
    }

    public static Integer calculateDistance(double lat1,double lon1, double lat2, double lon2){
        Double theta, dist;
        if((lat1== lat2) && (lon1 == lon2)){
            return 0;
        }
        theta = lon1 - lon2;
        dist = sin(toRadian(lat1)) * sin(toRadian(lat2)) +
                cos(toRadian(lat1)) * cos(toRadian(lat2)) * cos(toRadian(theta));
        dist = acos(dist);
        dist = toDegree(dist);
        dist = dist * 60 * 1.1515;
        dist = dist * 1.609344 * 1000;

        return dist.intValue();
    }

    private static Double toRadian(Double coordinate) {
        return coordinate * Math.PI / 180.0;
    }

    private static Double toDegree(Double coordinate) {
        return coordinate * 180.0 / Math.PI;
    }

    private static Double sin(Double coordinate) {
        return Math.sin(coordinate);
    }

    private static Double cos(Double coordinate) {
        return Math.cos(coordinate);
    }

    private static Double normalizeY(Double gpsY) {
        return (gpsY + 540) % 360 - 180;
    }
}
