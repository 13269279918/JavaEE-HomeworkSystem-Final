package com.homework.mapper;

import com.homework.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserMapper extends JpaRepository<User,String> {

}
