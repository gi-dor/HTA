package Java.io.io4;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import org.apache.commons.io.IOUtils;

public class App1 {

    public static void main(String[] args) throws IOException {

        /*
        URL
            - URL 객체는 지정된 URL 주소가 가르키는 자원을 표현하는 객체다
            - URL 객체의 openStream() 메서드는 해당 자원과 연결된 읽기 스트림을 반환한다
            - URL 객체의 openStream() 메서드를 실행해서 획득한 InputStream을 활용하면
                URL 주소가 표현하는 자원을 읽어올 수 있다
         */

        URL url = new URL("https://blog.naver.com/kalefarmer/220993056808");

        InputStream in = url.openStream();
        FileOutputStream out = new FileOutputStream("C:/Users/Han/IdeaProjects/HTA/Java/io/io4/sa1mple.jpg");

        IOUtils.copy(in, out);
    }
}
