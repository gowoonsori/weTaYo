package wetayo.service.api.persons;

import lombok.*;

import javax.validation.constraints.NotNull;

@Builder @NoArgsConstructor @AllArgsConstructor @Getter @Setter
public class PersonDto {
    @NotNull
    private boolean isPerson;
}
