package com.snapbasket.backend;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class BackendController {
    
    @RequestMapping("/hello")
    public String Hello() {
        return "Hello, World!";
    }
}
