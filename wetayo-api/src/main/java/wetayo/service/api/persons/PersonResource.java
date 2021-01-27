package wetayo.service.api.persons;

import org.springframework.hateoas.EntityModel;
import org.springframework.hateoas.Link;
import wetayo.service.api.stations.Station;
import static org.springframework.hateoas.server.mvc.WebMvcLinkBuilder.linkTo;


public class PersonResource extends EntityModel<Station> {
    public PersonResource(Station station, Link...links){
        super(station,links);
        add(linkTo(PersonController.class).slash(station.getId()).withSelfRel());
    }
}
