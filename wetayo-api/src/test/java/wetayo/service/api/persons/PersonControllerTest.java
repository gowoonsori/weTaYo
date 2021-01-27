package wetayo.service.api.persons;


import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.context.TestConfiguration;
import org.springframework.http.MediaType;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import wetayo.service.api.stations.BusId;
import wetayo.service.api.stations.DistrictCode;
import wetayo.service.api.stations.Station;
import wetayo.service.api.stations.StationRepository;

import java.net.http.HttpHeaders;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;

@SpringBootTest
@AutoConfigureMockMvc
@WebAppConfiguration
@ActiveProfiles("Test")
public class PersonControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    protected ObjectMapper objectMapper;

    @Autowired
    StationRepository stationRepository;

    @Test
    void ridePerson(){
        generateStation(12,31);
        PersonDto personDto = PersonDto.builder()
                .isPerson(true)
                .busId(new BusId(12,31))
                .build();

        try {
            this.mockMvc.perform(put("/api/persons")
                    .contentType(MediaType.APPLICATION_JSON)
                    .contentType(this.objectMapper.writeValueAsString(personDto)));
        }catch (Exception e){
            System.out.println(e);
        }
    }

    private Station generateStation(int i, int j){
        BusId busId = new BusId();
        busId.setStationId(i);
        busId.setRouteId(j);
        Station station = Station.builder()
                .busId(busId)
                .stationName("first station")
                .stationOrder(2)
                .isPerson(false)
                .districtCode(DistrictCode.GYEONGGI)
                .gpsX("23.41")
                .gpsY("12.42")
                .isThereCenter(false)
                .mobileNumber(2345)
                .region("Siheung")
                .routeName("81")
                .upDown("up")
                .build();
        return this.stationRepository.save(station);
    }
}
