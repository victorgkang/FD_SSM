package com.qiang.service;

import com.qiang.domain.Evaluation;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * @author Mr.锵
 * date 2020-03-01
 */
public interface IEvaluationService {
    /**
     * 保存用户评价
     * @param evaluation
     */
    void saveEvaluation(Evaluation evaluation);


    List<Evaluation> findAll();


    List<Evaluation> findMine(String cs_id);
}
