package cs.sasu.service;

import cs.sasu.mapper.MarkMapper;
import cs.sasu.pojo.Mark;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class MarkImpl implements MarkService{
    @Autowired
    MarkMapper markMapper;
    @Override
    public boolean saveMark(Mark mark) {
        return markMapper.saveRemark(mark)>0;
    }

    @Override
    public List<Mark> getMarks(String pid) {
        return markMapper.getRemark(pid);
    }

    @Override
    public boolean updateZan(int zan, int id) {
        return markMapper.updateZan(zan,id)>0;
    }
}
