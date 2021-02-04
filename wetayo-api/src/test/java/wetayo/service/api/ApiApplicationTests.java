package wetayo.service.api;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
<<<<<<< HEAD

@SpringBootTest
=======
import org.springframework.context.annotation.PropertySource;

@SpringBootTest
@PropertySource(value = { "classpath:jdbc.properties" })
>>>>>>> 253f59861aaf93c15acfe99a6556046cf46a8fe4
class ApiApplicationTests {

    @Test
    void contextLoads() {
    }

}
