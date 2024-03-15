/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ada.web.service;

import com.ada.common.PagingResult;
import com.ada.model.User;

import com.ada.web.dao.UserDAO;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


/**
 *
 * @author admin
 */
@Controller
public class Test{
@Autowired
UserDAO useService;   
@RequestMapping("/testlist")
    public void test(){
        long userId=1L;
        User u=new User();
        PagingResult page = new PagingResult();
        page.setPageNumber(1);
        page.setNumberPerPage(10);
        page = useService.getAll(User.class, page).orElse(new PagingResult());
        
        
}
    @RequestMapping("/testadd")
    public void add(){
        User u=new User();
        u.setFullName("thientest");
        u.setUsername("Thientest");
        u.setPassword("12321321321");
        u.setGenDate(new Date());
        u.setDescription("Abcxyz");
        u.setStatus(1);
        useService.save(u);
    
    }
    @RequestMapping("/findtest")
    public void findTest(){
        User u=new User();
    u=useService.findById(User.class,1);
    }
      @RequestMapping("/removetest")
    public void removeTest(){
    useService.remove(User.class,31);
    }
    @RequestMapping("/updatetest")
    public void updateTest(){
        User u=new User();
        u=useService.findById(User.class,32);
        u.setFullName("updatetest");
        useService.update(u);
    }
    @RequestMapping("/changeStatus")
     public void changeTest(){
        User u=new User();
        useService.changeStatus(User.class,32,1);
    }
}
