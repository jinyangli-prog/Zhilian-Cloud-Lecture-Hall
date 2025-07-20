package cs.sasu.controller;

import cs.sasu.Captcha;
import cs.sasu.pojo.Mark;
import cs.sasu.pojo.Photo;
import cs.sasu.pojo.User;
import cs.sasu.service.DayService;
import cs.sasu.service.MarkService;
import cs.sasu.service.PhotoService;
import net.sf.json.JSONObject;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.imageio.ImageIO;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;


@Controller
@MultipartConfig
public class DayController {
    @Autowired
    private DayService dayService;
    @Autowired
    private PhotoService photoService;
    @Autowired
    private MarkService markService;
    @RequestMapping("/captcha")
    public void generateCaptcha(HttpServletRequest request, HttpServletResponse response) {
        response.setContentType("image/png");  // 设置响应内容类型为PNG图片
        try {
            // 生成验证码
            Captcha captcha = new Captcha();
            String captchaCode = captcha.generateCaptchaCode();

            // 将验证码存储在session中，用于后续验证
            HttpSession session = request.getSession();
            session.setAttribute("captchaCode", captchaCode);

            // 生成验证码图片
            BufferedImage captchaImage = captcha.generateCaptchaImage(captchaCode);

            // 将图片写入输出流
            ImageIO.write(captchaImage, "PNG", response.getOutputStream());
            response.getOutputStream().flush();  // 确保图片被正确输出到浏览器

        } catch (IOException e) {
            e.printStackTrace(); // 打印错误信息
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // 返回500服务器错误
        }
    }

