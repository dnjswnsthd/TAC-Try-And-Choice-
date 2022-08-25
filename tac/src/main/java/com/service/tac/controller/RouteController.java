package com.service.tac.controller;

import java.sql.SQLException;
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.service.tac.model.service.CardService;
import com.service.tac.model.service.CategoryService;
import com.service.tac.model.vo.Card;
import com.service.tac.model.vo.LargeCategory;

@Controller
public class RouteController {
	
	@Autowired
	CardService cardService;
	
	@Autowired
	CategoryService categoryService;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String intro() {
		return "intro";
	}

	@GetMapping(value = "/main")
	public String main(Model model) {
		try {
			ArrayList <Card> list = cardService.getAllCardInfo();
			model.addAttribute("list", list);
			return "/main/main";
		} catch (SQLException e) {
			System.out.println(e.getMessage());
			return "/error";
		}
	}

	@GetMapping(value = "/signup")
	public String signup(Model model) {
		return "/member/signup";
	}
	
	@GetMapping(value= "/inputConsume")
	public String inputConsume(Model model) {
		ArrayList<LargeCategory> list;
		try {
			list = categoryService.getAllLargeCategory();
			model.addAttribute("list", list);
			return "/member/signupConsume";
		} catch (SQLException e) {
			System.out.println(e.getMessage());
			return "/error";
		}
		
	}
	
	@GetMapping(value= "/error")
	public String error() {
		return "/error";
	}

}
