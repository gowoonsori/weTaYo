package wetayo.wetayoapi.rides;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import wetayo.wetayoapi.routes.Route;
import wetayo.wetayoapi.routes.RouteRepository;
import wetayo.wetayoapi.stations.Station;
import wetayo.wetayoapi.stations.StationRepository;

import java.sql.SQLException;
import java.util.Optional;

@Service
@Slf4j
public class RideService {
    private final RideRepository rideRepository;
    private final StationRepository stationRepository;
    private final RouteRepository routeRepository;

    RideService(RideRepository rideRepository, StationRepository stationRepository, RouteRepository routeRepository) {
        this.rideRepository = rideRepository;
        this.stationRepository = stationRepository;
        this.routeRepository = routeRepository;
    }

    public Ride findByStationIdAndRouteId(Integer stationId,Integer routeId) throws SQLException{
        Optional<Ride> ride = rideRepository. findByStationIdAndRouteId(stationId, routeId);
        if(ride.isEmpty()){
            throw new SQLException("dd");
        }
        return ride.get();
    }

    public Ride addRide(Integer stationId, Integer routeId){
        Optional<Station> station =  stationRepository.findById(stationId);
        Optional<Route> route =  routeRepository.findById(routeId);

        if(route.isEmpty() || station.isEmpty()){
            log.info("Insert Exception : Not Found Id",stationId,routeId);
            throw new RuntimeException("Insert Exception : Not Found Id");
        }
        Optional<Ride> ride = rideRepository.findByStationIdAndRouteId(stationId, routeId);
        if(ride.isPresent()){
            log.info("Insert Exception : Already insert", stationId, routeId);
            throw new RuntimeException("Insert Exception : Already insert");
        }
        return rideRepository.save(Ride.builder().routeId(routeId).stationId(stationId).build());
    }

    public void deleteRide(Integer stationId, Integer routeId) {
        Optional<Ride> optionalRide = rideRepository. findByStationIdAndRouteId(stationId,routeId);
        if(optionalRide.isEmpty()){
            log.info("Delete Exception : Not exist id");
            throw new RuntimeException("Delete Exception : Not exist id");
        }

        rideRepository.delete(optionalRide.get());
    }
}
