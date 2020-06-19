package com.homework.mapper;

import com.homework.model.StudentHomework;
import com.homework.model.StudentHomeworkKey;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface StudentHomeworkMapper extends JpaRepository<StudentHomework, StudentHomeworkKey> {
    //List<StudentHomework> findAllByHomeworkId(Long homeworkId);
    //List<StudentHomework> findAllByStudentName(String studentId);
    List<StudentHomework> findAllByKey_HomeworkId(Long homeworkId);
    List<StudentHomework> findAllByKey_StudentName(String studentName);
}
