package com.sb.erp.doc.interceptor;

import com.sb.erp.doc.model.MemberVO;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginInterceptor extends HandlerInterceptorAdapter {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        // 세션에 로그인 정보 유부 확인
        HttpSession session = request.getSession(false);

        if (session != null) {

            MemberVO memberVO = (MemberVO) session.getAttribute("memberVO");

            if (memberVO != null) {
                return true;
            }
        }

/*        try {

            String page = request.getParameter("page");

            if (page != null && !(page.equals(""))) {

                RequestDispatcher rd = request.getRequestDispatcher("login");

                rd.forward(request, response);

                return false;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }*/

        response.sendRedirect(request.getContextPath() + "/login");

        return false;
    }
}
