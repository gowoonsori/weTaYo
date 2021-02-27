package wetayo.wetayoapi;

import graphql.kickstart.spring.web.boot.GraphQLWebsocketAutoConfiguration;
import org.junit.jupiter.api.Test;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
@EnableAutoConfiguration(exclude = {GraphQLWebsocketAutoConfiguration.class})
class WetayoApiApplicationTests {

    @Test
    void contextLoads() {
    }

}
