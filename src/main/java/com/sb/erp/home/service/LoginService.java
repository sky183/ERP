package com.sb.erp.home.service;


import com.sb.erp.doc.dao.DocDao;
import com.sb.erp.doc.model.MemberVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpSession;

@Repository
public class LoginService {

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;

    private DocDao dao;

    @Transactional
    public boolean login(String id, String pw, HttpSession session) {

        int a = 0;

        dao = sqlSessionTemplate.getMapper(DocDao.class);

        boolean result = false;

        MemberVO memberVO = dao.selectById(id);

        // 비밀번호 비교
        if (memberVO != null && memberVO.getPw().equals(pw)) {
            // 로그인 처리 : 세션에 사용자 데이터 저장
            memberVO.setPw("");        //db에서 받아온 패스워드를 세션에는 제외하고 저장

            session.setAttribute("memberVO", memberVO);

            //세션 시간
            session.setMaxInactiveInterval(60 * 60 * 2);

            result = true;
        }

        return result;

    }
}

