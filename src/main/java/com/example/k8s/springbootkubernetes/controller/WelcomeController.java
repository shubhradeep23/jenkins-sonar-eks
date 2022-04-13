package com.example.k8s.springbootkubernetes.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class WelcomeController {
	
	@RequestMapping("/greeting")
	public String greeting() {
		return "Deploy Java App to AWS EKS by Shubhradeep Ghosh";
	}

}
