package com.vini.surveyhack.service;

import com.vini.surveyhack.modal.SurveyResponse;
import com.vini.surveyhack.repository.SurveyResponseRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jakarta.validation.ConstraintViolation;
import jakarta.validation.ConstraintViolationException;
import jakarta.validation.Validator;
import java.util.Set;
import java.util.List;

@Service
public class SurveyResponseService {

    @Autowired
    private SurveyResponseRepository surveyResponseRepository;

    @Autowired
    private Validator validator;

    public List<SurveyResponse> getAllResponses() {
        return surveyResponseRepository.findAll();
    }

    public List<SurveyResponse> getResponsesBySurveyId(Long surveyId) {
        return surveyResponseRepository.findBySurveyId(surveyId);
    }

    public SurveyResponse getResponseById(Long id) {
        return surveyResponseRepository.findById(id).orElse(null);
    }

    public SurveyResponse createResponse(SurveyResponse response) {
        validateSurveyResponse(response);
        return surveyResponseRepository.save(response);
    }

    public SurveyResponse updateResponse(Long id, SurveyResponse responseDetails) {
        validateSurveyResponse(responseDetails);
        SurveyResponse response = surveyResponseRepository.findById(id).orElse(null);

        if (response != null) {
            response.setSurveyId(responseDetails.getSurveyId());
            response.setResponses(responseDetails.getResponses());
            return surveyResponseRepository.save(response);
        } else {
            return null;
        }
    }

    public boolean deleteResponse(Long id) {
        SurveyResponse response = surveyResponseRepository.findById(id).orElse(null);

        if (response != null) {
            surveyResponseRepository.delete(response);
            return true;
        } else {
            return false;
        }
    }

    public SurveyResponse createSurveyResponse(SurveyResponse surveyResponse) {
        validateSurveyResponse(surveyResponse);
        return surveyResponseRepository.save(surveyResponse);
    }

    public SurveyResponse updateSurveyResponse(Long id, SurveyResponse surveyResponseDetails) {
        validateSurveyResponse(surveyResponseDetails);
        SurveyResponse existingResponse = surveyResponseRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Survey response not found"));

        existingResponse.setResponses(surveyResponseDetails.getResponses());
        return surveyResponseRepository.save(existingResponse);
    }

    private void validateSurveyResponse(SurveyResponse surveyResponse) {
        Set<ConstraintViolation<SurveyResponse>> violations = validator.validate(surveyResponse);
        if (!violations.isEmpty()) {
            throw new ConstraintViolationException(violations);
        }
    }
}
