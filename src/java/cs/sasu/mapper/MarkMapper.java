package cs.sasu.mapper;

import cs.sasu.pojo.Mark;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface MarkMapper {
    int saveRemark(Mark mark);
    List<Mark> getRemark(String pid);
    int updateZan(@Param("zan") int zan,@Param("id") int id);
}