    @RequestMapping("register")
    public String Register(){
        return "register";
    }
    @RequestMapping(value = "register", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String Register2(@Param("name") String name, @Param("password") String password) {
        User user = new User();
        user.setName(name);
        user.setPassword(password);
        boolean isRegistered=false;
        JSONObject result = new JSONObject();
        if (name!=null&&name!=""&&password!=null&&password!="")
            if (!dayService.searchName(name))
            isRegistered = dayService.registerUser(user);
            else result.put("message", "用户名已存在");
            result.put("success", isRegistered);
        return result.toString();
    }
    @RequestMapping(value = "login", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String Login(@Param("name") String name, @Param("password") String password,@Param("captcha")String captcha,HttpServletRequest request) {
        JSONObject result = new JSONObject();
        HttpSession session = request.getSession();
        String sessionCaptcha = (String) session.getAttribute("captchaCode");
        if (sessionCaptcha != null && sessionCaptcha.equalsIgnoreCase(captcha)) {
            User user = new User();
            user.setName(name);
            user.setPassword(password);
            boolean login=false;
            boolean houtai=false;
            if (name!=null&&name!=""&&password!=null&&password!="")
                login = dayService.searchAll(name,password);
            if (!login)
                result.put("message", "账号或密码不正确");
            if ("dbmaster".equals(name) && "dbmaster".equals(password))
                houtai=true;
            result.put("success", login);
            result.put("name",name);
            result.put("houtai",houtai);
        } else {
            result.put("success",false);
            result.put("message","验证码错误");
        }
        return result.toString();
    }
    @RequestMapping("shouye")
    public String shouye(HttpServletRequest req,@Param("name") String name){
        List<Photo> photos = photoService.list();
        String[] arr = new String[photos.size()];
        for (int i = 0; i < photos.size(); i++) {
            arr[i] = photos.get(i).getTitle();
        }
        req.setAttribute("arr", arr);
        req.setAttribute("name",name);
        req.setAttribute("wzChecked",photoService.getPhotosByCheck("wz"));
        req.setAttribute("photos",photoService.getPhotosByCheck("lun"));
        req.setAttribute("photoChecked",photoService.getPhotosByCheck("yes"));
        return "shouye";
    }
    @RequestMapping(value="savePhoto",method = RequestMethod.GET)
    public String form3(HttpServletRequest req,@Param("name") String name){
        req.setAttribute("name",name);
        return "three";
    }
    @RequestMapping(value="savePhoto",method = RequestMethod.POST)
    public String threeSave(@Param("photo") String photo,@Param("uid") String uid,@Param("wz") String wz,@Param("title") String title,
                            @Param("clazz") String clazz, HttpServletRequest req){
        Photo photo2=new Photo();
        photo2.setUid(uid);
        photo2.setUphoto(photo);
        photo2.setWz(wz);
        photo2.setTitle(title);
        photo2.setClazz(clazz);
       if (photoService.savePhoto(photo2)) {
           List<Photo> photos = photoService.list();
           String[] arr = new String[photos.size()];
           for (int i = 0; i < photos.size(); i++) {
               arr[i] = photos.get(i).getTitle();
           }
           req.setAttribute("arr", arr);
           req.setAttribute("name",uid);
           req.setAttribute("photos",photoService.getPhotosByCheck("lun"));
           req.setAttribute("wzChecked",photoService.getPhotosByCheck("wz"));
           req.setAttribute("photoChecked",photoService.getPhotosByCheck("yes"));
           return "shouye";
       }
       else return "fail";
    }
    @RequestMapping("getPhotos")
    public String getPhotos(@Param("id") String id,HttpServletRequest req){
        List<Photo> photos=photoService.getPhotos(id);
        req.setAttribute("photos",photos);
        return "three-photo";
    }
    @RequestMapping("getPhotos2")
    public String getPhotos2(@Param("id") String id,HttpServletRequest req){
        req.setAttribute("photos",photoService.getPhotos(id));
        return "three-photo";
    }
    @RequestMapping(value = "talk",method = RequestMethod.GET)
    public String talk(@Param("id") String id,@Param("name") String name,HttpServletRequest req){
        req.setAttribute("photo",photoService.getPhotobyId(id));
        req.setAttribute("name",name);
        List<User> users=new ArrayList<>();
        List<Mark> marks=markService.getMarks(id);
        List<String> photos=new ArrayList<>();
        for (Mark mark:marks)
            users.add(dayService.searchName2(mark.getUname()));
        for (User user:users)
          photos.add( user.getPhoto());
        req.setAttribute("photosu",photos);
        req.setAttribute("remarks",marks);
        return "tell";
    }
    @RequestMapping(value = "talk", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String talk2(@Param("pid") String pid, @Param("uname") String uname,@Param("remark") String remark) {
        Mark mark=new Mark();
        mark.setPid(pid);
        mark.setUname(uname);
        mark.setRemark(remark);
        mark.setZan(0);
        boolean remark2=false;
        JSONObject result = new JSONObject();
        if (pid!=null&&pid!=""&&remark!=null&&remark!="")
            remark2 = markService.saveMark(mark);
        if (!remark2)
            result.put("message", "评论不为空");
        result.put("success", remark2);
        return result.toString();
    }
    @RequestMapping("jd")
    public String jd2(@Param("category") String category,@Param("name") String name,HttpServletRequest request){
        List<String> categories = Arrays.asList("技术问题", "人文社科", "数学问题", "科学问题");
        if (category == null || category.equals(""))
            category="科学问题";
        List<Photo> wzChecked = photoService.getPhotosByClazz(category,"jj");
        request.setAttribute("categories", categories);
        request.setAttribute("wzChecked", wzChecked);
        request.setAttribute("name", name);
        return "jd";
    }
    @RequestMapping( value = "jd2",method = RequestMethod.GET)
    public String jd3(@Param("name") String name,HttpServletRequest request){
        List<String> categories = Arrays.asList("技术问题", "人文社科", "数学问题", "科学问题");
        String category="科学问题";
        List<Photo> wzChecked = photoService.getPhotosByClazz(category,"jj");
        request.setAttribute("categories", categories);
        request.setAttribute("wzChecked", wzChecked);
        request.setAttribute("name", name);
        return "jd";
    }
    @RequestMapping("jj")
    public String jj(@Param("category") String category,@Param("name") String name,HttpServletRequest request){
        List<String> categories = Arrays.asList("技术问题", "人文社科", "数学问题", "科学问题");
        if (category == null || category.equals(""))
            category="科学问题";
        List<Photo> wzChecked = photoService.getPhotosByClazz(category,"jd");
        request.setAttribute("categories", categories);
        request.setAttribute("wzChecked", wzChecked);
        request.setAttribute("name", name);
        return "jj";
    }
    @RequestMapping( value = "jj2",method = RequestMethod.GET)
    public String jj3(@Param("name") String name,HttpServletRequest request){
        List<String> categories = Arrays.asList("技术问题", "人文社科", "数学问题", "科学问题");
        String category="科学问题";
        List<Photo> wzChecked = photoService.getPhotosByClazz(category,"jd");
        request.setAttribute("categories", categories);
        request.setAttribute("wzChecked", wzChecked);
        request.setAttribute("name", name);
        return "jj";
    }
    @RequestMapping("person")
    public String personal(@Param("name") String name,HttpServletRequest request){
        request.setAttribute("user", dayService.searchName2(name));
        request.setAttribute("photos",photoService.getPhotos(name));
        return "personal";
    }
    @RequestMapping(value="saveUserPhoto",method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String threeSave2(@Param("photo") String photo,@Param("name") String name) {
        boolean add = false;
        JSONObject result = new JSONObject();
        add = dayService.updatep(photo,name);
        if (!add)
            result.put("message", name);
        result.put("success", add);
        return result.toString();
    }
    @RequestMapping(value="saveUserJj",method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String jj(@Param("jj") String jj,@Param("name") String name) {
        System.out.println(name);
        System.out.println(jj);
        boolean add = false;
        JSONObject result = new JSONObject();
        add = dayService.updatej(jj,name);
        if (!add)
            result.put("message", name);
        result.put("success", jj);
        return result.toString();
    }
    @RequestMapping(value="Zan",method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String doLike(@Param("id") int id,@Param("count") int count ) {
        JSONObject jsonObject=new JSONObject();
        if (markService.updateZan(count,id))
            jsonObject.put("success",true);
        return jsonObject.toString();
    }
    @RequestMapping("houtai")
    public String houtai(){ return "houtai"; }
    public static void quickSort(int[] arr, String[] categories, int low, int high) {
        if (low < high) {
            int pivotIndex = partition(arr, categories, low, high);
            quickSort(arr, categories, low, pivotIndex - 1);
            quickSort(arr, categories, pivotIndex + 1, high);
        }
    }
    public static int partition(int[] arr, String[] categories, int low, int high) {
        int pivot = arr[high];
        int i = low - 1;
        for (int j = low; j < high; j++) {
            if (arr[j] < pivot) {
                i++;
                int temp = arr[i];
                arr[i] = arr[j];
                arr[j] = temp;
                String tempCategory = categories[i];
                categories[i] = categories[j];
                categories[j] = tempCategory;
            }
        }
        int temp = arr[i + 1];
        arr[i + 1] = arr[high];
        arr[high] = temp;
        String tempCategory = categories[i + 1];
        categories[i + 1] = categories[high];
        categories[high] = tempCategory;
        return i + 1;
    }
    @RequestMapping("table")
    public String table(HttpServletRequest req){
        int js=photoService.getPhotosByClazz2("技术问题").size();
        int rw=photoService.getPhotosByClazz2("人文社科问题").size();
        int sx=photoService.getPhotosByClazz2("数学问题").size();
        int kx=photoService.getPhotosByClazz2("科学问题").size();
        int[] values = {js, rw, sx, kx};
        String[] categories = {"技术问题", "人文社科问题", "数学问题", "科学问题"};
        quickSort(values, categories, 0, values.length - 1);
        int total = js + rw + sx + kx;
        double[] percentages = new double[values.length];
        for (int i = 0; i < values.length; i++) {
            percentages[i] = (values[i] / (double) total) * 100;
        }
        req.setAttribute("values",values);
        req.setAttribute("categories",categories);
        req.setAttribute("percentages",percentages);
        req.setAttribute("ucount",dayService.list().size());
        req.setAttribute("zcount",photoService.list().size());
        return "table";
    }
    @RequestMapping("ulist")
    public String  ulist(HttpServletRequest req){
       req.setAttribute("users",dayService.list());
       return "ulist";
    }
    @RequestMapping("updatenp")
    public String update(String id,HttpServletRequest req){
        req.setAttribute("user",dayService.selectById(id));
        return "update";
    }
    @RequestMapping(value = "updatenp2",method = RequestMethod.POST,produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String update2(User user){
        JSONObject result=new JSONObject();
        if (dayService.updatenp(user.getId(),user.getName(),user.getPassword()))
        result.put("success",true);
        else result.put("success",false);
        return result.toString();
    }
    @RequestMapping(value = "delete2",method = RequestMethod.POST,produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String delete2(String id){
        JSONObject result=new JSONObject();
        if (dayService.delUser(id))
            result.put("success",true);
        else result.put("success",false);
        return result.toString();
    }
    @RequestMapping("zlist")
    public String  zlist(HttpServletRequest req){
        req.setAttribute("photos",photoService.list());
        return "zlist";
    }
    @RequestMapping("updatez")
    public String updatez(String id,HttpServletRequest req){
        req.setAttribute("photo",photoService.getPhotobyId(id));
        return "updatez";
    }
    @RequestMapping(value = "updatez2",method = RequestMethod.POST,produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String updatez2(Photo photo){
        JSONObject result=new JSONObject();
        if (photoService.updatePhoto(photo.getChecked(),photo.getId()))
            result.put("success",true);
        else result.put("success",false);
        return result.toString();
    }
    @RequestMapping(value = "deletez2",method = RequestMethod.POST,produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String deletez2(String id){
        JSONObject result=new JSONObject();
        if (photoService.delete(id))
            result.put("success",true);
        else result.put("success",false);
        return result.toString();
    }
    @RequestMapping(value = "zm",method = RequestMethod.GET)
    public String zm(@Param("name") String name,HttpServletRequest request){
        request.setAttribute("user", dayService.searchName2(name));
        return "zm";
    }
    @RequestMapping(value = "zm",method = RequestMethod.POST,produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String zm2(User user){
        JSONObject result=new JSONObject();
        if (dayService.updatenp(user.getId(),user.getName(),user.getPassword()))
            result.put("success",true);
        else result.put("success",false);
        return result.toString();
    }
    @RequestMapping("ad")
    public String ad(HttpServletRequest req,@Param("name") String name){
        req.setAttribute("name",name);
        return "addwork";
    }
    @RequestMapping(value="ad",method = RequestMethod.POST,produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String ad2(@Param("uid") String uid,@Param("content") String content,@Param("title") String title,
                            @Param("clazz") String clazz, HttpServletRequest req){
        Photo photo2=new Photo();
        photo2.setUid(uid);
        photo2.setWz(content);
        photo2.setTitle(title);
        photo2.setClazz(clazz);
        System.out.println("内容："+content);
        JSONObject jsonObject=new JSONObject();
        if (photoService.savePhoto(photo2)) {
           jsonObject.put("success",true);
        }
        else  jsonObject.put("success",false);
        return jsonObject.toString();
    }
    @RequestMapping(value = "talk3",method = RequestMethod.GET)
    public String talk3(@Param("id") String id,@Param("name") String name,HttpServletRequest req){
        req.setAttribute("photo",photoService.getPhotobyId(id));
        req.setAttribute("name",name);
        List<User> users=new ArrayList<>();
        List<Mark> marks=markService.getMarks(id);
        List<String> photos=new ArrayList<>();
        for (Mark mark:marks)
            users.add(dayService.searchName2(mark.getUname()));
        for (User user:users)
            photos.add( user.getPhoto());
        req.setAttribute("photosu",photos);
        req.setAttribute("remarks",marks);
        return "tell2";
    }
    @RequestMapping(value = "talk3", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String talk3(@Param("pid") String pid, @Param("uname") String uname,@Param("remark") String remark) {
        Mark mark=new Mark();
        mark.setPid(pid);
        mark.setUname(uname);
        mark.setRemark(remark);
        mark.setZan(0);
        boolean remark2=false;
        JSONObject result = new JSONObject();
        if (pid!=null&&pid!=""&&remark!=null&&remark!="")
            remark2 = markService.saveMark(mark);
        if (!remark2)
            result.put("message", "评论不为空");
        result.put("success", remark2);
        return result.toString();
    }
    @RequestMapping("search")
    public String search(HttpServletRequest req) {
        List<Photo> photos = photoService.list();
        String[] arr = new String[photos.size()];
        for (int i = 0; i < photos.size(); i++) {
            arr[i] = photos.get(i).getTitle();
        }
        req.setAttribute("arr", arr);
        return "search";
    }
    @RequestMapping(value = "search2",method = RequestMethod.POST)
    public String search2(@Param("search")String search,@Param("name") String name, HttpServletRequest request) {
        List<Photo> wzChecked = photoService.search(search);
        request.setAttribute("categories", "科学问题");
        request.setAttribute("wzChecked", wzChecked);
        request.setAttribute("name", name);
        return "jj";
    }
}
