package com.vini.surveyhack.modal;


import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

import java.util.Map;

@Entity
public class SurveyResponse {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotNull(message = "Survey ID is required")
    private Long surveyId;

    @ElementCollection
    @CollectionTable(name = "response_data", joinColumns = @JoinColumn(name = "response_id"))
    @MapKeyColumn(name = "question")
    @Column(name = "answer")
    private Map<@NotBlank(message = "Question cannot be blank") String,
            @NotBlank(message = "Answer cannot be blank") String> responses;

    // Constructors, getters, and setters
    public SurveyResponse() {}

    public SurveyResponse(Long surveyId, Map<String, String> responses) {
        this.surveyId = surveyId;
        this.responses = responses;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getSurveyId() {
        return surveyId;
    }

    public void setSurveyId(Long surveyId) {
        this.surveyId = surveyId;
    }

    public Map<String, String> getResponses() {
        return responses;
    }

    public void setResponses(Map<String, String> responses) {
        this.responses = responses;
    }
}

