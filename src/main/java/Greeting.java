import java.time.LocalTime;

public class Greeting {
    public static void main(String[] args) {
        LocalTime now = LocalTime.now();
        String greeting;
        if (now.isBefore(LocalTime.NOON)) {
            greeting = "Good morning, Stephie! Welcome to COMP367.";
        } else {
            greeting = "Good afternoon, Stephie! Welcome to COMP367.";
        }
        System.out.println(greeting);
    }
}
