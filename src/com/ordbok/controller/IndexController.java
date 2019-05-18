package com.ordbok.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class IndexController {
	@RequestMapping("/{target}")
	public ModelAndView direct(@PathVariable String target,
			HttpServletRequest request,HttpServletResponse response) {
		return new ModelAndView(target);
	}
}
