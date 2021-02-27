package wetayo.wetayoapi.stations;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface StationRepository extends JpaRepository<Station,Integer> {
    Optional<Station> findById(Integer id);
}
