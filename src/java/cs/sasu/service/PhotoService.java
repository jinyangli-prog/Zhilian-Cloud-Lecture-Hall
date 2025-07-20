package cs.sasu.service;

import cs.sasu.pojo.Photo;

import java.util.List;

public interface PhotoService {
    boolean savePhoto(Photo photo);
    List<Photo> getPhotos(String uid);
    List<Photo> getPhotosByCheck(String check);
    boolean updatePhoto(String check,String id);
    Photo getPhotobyId(String id);
    List<Photo> getPhotosByClazz(String clazz,String checked);
    List<Photo> getPhotosByClazz2(String clazz);
    List<Photo> list();
    boolean delete(String id);
    List<Photo> search(String title);
}
