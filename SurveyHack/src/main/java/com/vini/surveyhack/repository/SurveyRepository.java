package com.vini.surveyhack.repository;


import com.vini.surveyhack.modal.Survey;
import org.springframework.data.jpa.repository.JpaRepository;

public interface SurveyRepository extends JpaRepository<Survey, Long> {
}
