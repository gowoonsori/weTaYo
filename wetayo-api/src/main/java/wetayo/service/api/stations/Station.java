package wetayo.service.api.stations;

import lombok.*;

import javax.persistence.*;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

/*
*   routId + stationId = Super Key
* */


@Builder
@Entity
@Getter @Setter @AllArgsConstructor @NoArgsConstructor @EqualsAndHashCode(of = "id")
public class Station {

    @Id
    private Integer id;
    @NotNull
    private Integer mobile_number;
    @NotEmpty
    private String station_name;
    @NotEmpty
    private String route_name;
    @NotEmpty
    private String up_down;
    @NotNull
    private Integer station_order;
    @NotEmpty
    private String gps_X;
    @NotEmpty
    private String gps_Y;
    @NotEmpty
    private String region;
    private boolean isPerson;
    private boolean isThereCenter;
    @Enumerated(EnumType.STRING)
    private DistrictCode districtCode = DistrictCode.GYEONGGI;
}
