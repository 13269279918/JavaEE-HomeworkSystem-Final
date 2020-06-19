package com.homework.model;

import lombok.Data;

import javax.persistence.*;
import java.util.Date;

@Data
@Entity
@Table(name="student_homework")
public class StudentHomework{
    @EmbeddedId
    private StudentHomeworkKey key;

    @Column(name = "homework_title")
    private String homeworkTitle;

    @Column(name = "homework_content")
    private String homeworkContent;

    @Column(name = "submit_date")
    private Date submitDate;

    @Column(name = "score")
    private Integer score;

    @Column(name = "comment")
    private String comment;
}
