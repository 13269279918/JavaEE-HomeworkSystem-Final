package com.homework.controller;

import com.homework.model.StudentHomework;
import com.homework.model.StudentHomeworkKey;
import com.homework.model.TeacherHomework;
import com.homework.service.StudentHomeworkService;
import com.homework.service.TeacherHomeworkService;
import com.homework.service.UserService;
import org.apache.log4j.Logger;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@RequestMapping("/student")
@Controller
public class StudentController {
    final
    StudentHomeworkService studentHomeworkService;
    final
    TeacherHomeworkService teacherHomeworkService;

    public StudentController(StudentHomeworkService studentHomeworkService, TeacherHomeworkService teacherHomeworkService, UserService userService) {
        this.studentHomeworkService = studentHomeworkService;
        this.teacherHomeworkService = teacherHomeworkService;
    }

    private static Logger logger = Logger.getLogger(UserController.class);

    @RequestMapping("enter")
    public void enter(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        logger.debug("访问接口：enter");
        String userName = req.getParameter("userName");
        logger.debug("接收到参数 userName ："+userName);
        List<TeacherHomework> list = teacherHomeworkService.findAll();
        req.setAttribute("userName",userName);
        req.setAttribute("list",list);
        req.getRequestDispatcher("../jsp/student1.jsp").forward(req,resp);
    }

    @RequestMapping("checkScore")
    public void checkScore(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        logger.debug("访问接口：checkScore");
        String userName = req.getParameter("userName");
        logger.debug("接收到参数 userName ："+userName);
        List<StudentHomework> list = studentHomeworkService.findByStudentName(userName);
        req.setAttribute("userName",userName);
        req.setAttribute("list",list);
        req.getRequestDispatcher("../jsp/student2.jsp").forward(req,resp);
    }

    @RequestMapping("requirement")
    public void requirement(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        logger.debug("访问接口：requirement");
        Long homeworkId = new Long(req.getParameter("homeworkId"));
        logger.debug("接收到参数："+homeworkId);
        TeacherHomework teacherHomework = teacherHomeworkService.findById(homeworkId);
        logger.debug("作业要求："+teacherHomework.getRequirement());
        resp.setContentType("text/html;charset=UTF-8");
        resp.getWriter().write(teacherHomework.getRequirement());
    }

    @RequestMapping("submit")
    public void submit(HttpServletRequest req, HttpServletResponse resp){
        logger.debug("访问接口：submit");

        String studentName = req.getParameter("studentName");
        String homeworkId = req.getParameter("homeworkId");
        String homeworkTitle = req.getParameter("homeworkTitle");
        String homeworkContent = req.getParameter("homeworkContent");
        String submitDate_string = req.getParameter("submitDate");

        logger.debug("接收到参数 studentName :"+studentName);
        logger.debug("接收到参数 homeworkId :"+homeworkId);
        logger.debug("接收到参数 homeworkTitle :"+ homeworkTitle);
        logger.debug("接收到参数 homeworkContent :"+ homeworkContent);
        logger.debug("接收到参数 submitDate :"+ submitDate_string);

        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date date = null;
        try {
            date = dateFormat.parse(submitDate_string);
        } catch (ParseException e) {
            e.printStackTrace();
        }

        ApplicationContext ctx = new AnnotationConfigApplicationContext(StudentHomework.class);
        StudentHomework sh = (StudentHomework) ctx.getBean(StudentHomework.class);
        StudentHomeworkKey key = new StudentHomeworkKey();
        key.setHomeworkId(new Long(homeworkId));
        key.setStudentName(studentName);
        sh.setKey(key);
        sh.setHomeworkTitle(homeworkTitle);
        sh.setHomeworkContent(homeworkContent);
        sh.setSubmitDate(date);
        sh.setScore(-1);

        studentHomeworkService.insert(sh);
    }
}
