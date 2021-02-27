package wetayo.wetayoapi.routeStations;

import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import javax.persistence.*;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import java.time.LocalDateTime;

@Builder
@Entity
@Getter @Setter @AllArgsConstructor @NoArgsConstructor
@IdClass(RouteStationId.class)
@Table(name = "ROUTE_STATION")
public class RouteStation {
    @Id
    private Integer stationId;

    @Id
    private Integer routeId;

    @NotNull @NotEmpty
    @Column(name = "STATION_NAME")
    private String stationName;

    @NotNull @NotEmpty
    @Column(name = "ROUTE_NUMBER")
    private String routeNumber;

    @NotEmpty
    @Column(name = "UP_DOWN")
    private String upDown;

    @NotNull
    @Column(name = "STATION_ORDER")
    private Integer stationOrder;

    @CreationTimestamp
    @Column(name = "CREATED_TIME", insertable = false)
    private LocalDateTime createdTime;
    @UpdateTimestamp
    @Column(name = "UPDATED_TIME", updatable = false, insertable = false)
    private LocalDateTime updatedTime;
}
