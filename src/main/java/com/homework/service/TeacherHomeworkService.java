package com.homework.service;

import com.homework.mapper.StudentHomeworkMapper;
import com.homework.mapper.TeacherHomeworkMapper;
import com.homework.model.TeacherHomework;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class TeacherHomeworkService {
    @Autowired
    TeacherHomeworkMapper teacherHomeworkMapper;
    @Autowired
    StudentHomeworkMapper studentHomeworkMapper;


    public List<TeacherHomework> findAll(){
        return teacherHomeworkMapper.findAll();
    }



    public void insert(TeacherHomework teacherHomework){
        teacherHomeworkMapper.save(teacherHomework);
    }

    public TeacherHomework findById(Long id){
        return teacherHomeworkMapper.findById(id).get();
    }
}
