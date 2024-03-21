package com.ada.model.dto;

import com.ada.model.User;
import lombok.Data;

@Data
public class ChangePassDto {
    private String passwordNew;
    private String passwordCurrent;
}
