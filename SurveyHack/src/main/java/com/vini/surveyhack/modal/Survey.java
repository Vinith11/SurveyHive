package com.vini.surveyhack.modal;


import jakarta.persistence.Id;
import jakarta.persistence.*;
import java.util.List;

@Entity
public class Survey {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String title;

    @ElementCollection
    private List<String> questions;

    // Constructors, getters, and setters
    public Survey() {}

    public Survey(String title, List<String> questions) {
        this.title = title;
        this.questions = questions;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public List<String> getQuestions() {
        return questions;
    }

    public void setQuestions(List<String> questions) {
        this.questions = questions;
    }
}

