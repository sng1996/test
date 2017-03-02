package gavrilko;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;

/**
 * Created by sergeigavrilko on 01.03.17.
 */
@Controller
public class GreetingController {

    @MessageMapping("/hello")
    @SendTo("/topic/greetings")
    public Greeting greeting(String message) throws Exception {
        Thread.sleep(3000); // simulated delay
        System.out.println("I'm HERE");
        return new Greeting("Hello, " + message + "!");
    }

}
