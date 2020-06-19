package com.homework.service;

import com.homework.mapper.UserMapper;
import com.homework.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class UserService {
    @Autowired
    UserMapper userMapper;

    public String login(String userName, String password){
        Optional<User> result = userMapper.findById(userName);
        User user = result.get();
        if(user == null){
            return "wrong";
        }else{
            if(user.getPassword().equals(password)) {
                return user.getRole();
            }else{
                return "wrong";
            }
        }
    }

    public User checkExist(String userName){
        try {
            return userMapper.findById(userName).get();
        }catch (Exception e){
            return null;
        }
    }

    public void insert(User user){
        userMapper.save(user);
    }
}
