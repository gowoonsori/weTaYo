package wetayo.wetayoapi.routeStations;

import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

import javax.persistence.Column;
import javax.persistence.Id;
import java.io.Serializable;

@EqualsAndHashCode(onlyExplicitlyIncluded = true)
@NoArgsConstructor
public class RouteStationId implements Serializable {
    @Id
    @Column(name = "STATION_ID")
    @EqualsAndHashCode.Include
    private Integer stationId;

    @Id
    @Column(name = "ROUTE_ID")
    @EqualsAndHashCode.Include
    private Integer routeId;
}