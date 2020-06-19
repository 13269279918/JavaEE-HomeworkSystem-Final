package com.homework.model;

import lombok.Data;

import javax.persistence.*;
import java.util.Date;

@Data
@Entity
@Table(name = "teacher_homework")
public class TeacherHomework {
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    @Id
    private Long homeworkId;
    private String teacherName;
    private String homeworkTitle;
    private String requirement;
    private Date publishDate;
    private Date deadline;
}
