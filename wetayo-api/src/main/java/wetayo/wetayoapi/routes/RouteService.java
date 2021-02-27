package wetayo.wetayoapi.routes;

import org.springframework.stereotype.Service;

import java.sql.SQLException;
import java.util.List;

@Service
public class RouteService {
    private final RouteRepository routeRepository;

    public RouteService(RouteRepository routeRepository) {
        this.routeRepository = routeRepository;
    }

    public List<Route> findByRegionNameLike(String regionName) throws SQLException {
        List<Route> routes = routeRepository.findByRegionNameLike("%"+regionName+"%");
        if(routes.isEmpty()) throw new SQLException("dd");

        return routes;
    }
}
