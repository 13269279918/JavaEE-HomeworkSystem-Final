package com.homework.controller;

import com.homework.model.StudentHomework;
import com.homework.model.StudentHomeworkKey;
import com.homework.model.TeacherHomework;
import com.homework.service.StudentHomeworkService;
import com.homework.service.TeacherHomeworkService;
import org.apache.log4j.Logger;
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

@RequestMapping("/teacher")
@Controller
public class TeacherController {
    final
    StudentHomeworkService studentHomeworkService;
    final
    TeacherHomeworkService teacherHomeworkService;

    public TeacherController(StudentHomeworkService studentHomeworkService, TeacherHomeworkService teacherHomeworkService) {
        this.studentHomeworkService = studentHomeworkService;
        this.teacherHomeworkService = teacherHomeworkService;
    }

    private static Logger logger = Logger.getLogger(UserController.class);

    @RequestMapping("testParam")
    public void test(HttpServletRequest req, HttpServletResponse resp){
        String homeworkId = req.getParameter("homeworkId");
        String studentName = req.getParameter("studentName");
        logger.debug("接收到参数 homeworkId ："+homeworkId);
        logger.debug("接收到参数 studentName ："+studentName);
    }

    @RequestMapping("enter")
    public void enter(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        logger.debug("访问接口：enter");
        String userName = req.getParameter("userName");
        logger.debug("接收到参数 userName ："+userName);
        List<TeacherHomework> list = teacherHomeworkService.findAll();
        req.setAttribute("userName",userName);
        req.setAttribute("list",list);
        req.getRequestDispatcher("../jsp/teacher1.jsp").forward(req,resp);
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

    @RequestMapping("content")
    public void content(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        logger.debug("访问接口：content");
        Long homeworkId = new Long(req.getParameter("homeworkId"));
        String studentName = req.getParameter("studentName");
        logger.debug("接收到参数 homeworkId ："+homeworkId);
        logger.debug("接收到参数 studentName ："+studentName);
        StudentHomeworkKey key = new StudentHomeworkKey(homeworkId,studentName);
        StudentHomework studentHomework = studentHomeworkService.findByKey(key);
        logger.debug("作业内容："+studentHomework.getHomeworkContent());
        resp.setContentType("text/html;charset=UTF-8");
        resp.getWriter().write(studentHomework.getHomeworkContent());
    }

    @RequestMapping("check")
    public void check(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        logger.debug("访问接口：check");
        Long homeworkId = new Long(req.getParameter("homeworkId"));
        String userName = req.getParameter("studentName");
        logger.debug("接收到参数 homeworkId ："+homeworkId);
        logger.debug("接收到参数 userName ："+userName);
        List<StudentHomework> list = studentHomeworkService.findByHomeworkId(homeworkId);
        req.setAttribute("list",list);
        req.setAttribute("userName",userName);
        req.getRequestDispatcher("../jsp/teacher2.jsp").forward(req,resp);
    }

    @RequestMapping("start_publish")
    public void publish_start(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        logger.debug("访问接口：start_publish");
        String userName = req.getParameter("userName");
        logger.debug("接到参数 userName ："+userName);
        req.setAttribute("userName",userName);
        req.getRequestDispatcher("../jsp/teacher3.jsp").forward(req,resp);
    }

    @RequestMapping("publish")
    public void publish(HttpServletRequest req, HttpServletResponse resp){
        logger.debug("访问接口：publish");
        String teacherName = req.getParameter("teacherName");
        String title = req.getParameter("title");
        String requirement = req.getParameter("requirement");
        String publishDate_string = req.getParameter("publishDate");
        String deadline_string = req.getParameter("deadline");

        logger.debug("接收到参数 teacherName ："+teacherName);
        logger.debug("接收到参数 title ："+title);
        logger.debug("接收到参数 requirement ："+requirement);
        logger.debug("接收到参数 publishDate ："+publishDate_string);
        logger.debug("接收到参数 deadline ："+deadline_string);

        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date publishDate = null;
        Date deadline = null;
        try {
            publishDate = dateFormat.parse(publishDate_string);
            deadline = dateFormat.parse(deadline_string);
        } catch (ParseException e) {
            e.printStackTrace();
        }

        TeacherHomework th = new TeacherHomework();
        th.setTeacherName(teacherName);
        th.setHomeworkTitle(title);
        th.setRequirement(requirement);
        th.setPublishDate(publishDate);
        th.setDeadline(deadline);

        teacherHomeworkService.insert(th);
    }

    @RequestMapping("score")
    public void score(HttpServletRequest req, HttpServletResponse resp){
        logger.debug("访问接口 ：score");
        Long homeworkId = new Long(req.getParameter("homeworkId"));
        String studentName = req.getParameter("studentName");
        Integer score = new Integer(req.getParameter("score"));
        String comment = req.getParameter("comment");

        logger.debug("收到参数 homeworkId ："+homeworkId);
        logger.debug("收到参数 studentName ："+studentName);
        logger.debug("收到参数 score ："+score);
        logger.debug("收到参数 comment ："+comment);

        studentHomeworkService.updateScore(studentName,homeworkId,score,comment);
    }

    @RequestMapping("statistic")
    public void statistic(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        logger.debug("访问接口 ： statistic");
        Long homeworkId = new Long(req.getParameter("homeworkId"));
        logger.debug("接收到参数 homeworkId ："+homeworkId);

        int count = studentHomeworkService.countHomework(homeworkId);
        float avg = studentHomeworkService.avg(homeworkId);

        resp.setContentType("text/html;charset=UTF-8");
        resp.getWriter().write("提交人数："+count+"   平均分："+avg);
    }

}
