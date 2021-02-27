package wetayo.wetayoapi.wetayo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

@Builder
@NoArgsConstructor
@AllArgsConstructor
@Data
public class StationGraphQLDto {
    @NotNull
    private Integer stationId;

    @NotEmpty
    private String stationName;

    @NotEmpty
    private String mobileNumber;

    @NotNull
    private Integer distance;
}
