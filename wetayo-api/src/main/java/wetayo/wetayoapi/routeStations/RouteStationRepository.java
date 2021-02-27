package wetayo.wetayoapi.routeStations;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface RouteStationRepository extends JpaRepository<RouteStation,Integer> {
    List<RouteStation> findByStationId(Integer stationId);
}
