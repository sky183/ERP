package com.sb.erp.stastics.dao;

import java.util.List;
import java.util.Map;

public interface StDao {

    //	총 방문자수
    int visitCountTotal();

    //	오늘의 방문자수(interval에 1을 넣으면 어제 일자)
    int visitCountPre(int interval);

    // 최근 15일 통계를 불러온다.
    public List<Map<String, Object>> getFifthChart(Object nowDate);


}
