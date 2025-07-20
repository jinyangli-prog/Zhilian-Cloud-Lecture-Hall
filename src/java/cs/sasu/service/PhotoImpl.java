package cs.sasu.service;

import cs.sasu.mapper.PhotoMapper;
import cs.sasu.pojo.Photo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class PhotoImpl implements PhotoService {
    @Autowired
    PhotoMapper photoMapper;
    @Override
    public boolean savePhoto(Photo photo) {
        return photoMapper.savePhoto(photo)>0;
    }

    @Override
    public List<Photo> getPhotos(String uid) {
        List<Photo> photos=new ArrayList<>();
        photos=photoMapper.getPhoto(uid);
        return photos;
    }

    @Override
    public List<Photo> getPhotosByCheck(String check) {
        List<Photo> photos=new ArrayList<>();
        photos=photoMapper.getPhoto2(check);
        return photos;
    }

    @Override
    public boolean updatePhoto(String check, String id) {
        return photoMapper.setChecked(id,check)>0;
    }

    @Override
    public Photo getPhotobyId(String id) {
        return photoMapper.getPhotobyId(id);
    }

    @Override
    public List<Photo> getPhotosByClazz(String clazz,String checked) {
        return photoMapper.getPhotoByClazz(clazz,checked);
    }
    @Override
    public List<Photo> getPhotosByClazz2(String clazz) {
        return photoMapper.getPhotoByClazz2(clazz);
    }

    @Override
    public List<Photo> list() {
        return photoMapper.list();
    }

    @Override
    public boolean delete(String id) {
        return photoMapper.delete(id)>0;
    }

    @Override
    public List<Photo> search(String title) {
        return photoMapper.search(title);
    }
}
