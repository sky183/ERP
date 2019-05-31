package com.sb.erp.stastics.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.sb.erp.stastics.service.StService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller
public class StController {

    @Autowired
    private StService service;

    // 서브 페이지 이동시
    @RequestMapping(value = "/stastics/{page}", method = RequestMethod.GET)
    public String subPage(@PathVariable("page") String page) {
        return "doc/" + page;
    }


    /*docMain 이동시*/
    @RequestMapping(value = "/stastics/stMain", method = RequestMethod.GET)
    public ModelAndView docMain() {

        ModelAndView modelAndView = new ModelAndView("stastics/stMain");

        int todayCount = 0;
        int totalCount = 0;

        try {

            todayCount = service.visitCountTotal();
            totalCount = service.visitCountPre(0);

        } catch (Exception e) {
            e.printStackTrace();
        }

        modelAndView.addObject("todayCount", todayCount);
        modelAndView.addObject("totalCount", totalCount);

        return modelAndView;

    }

    /*차트*/
    @RequestMapping(value = "/stastics/chart", method = RequestMethod.GET)
    @ResponseBody
    public String fifthChart(@RequestParam String nowDate) throws JsonProcessingException {

        List<Map<String, Object>> fifthChart = new ArrayList<Map<String,Object>>();

        fifthChart = service.fifthChart(nowDate);

        //JSON으로 변환하는 메서드
        ObjectMapper mapper = new ObjectMapper();
        String fifthVisit = mapper.writeValueAsString(fifthChart);

        return fifthVisit;
    }

}
