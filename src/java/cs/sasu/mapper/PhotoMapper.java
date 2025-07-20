package cs.sasu.mapper;
import cs.sasu.pojo.Photo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface PhotoMapper {
    int savePhoto(Photo photo);
    List<Photo> getPhoto(String uid);
    int setChecked(@Param("id") String id,@Param("checked") String checked);
    List<Photo> getPhoto2(String checked);
    Photo getPhotobyId(String id);
    List<Photo> getPhotoByClazz(@Param("clazz") String clazz,@Param("checked") String checked);
    List<Photo> getPhotoByClazz2(String clazz);
    List<Photo> list();
    int delete(String id);
    List<Photo> search(String title);
}
