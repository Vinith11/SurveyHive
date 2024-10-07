package com.vini.surveyhack.controller;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;

@Controller
public class WebSocketController {

    @MessageMapping("/message")
    @SendTo("/topic/surveys")
    public String sendMessage(String message) {
        return message;
    }
}
