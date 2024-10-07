package com.vini.surveyhack.controller;

import com.vini.surveyhack.modal.SurveyResponse;
import com.vini.surveyhack.service.SurveyResponseService;

import jakarta.validation.ConstraintViolationException;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/responses")
public class SurveyResponseController {

    @Autowired
    private SurveyResponseService surveyResponseService;

    @GetMapping
    public List<SurveyResponse> getAllResponses() {
        return surveyResponseService.getAllResponses();
    }

    @GetMapping("/survey/{surveyId}")
    public List<SurveyResponse> getResponsesBySurveyId(@PathVariable Long surveyId) {
        return surveyResponseService.getResponsesBySurveyId(surveyId);
    }

    @GetMapping("/{id}")
    public ResponseEntity<SurveyResponse> getResponseById(@PathVariable Long id) {
        SurveyResponse response = surveyResponseService.getResponseById(id);

        if (response != null) {
            return ResponseEntity.ok(response);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @PostMapping
    public ResponseEntity<?> createSurveyResponse(@Valid @RequestBody SurveyResponse surveyResponse) {
        SurveyResponse createdResponse = surveyResponseService.createSurveyResponse(surveyResponse);
        return ResponseEntity.status(201).body(createdResponse);
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> updateSurveyResponse(@PathVariable Long id, @Valid @RequestBody SurveyResponse surveyResponseDetails) {
        SurveyResponse updatedResponse = surveyResponseService.updateSurveyResponse(id, surveyResponseDetails);
        return ResponseEntity.ok(updatedResponse);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteResponse(@PathVariable Long id) {
        if (surveyResponseService.deleteResponse(id)) {
            return ResponseEntity.noContent().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<Map<String, String>> handleValidationExceptions(MethodArgumentNotValidException ex) {
        Map<String, String> errors = new HashMap<>();
        ex.getBindingResult().getAllErrors().forEach((error) -> {
            String fieldName = ((FieldError) error).getField();
            String errorMessage = error.getDefaultMessage();
            errors.put(fieldName, errorMessage);
        });
        return ResponseEntity.badRequest().body(errors);
    }

    @ExceptionHandler(ConstraintViolationException.class)
    public ResponseEntity<Map<String, String>> handleConstraintViolationExceptions(ConstraintViolationException ex) {
        Map<String, String> errors = new HashMap<>();
        ex.getConstraintViolations().forEach((violation) -> {
            String fieldName = violation.getPropertyPath().toString();
            String errorMessage = violation.getMessage();
            errors.put(fieldName, errorMessage);
        });
        return ResponseEntity.badRequest().body(errors);
    }
}
