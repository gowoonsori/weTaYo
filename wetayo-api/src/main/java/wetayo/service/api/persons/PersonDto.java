package wetayo.service.api.persons;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.NoArgsConstructor;
import wetayo.service.api.stations.BusId;

import javax.validation.constraints.NotEmpty;

@Builder @NoArgsConstructor @AllArgsConstructor
public class PersonDto {
    @NotEmpty
    private BusId busId;

    @NotEmpty
    private boolean isPerson;
}
