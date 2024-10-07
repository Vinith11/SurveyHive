package com.vini.surveyhack.controller;

import com.vini.surveyhack.modal.SurveyResponse;
import com.vini.surveyhack.service.AnalyticsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.http.MediaType;


import java.io.IOException;
import java.util.List;

@RestController
@RequestMapping("/api/analytics")
public class AnalyticsController {

    @Autowired
    private AnalyticsService analyticsService;

    @GetMapping(value = "/chart", produces = MediaType.IMAGE_PNG_VALUE)
    public ResponseEntity<byte[]> getSurveyResponsesChart() {
        byte[] chartImage = analyticsService.generateSurveyResponsesChart();
        if (chartImage.length == 0) {
            return ResponseEntity.noContent().build();
        }
        return ResponseEntity.ok().contentType(MediaType.IMAGE_PNG).body(chartImage);
    }

    @GetMapping("/summary")
    public List<SurveyResponse> getSurveySummary() {
        return analyticsService.getSurveySummary();
    }
}
