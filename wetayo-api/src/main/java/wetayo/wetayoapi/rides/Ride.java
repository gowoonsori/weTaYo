package wetayo.wetayoapi.rides;

import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;
import wetayo.wetayoapi.routeStations.RouteStationId;

import javax.persistence.*;
import java.time.LocalDateTime;

@Builder
@Entity
@Getter @Setter @AllArgsConstructor @NoArgsConstructor
@IdClass(RouteStationId.class)
@Table(name = "RIDE")
public class Ride {

    @Id
    private Integer stationId;

    @Id
    private Integer routeId;

    @CreationTimestamp
    @Column(name = "CREATED_TIME", insertable = false)
    private LocalDateTime createdTime;
    @UpdateTimestamp
    @Column(name = "UPDATED_TIME", updatable = false, insertable = false)
    private LocalDateTime updatedTime;
}
