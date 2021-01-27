package wetayo.service.api;

import org.modelmapper.ModelMapper;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
public class ApiApplication {
    @Bean
    public ModelMapper modelMapper(){
        return new ModelMapper();
    }
    //main
    public static void main(String[] args) {
        SpringApplication.run(ApiApplication.class, args);

    }

}
