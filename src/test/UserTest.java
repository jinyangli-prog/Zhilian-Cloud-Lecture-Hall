import cs.sasu.mapper.UserMapper;
import cs.sasu.pojo.Mark;
import cs.sasu.pojo.Photo;
import cs.sasu.pojo.User;
import cs.sasu.service.DayImpl;
import cs.sasu.service.DayService;
import cs.sasu.service.MarkService;
import cs.sasu.service.PhotoService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations="classpath:applicationContext.xml")
public class UserTest {
    @Autowired
    DayService dayService;
    @Autowired
    UserMapper userMapper;
    @Autowired
    PhotoService photoService;
    @Autowired
    MarkService markService;
    @Test public void testSave(){
        User user=new User();
        user.setName("yy2");
        user.setPassword("112");
        if (dayService.registerUser(user)){
            System.out.println("y");
        }
    }
    @Test public void testDel(){
        if (dayService.delUser("27")){
            System.out.println("y");
        }
    }
    @Test public void testS(){
        if (dayService.searchName("小白")){
            System.out.println(dayService.searchName2("小白"));
        }
    }
    @Test public void testA(){
        if (dayService.searchAll("yyy","111111")){
            System.out.println("ok");
        }
        else System.out.println("N");
    }
    @Test public void  testb(){
        System.out.println(photoService.updatePhoto("wz","15"));
    }
    @Test public void  testc(){
        List<Photo>photos=photoService.getPhotos("小白");
        for (Photo photo:photos){
            System.out.println(photo.getTitle());
        }
    }
    @Test public void  testd(){
        Photo photo=photoService.getPhotobyId("2");
            System.out.println(photo.getUid());
    }
    @Test public void  teste(){
        List<Mark> marks=markService.getMarks("10");
        for (Mark mark:marks){
            System.out.println(mark.getId());
        }

    }
    @Test public void  testf(){
        if (markService.updateZan(2,2))
        System.out.println("ok");
    }
    @Test public void  testj(){
        if (dayService.updatej("暂时没","小白"))
            System.out.println("ok");
    }
    @Test public void  testu(){
        if (dayService.delUser("27"))
            System.out.println("ok");
    }
    @Test public void  testo(){
            System.out.println( dayService.searchName2("小白").getPhoto());
    }
    @Test public void  tests(){
        System.out.println( photoService.search("照片").size());
    }
}
