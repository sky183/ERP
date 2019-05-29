package com.sb.erp.doc.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.sb.erp.doc.dao.DocDao;
import com.sb.erp.doc.model.MemberVO;

public class VisitCountInterceptor extends HandlerInterceptorAdapter {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	private DocDao dao;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		dao = sqlSessionTemplate.getMapper(DocDao.class);

		HttpSession session = request.getSession();
		
		// 로그인이 되어 있는 상태인지 확인
		MemberVO memberVO = (MemberVO) session.getAttribute("memberVO");
		
		if (memberVO == null) {
			return true;
		}
		
		// 세션에 방문자수 카운트가 되어있으면 통과 없으면 카운트한다.
		Boolean userCount = (Boolean) session.getAttribute("userCount");

		if (userCount != null && userCount) {
			return userCount;
		}

		try {
			dao.visitToday();
		} catch (Exception e) {
		} finally {
			try {
				dao.visitCount();
				session.setAttribute("userCount", true);
			} catch (Exception e2) {
				session.setAttribute("userCount", false);
			}
		}

		return true;

	}
}
