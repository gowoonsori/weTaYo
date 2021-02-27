package wetayo.wetayoapi.routes;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface RouteRepository extends JpaRepository<Route,Integer> {
    Optional<Route> findById(Integer id);

    List<Route> findByRegionNameLike(String regionName);
}
