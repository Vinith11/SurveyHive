package com.vini.surveyhack.exception;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class ErrorDetails {

    private String error;
    private String details;
    private LocalDateTime timestamp;
}

