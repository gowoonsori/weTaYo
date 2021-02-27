package wetayo.wetayoapi.rides;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface RideRepository extends JpaRepository<Ride,Integer> {
    Optional<Ride> findByStationIdAndRouteId(Integer stationId,Integer routeId);
}
