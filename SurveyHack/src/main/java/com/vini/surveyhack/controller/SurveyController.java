package com.vini.surveyhack.controller;


import com.vini.surveyhack.modal.Survey;
import com.vini.surveyhack.service.SurveyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/surveys")
public class SurveyController {

    @Autowired
    private SurveyService surveyService;

    @Autowired
    private SimpMessagingTemplate messagingTemplate;

    @GetMapping
    public List<Survey> getAllSurveys() {
        return surveyService.getAllSurveys();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Survey> getSurveyById(@PathVariable Long id) {
        Survey survey = surveyService.getSurveyById(id);

        if (survey != null) {
            return ResponseEntity.ok(survey);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @PostMapping
    public Survey createSurvey(@RequestBody Survey survey) {
        Survey createdSurvey = surveyService.createSurvey(survey);
        messagingTemplate.convertAndSend("/topic/surveys", createdSurvey);
        return createdSurvey;
    }

    @PutMapping("/{id}")
    public Survey updateSurvey(@PathVariable Long id, @RequestBody Survey surveyDetails) {
        Survey updatedSurvey = surveyService.updateSurvey(id, surveyDetails);
        messagingTemplate.convertAndSend("/topic/surveys", updatedSurvey);
        return updatedSurvey;
    }

    @DeleteMapping("/{id}")
    public void deleteSurvey(@PathVariable Long id) {
        surveyService.deleteSurvey(id);
        messagingTemplate.convertAndSend("/topic/surveys", "Survey with ID " + id + " deleted");
    }
}

