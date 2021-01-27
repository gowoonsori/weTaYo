package wetayo.service.api.persons;


import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import wetayo.service.api.stations.DistrictCode;
import wetayo.service.api.stations.Station;
import wetayo.service.api.stations.StationRepository;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.put;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

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

    @Autowired
    ModelMapper modelMapper;

    @Test
    void ridePersonTest(){
        Station station = generateStation("12","31");
        String busId = "12"+"31";
        PersonDto personDto = this.modelMapper.map(station,PersonDto.class);
        personDto.setPerson(true);

        try {
            this.mockMvc.perform(put("/api/persons/{id}",busId)
                    .contentType(MediaType.APPLICATION_JSON)
                    .accept(MediaType.APPLICATION_JSON)
                    .content(this.objectMapper.writeValueAsString(personDto)))
                    .andDo(print())
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("person").value(true))

            ;
        }catch (Exception e){
            System.out.println(e);
        }
    }

    @Test
    @DisplayName("id is not found")
    void ridePersonTestFail(){
        Station station = generateStation("12","1111");
        String busId = "12"+"31";
        PersonDto personDto = this.modelMapper.map(station,PersonDto.class);
        personDto.setPerson(true);

        try {
            this.mockMvc.perform(put("/api/persons/{id}",busId)
                    .contentType(MediaType.APPLICATION_JSON)
                    .accept(MediaType.APPLICATION_JSON)
                    .content(this.objectMapper.writeValueAsString(personDto)))
                    .andDo(print())
                    .andExpect(status().isNotFound());
        }catch (Exception e){
            System.out.println(e);
        }
    }

    @Test
    @DisplayName("No id")
    void ridePersonTestFailNoId(){
        Station station = generateStation("12","1111");
        String busId = "";
        PersonDto personDto = this.modelMapper.map(station,PersonDto.class);
        personDto.setPerson(true);

        try {
            this.mockMvc.perform(put("/api/persons/{id}",busId)
                    .contentType(MediaType.APPLICATION_JSON)
                    .accept(MediaType.APPLICATION_JSON)
                    .content(this.objectMapper.writeValueAsString(personDto)))
                    .andDo(print())
                    .andExpect(status().isNotFound());
        }catch (Exception e){
            System.out.println(e);
        }
    }

    private Station generateStation(String i, String j){
        Station station = Station.builder()
                .id( Integer.parseInt(i+j))
                .station_name("first station")
                .station_order(2)
                .isPerson(false)
                .districtCode(DistrictCode.GYEONGGI)
                .gps_X("23.41")
                .gps_Y("12.42")
                .isThereCenter(false)
                .mobile_number(2345)
                .region("Siheung")
                .route_name("81")
                .up_down("up")
                .build();
        return this.stationRepository.save(station);
    }
}
