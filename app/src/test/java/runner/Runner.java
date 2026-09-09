package runner;

import static org.junit.jupiter.api.Assertions.assertEquals;

import com.intuit.karate.Results;
import org.junit.jupiter.api.Test;

public class Runner {

    @Test
    void testParallel() {

        Results results = com.intuit.karate.Runner.path("classpath:features")
                .outputCucumberJson(true) // <--- AQU SE CONFIGURA
                .parallel(1); // Define el nmero de hilos concurrentes
        // Asercin para asegurar que el build de Gradle/Maven falle si alguna prueba no
        // pasa
        assertEquals(0, results.getFailCount(), results.getErrorMessages());

    }

}