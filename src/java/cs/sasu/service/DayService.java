package cs.sasu.service;

import cs.sasu.pojo.User;

import java.util.List;

public interface DayService {
    boolean registerUser(User user);
    boolean delUser(String id);
    boolean searchName(String name);
    boolean searchAll(String name,String password);
    boolean updatep(String photo,String name);
    boolean updatej(String jj,String name);
    User searchName2(String name);
    List<User> list();
    boolean updatenp(String id,String name,String password);
    User selectById(String id);
}
