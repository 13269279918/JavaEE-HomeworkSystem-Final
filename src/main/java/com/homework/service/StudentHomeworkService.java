package com.homework.service;

import com.homework.mapper.StudentHomeworkMapper;
import com.homework.model.StudentHomework;
import com.homework.model.StudentHomeworkKey;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Service;

import javax.persistence.criteria.CriteriaBuilder;
import java.util.List;

@Service
public class StudentHomeworkService {
    @Autowired
    StudentHomeworkMapper studentHomeworkMapper;

    public List<StudentHomework> findAll(){
        return studentHomeworkMapper.findAll();
    }

    public List<StudentHomework> findByHomeworkId(Long homeworkId){
        return studentHomeworkMapper.findAllByKey_HomeworkId(homeworkId);
    }

    public List<StudentHomework> findByStudentName(String studentName){
        return studentHomeworkMapper.findAllByKey_StudentName(studentName);
    }

    public StudentHomework findByKey(StudentHomeworkKey key){
        return studentHomeworkMapper.findById(key).get();
    }

    public void insert(StudentHomework studentHomework){
        studentHomeworkMapper.save(studentHomework);
    }

    public void updateScore(String studentname, Long homeworkId, Integer score, String comment){
        //先去出来，改好再存进去
        StudentHomeworkKey key = new StudentHomeworkKey(homeworkId,studentname);
        StudentHomework studentHomework = studentHomeworkMapper.findById(key).get();
        studentHomework.setScore(score);
        studentHomework.setComment(comment);
        studentHomeworkMapper.save(studentHomework);
    }

    public int countHomework(Long homeworkId){
        List<StudentHomework> list = studentHomeworkMapper.findAllByKey_HomeworkId(homeworkId);
        return list.size();
    }

    public float avg(Long homeworkId){
        List<StudentHomework> list = studentHomeworkMapper.findAllByKey_HomeworkId(homeworkId);
        float sum = 0;
        int count = 0;
        for(StudentHomework sh : list){
            if(sh.getScore()!=-1){
                sum += sh.getScore();
                count ++;
            }
        }
        if(count != 0){
            return sum/count;
        }else{
            return 0;
        }
    }
}
