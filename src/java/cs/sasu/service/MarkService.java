package cs.sasu.service;

import cs.sasu.pojo.Mark;

import java.util.List;

public interface MarkService {
    boolean saveMark(Mark mark);
    List<Mark> getMarks(String pid);
    boolean updateZan(int zan,int id);
}
