package wetayo.wetayoapi.wetayo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import wetayo.wetayoapi.routes.RouteDto;

import javax.persistence.Column;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import java.util.List;

@Builder
@NoArgsConstructor
@AllArgsConstructor
@Data
public class RouteStationGraphQLDto {
    @NotNull
    @Column(name = "STATION_ID")
    private Integer stationId;

    @NotEmpty @NotNull
    @Column(name = "STATION_NAME")
    private String stationName;

    @NotEmpty @NotNull
    @Column(name = "MOBILE_NUMBER")
    private String mobileNumber;

    @NotNull
    private Integer distance;

    @NotNull @NotEmpty
    private List<RouteDto> routes;
}
