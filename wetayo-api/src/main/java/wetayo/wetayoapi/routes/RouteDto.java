package wetayo.wetayoapi.routes;

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
public class RouteDto {
    @NotNull
    private Integer routeId;

    @NotEmpty
    @NotNull
    private String routeNumber;
}

