package wetayo.wetayoapi.routes;

import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import javax.persistence.*;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import java.time.LocalDateTime;

@Builder
@Entity
@Getter @Setter @NoArgsConstructor @AllArgsConstructor
@EqualsAndHashCode(of = "id") @Table(name = "ROUTE")
public class Route {

    @Id
    @Column(name = "ROUTE_ID")
    private Integer id;

    @NotEmpty
    @Column(name = "ROUTE_NUMBER")
    private String routeNumber;
    @NotNull
    @Column(name = "ROUTE_TP")
    private Integer routeTp;

    @NotNull
    @Column(name = "START_STATION_ID")
    private Integer startStationId;
    @NotEmpty
    @Column(name = "START_STATION_NAME")
    private String startStationName;
    @NotEmpty
    @Column(name = "START_STATION_NUMBER")
    private String startStationNumber;

    @NotNull
    @Column(name = "END_STATION_ID")
    private Integer endStationId;
    @NotEmpty
    @Column(name = "END_STATION_NAME")
    private String endStationName;
    @NotEmpty
    @Column(name = "END_STATION_NUMBER")
    private String endStationNumber;

    @NotEmpty
    @Column(name = "UP_FIRST_TIME")
    private String upFirstTime;
    @NotEmpty
    @Column(name = "UP_LAST_TIME")
    private String upLastTime;

    @NotEmpty
    @Column(name = "DOWN_FIRST_TIME")
    private String downFirstTime;
    @NotEmpty
    @Column(name = "DOWN_LAST_TIME")
    private String downLastTime;

    @NotNull
    @Column(name = "PEEK_ALLOC")
    private Integer peekAlloc;
    @NotNull
    @Column(name = "NPEEK_ALLOC")
    private Integer nPeekAlloc;

    @NotNull
    @Column(name = "COMPANY_ID")
    private Integer companyId;
    @NotEmpty
    @Column(name = "COMPANY_NAME")
    private String companyName;
    @NotEmpty
    @Column(name = "TEL_NUMBER")
    private String telNumber;

    @NotEmpty
    @Column(name = "REGION_NAME")
    private String regionName;

    @NotNull
    @Column(name = "DISTRICT_CODE")
    private Integer districtCode;

    @CreationTimestamp
    @Column(name = "CREATED_TIME", insertable = false)
    private LocalDateTime createdTime;
    @UpdateTimestamp
    @Column(name = "UPDATED_TIME", updatable = false, insertable = false)
    private LocalDateTime updatedTime;
}