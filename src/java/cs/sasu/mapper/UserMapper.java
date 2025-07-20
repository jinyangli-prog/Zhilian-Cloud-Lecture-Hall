package cs.sasu.mapper;

import cs.sasu.pojo.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserMapper {
    int save(User user);
    int del(String id);
    List<User> searchName(String name);
    List<User> searchAll(@Param("name") String name,@Param("password") String password);
    int updatep(@Param("photo") String photo,@Param("name") String name);
    int updatej(@Param("jj") String jj,@Param("name") String name);
    int updatenp(@Param("id") String id,@Param("name") String name,@Param("password") String password);
    User searchName2(String name);
    List<User> list();
    User selectById(String id);
}
