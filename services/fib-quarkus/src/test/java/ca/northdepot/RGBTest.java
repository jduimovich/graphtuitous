package ca.northdepot;

import io.quarkus.test.junit.QuarkusTest;
import org.junit.jupiter.api.Test;

import static io.restassured.RestAssured.given;
import static org.hamcrest.CoreMatchers.hasItem;
import static org.hamcrest.CoreMatchers.is;

@QuarkusTest
public class RGBTest {

    @Test
    public void testTestEndpoint() {
        given()
          .when().get("/test")
          .then()
             .statusCode(200);
    }

}