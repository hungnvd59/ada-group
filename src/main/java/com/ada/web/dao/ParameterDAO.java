/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ada.web.dao;

import com.ada.common.PagingResult;
import com.ada.model.Parameter;
import java.util.Optional;

/**
 * @created_by hungnv
 * @time 12/7/2024.
 */
public interface ParameterDAO {
    
    public Optional<PagingResult> page(PagingResult page, String paramKey);

    public boolean addParam(Parameter paramItem);

    public boolean isExits(Parameter paramItem);

    public boolean editParam(Parameter paramItem);

    public Parameter getParamById(Long id);

    public boolean deleteParam(Parameter parameterDel);
	
    public Parameter getParameterByKey(String paramKey);
    
}
