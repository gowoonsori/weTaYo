package wetayo.wetayoapi.routeStations;

import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RouteStationService {
    private final RouteStationRepository routeStationRepository;

    public RouteStationService(RouteStationRepository routeStationRepository) {
        this.routeStationRepository = routeStationRepository;
    }

    public List<RouteStation> findByStationId(Integer id){
        return routeStationRepository.findByStationId(id);
    }
}
