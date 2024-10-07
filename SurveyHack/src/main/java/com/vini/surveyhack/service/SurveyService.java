package com.vini.surveyhack.service;


import com.vini.surveyhack.modal.Survey;
import com.vini.surveyhack.repository.SurveyRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SurveyService {

    @Autowired
    private SurveyRepository surveyRepository;

    public List<Survey> getAllSurveys() {
        return surveyRepository.findAll();
    }

    public Survey getSurveyById(Long id) {
        return surveyRepository.findById(id).orElse(null);
    }

    public Survey createSurvey(Survey survey) {
        return surveyRepository.save(survey);
    }

    public Survey updateSurvey(Long id, Survey surveyDetails) {
        Survey survey = surveyRepository.findById(id).orElse(null);

        if (survey != null) {
            survey.setTitle(surveyDetails.getTitle());
            survey.setQuestions(surveyDetails.getQuestions());
            return surveyRepository.save(survey);
        } else {
            return null;
        }
    }

    public boolean deleteSurvey(Long id) {
        Survey survey = surveyRepository.findById(id).orElse(null);

        if (survey != null) {
            surveyRepository.delete(survey);
            return true;
        } else {
            return false;
        }
    }
}
