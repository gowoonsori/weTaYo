package wetayo.service.api.stations;

import lombok.*;

import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.validation.constraints.NotEmpty;

/*
*   routId + stationId = Super Key
* */


@Builder
@Entity
@Getter @Setter @AllArgsConstructor @NoArgsConstructor @EqualsAndHashCode(of = "busId")
public class Station {

    @EmbeddedId
    private BusId busId;
    private int mobileNumber;
    @NotEmpty
    private String stationName;
    @NotEmpty
    private String routeName;
    @NotEmpty
    private String upDown;
    @NotEmpty
    private Integer stationOrder;
    @NotEmpty
    private String gpsX;
    @NotEmpty
    private String gpsY;
    @NotEmpty
    private String region;
    private boolean isPerson = false;
    private boolean isThereCenter = false;
    @Enumerated(EnumType.STRING)
    private DistrictCode districtCode = DistrictCode.GYEONGGI;
}
