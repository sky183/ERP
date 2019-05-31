package com.sb.erp.stastics.service;

import com.sb.erp.stastics.dao.StDao;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Repository
public class StService {

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;

    private StDao dao;

    // 총 방문자수
    @Transactional
    public int visitCountTotal() {
        dao = sqlSessionTemplate.getMapper(StDao.class);

        int visitCountTotal = dao.visitCountTotal();

        return visitCountTotal;

    }
    // 오늘의 방문자수
    @Transactional
    public int visitCountPre(int interval) {
        dao = sqlSessionTemplate.getMapper(StDao.class);

        int visitCount = dao.visitCountPre(interval);

        return visitCount;

    }

    //최근 15일 방문수 조회
    @Transactional
    public List<Map<String, Object>> fifthChart(Object nowDate) {

        dao = sqlSessionTemplate.getMapper(StDao.class);

        List<Map<String, Object>> fifthChart = new ArrayList<Map<String,Object>>();

        fifthChart = dao.getFifthChart(nowDate);

        return fifthChart;
    }



}
