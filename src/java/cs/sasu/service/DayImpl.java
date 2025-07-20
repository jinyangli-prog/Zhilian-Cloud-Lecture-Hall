package cs.sasu.service;

import cs.sasu.mapper.UserMapper;
import cs.sasu.pojo.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DayImpl implements DayService {
    @Autowired
    UserMapper userMapper;
    @Override
    public boolean registerUser(User user) {
       return userMapper.save(user)>0;
    }

    @Override
    public boolean delUser(String id) {
        return userMapper.del(id)>0;
    }

    @Override
    public boolean searchName(String name) {
        if (userMapper.searchName(name)!=null&&userMapper.searchName(name).toString()!="[]")
            return true;
        return false;
    }

    @Override
    public boolean searchAll(String name, String password) {
        if (userMapper.searchAll(name,password)!=null&&userMapper.searchAll(name,password).toString()!="[]")
            return true;
        return false;
    }

    @Override
    public boolean updatep(String photo, String name) {
        return userMapper.updatep(photo,name)>0;
    }

    @Override
    public boolean updatej(String jj, String name) {
        return userMapper.updatej(jj, name)>0;
    }

    @Override
    public User searchName2(String name) {
        return userMapper.searchName2(name);
    }

    @Override
    public List<User> list() {
        return userMapper.list();
    }

    @Override
    public boolean updatenp(String id, String name, String password) {
        return userMapper.updatenp(id, name, password)>0;
    }

    @Override
    public User selectById(String id) {
        return userMapper.selectById(id);
    }
}
