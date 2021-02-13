package ca.northdepot;
import java.net.InetAddress;

public class Response {  
    static int allTimeCount = 0;

    public String hostname;
    public String version;
    public String colour;
    public int count;
    public String stack; 
    public int loop;
    public String compute;
    public long time;

    public Response() {
    }

    public Response(String version, String colour, int loop, int param) {
        try { 
            this.hostname = InetAddress.getLocalHost().getHostName() + ":Q";
        } catch (Exception e) { 
            this.hostname = "Error Getting Hostname";
        }
        this.version = version;
        this.colour = colour;
        this.count = ++allTimeCount;
        this.stack = "Quarkus"; 
        this.loop = loop;
        this.compute = "fib(" + param + ")";

        long start = System.currentTimeMillis();
        int i = loop;
        while (i-- > 0)
            fib(param);
        long end = System.currentTimeMillis();
        this.time = end - start;
        if (allTimeCount % 20 == 0) { 
            System.out.printf("fibHandler: called  %d times\n", allTimeCount);
        }
    }

    private int fib(int n) {
        if (n < 3)
            return 1;
        return fib(n - 1) + fib(n - 2);
    }
}