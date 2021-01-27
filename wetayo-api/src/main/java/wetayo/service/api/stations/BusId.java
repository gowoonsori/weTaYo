package wetayo.service.api.stations;

import lombok.*;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import java.io.Serializable;

@Embeddable
@Getter @Setter @NoArgsConstructor @AllArgsConstructor
public class BusId implements Serializable {

    @Column(name = "ROUTE_ID")
    private Integer routeId;

    @Column(name = "STATION_ID")
    private Integer stationId;
}
