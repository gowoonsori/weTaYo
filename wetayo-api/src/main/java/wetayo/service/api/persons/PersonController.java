package wetayo.service.api.persons;

import org.modelmapper.ModelMapper;
import org.springframework.hateoas.Link;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.*;
import wetayo.service.api.Common.ErrorResource;
import wetayo.service.api.stations.Station;
import wetayo.service.api.stations.StationRepository;

import javax.validation.Valid;
import java.util.Optional;
import java.util.logging.Logger;

@Controller
@RequestMapping(value = "api/persons", produces = "application/json; charset=UTF-8")
public class PersonController {
    private final StationRepository stationRepository;
    private final ModelMapper modelMapper;
    Logger LOG = Logger.getGlobal();

    public PersonController(StationRepository stationRepository, ModelMapper modelMapper){
        this.stationRepository = stationRepository;
        this.modelMapper = modelMapper;
    }

    @PutMapping("/{id}")
    public ResponseEntity updatePerson(@PathVariable Integer id,@RequestBody @Valid PersonDto personDto, Errors errors){
        LOG.info(String.valueOf(id));
        Optional<Station> optionalStation = this.stationRepository.findById(id);
        if(optionalStation.isEmpty()){
            return ResponseEntity.notFound().build();
        }
        if(errors.hasErrors()){
            return makeBadRequestToErrors(errors);
        }

        Station updatePerson = optionalStation.get();
        this.modelMapper.map(personDto,updatePerson);
        Station savedPerson = this.stationRepository.save(updatePerson);

        PersonResource personResource = new PersonResource(savedPerson);
        personResource.add(new Link("/docs/index.html#update-person").withRel("profile"));

        return ResponseEntity.ok(personResource);
    }

    private ResponseEntity makeBadRequestToErrors(Errors errors){
        return ResponseEntity.badRequest().body(ErrorResource.modelOf(errors));
    }
}
