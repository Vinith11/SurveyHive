package com.vini.surveyhack.service;

import com.vini.surveyhack.modal.SurveyResponse;
import com.vini.surveyhack.repository.SurveyResponseRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.awt.Color;
import java.awt.image.BufferedImage;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import javax.imageio.ImageIO;
import java.io.ByteArrayOutputStream;
import java.io.IOException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.knowm.xchart.PieChart;
import org.knowm.xchart.PieChartBuilder;
import org.knowm.xchart.BitmapEncoder;
import org.knowm.xchart.BitmapEncoder.BitmapFormat;


import javax.imageio.ImageIO;

@Service
public class AnalyticsService {

    private static final Logger logger = LoggerFactory.getLogger(AnalyticsService.class);

    @Autowired
    private SurveyResponseRepository surveyResponseRepository;

    public byte[] generateSurveyResponsesChart() {
        logger.info("Generating survey responses chart");

        List<SurveyResponse> responses = surveyResponseRepository.findAll();

        if (responses.isEmpty()) {
            logger.warn("No survey responses found");
            return new byte[0];
        }

        Map<String, Long> responseCounts = responses.stream()
                .flatMap(response -> response.getResponses().values().stream())
                .collect(Collectors.groupingBy(e -> e, Collectors.counting()));

        PieChart chart = new PieChartBuilder().width(800).height(600).title("Survey Responses").build();

        responseCounts.forEach((response, count) -> {
            logger.info("Adding data to chart: response={} count={}", response, count);
            chart.addSeries(response, count);
        });

        try (ByteArrayOutputStream baos = new ByteArrayOutputStream()) {
            BufferedImage bufferedImage = BitmapEncoder.getBufferedImage(chart);
            ImageIO.write(bufferedImage, "png", baos);
            logger.info("Chart generated successfully");
            return baos.toByteArray();
        } catch (IOException e) {
            logger.error("Error generating chart", e);
            return new byte[0];
        }
    }
    public List<SurveyResponse> getSurveySummary() {
        return surveyResponseRepository.findAll();
    }
}
