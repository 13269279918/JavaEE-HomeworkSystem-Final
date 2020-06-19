package com.homework.controller;

import com.homework.model.User;
import com.homework.service.StudentHomeworkService;
import com.homework.service.TeacherHomeworkService;
import com.homework.service.UserService;
import org.apache.log4j.Logger;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;

/**
 * @author 郭佳华 17301093
 */
@RequestMapping("/user")
@Controller
public class UserController {

    final
    StudentHomeworkService studentHomeworkService;
    final
    TeacherHomeworkService teacherHomeworkService;
    final
    UserService userService;

    public UserController(StudentHomeworkService studentHomeworkService, TeacherHomeworkService teacherHomeworkService, UserService userService) {
        this.studentHomeworkService = studentHomeworkService;
        this.teacherHomeworkService = teacherHomeworkService;
        this.userService = userService;
    }

    private static Logger logger = Logger.getLogger(UserController.class);

    @RequestMapping("testTime")
    public void time(){
        Date date = new Date();
        logger.debug(date);
    }

    @RequestMapping("home")
    public String start(){
        return "Login";
    }

    @RequestMapping("login")
    public void login(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        logger.debug("接收到登录请求");

        String userName = req.getParameter("ID");
        logger.debug("接收到的user-name:"+userName);

        String password = req.getParameter("Password");
        logger.debug("接收到的password:"+password);

        String loginResult = userService.login(userName, password);
        logger.debug("登录结果:"+loginResult);

        resp.getWriter().write(loginResult);
    }

    @RequestMapping("register")
    public String register_dispatcher(){

        return "Register";
    }

    @RequestMapping("register_submit")
    public void register(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        logger.debug("访问接口 ： register_submit");

        String userName = req.getParameter("userName");
        String password = req.getParameter("password");
        String role = req.getParameter("role");

        logger.debug("接收到参数 userName ："+userName);
        logger.debug("接收到参数 password ："+password);
        logger.debug("接收到参数 role ："+role);

        User check = userService.checkExist(userName);
        if(check == null){
            ApplicationContext ctx = new AnnotationConfigApplicationContext(User.class);
            User user = (User) ctx.getBean(User.class);
            user.setUserName(userName);
            user.setPassword(password);
            user.setRole(role);

            userService.insert(user);
            resp.getWriter().write("success");
        }else{
            resp.getWriter().write("exist");
        }

    }

}
