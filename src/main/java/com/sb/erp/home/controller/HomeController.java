package com.sb.erp.home.controller;

import com.sb.erp.doc.model.MemberVO;
import com.sb.erp.home.service.LoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Controller
public class HomeController {

    @Autowired
    private LoginService loginService;

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String home() {
        return "index";
    }

    /*모든 페이지 이동시*/
    @RequestMapping(value = "/{page}", method = RequestMethod.GET)
    public String page(@PathVariable("page") String page) {
        return page;
    }

    /*로그인 페이지*/
    @RequestMapping(value = "/login", method = RequestMethod.GET) // url 주소
    // 쿠키 값 저장
    public ModelAndView getLoginForm(@CookieValue(value = "idcookie", required = false) String rememberId,
                                     @RequestParam(value = "page", required = false) String page,
                                     @RequestParam(value = "memNum", required = false) String memNum,
                                     HttpSession session) {
        // ModelAndView 객체 생성
        ModelAndView modelAndView = new ModelAndView();

        MemberVO memberVO = (MemberVO) session.getAttribute("memberVO");

        // 세션에 저장된 회원번호가 메일에서 보내준 회원번호와 같으면 바로 doc 페이지로 보내준다.
        if (session != null && memberVO != null && memNum != null && Integer.parseInt(memNum) == memberVO.getMemNum()) {

            modelAndView.setViewName("redirect:/doc?page=" + page);

        } else {

            //기존 세션 종료
            session.invalidate();

            // loginForm으로 보내줌
            modelAndView.setViewName("/login");
            modelAndView.addObject("idcookie", rememberId);

        }


        return modelAndView;
    }

    /*로그인*/
    @RequestMapping(value = "/login", method = RequestMethod.POST)
    // id,pw ,session,cookie 값 받아온다. /login(GET) 에서 url 창은 그대로이므로 GET 방식의 파라미터인 page와 memNum도 동시에 받아올 수 있다.
    public ModelAndView loginProcess(
            @RequestParam(value = "id", required = false) String id,
            @RequestParam(value = "pw", required = false) String pw,
            @RequestParam(value = "rememberId", required = false) String rememberId,
            @RequestParam(value = "page", required = false) String page,
            HttpSession session,
            HttpServletResponse response,
            HttpServletRequest request

    ) {

        ModelAndView modelAndView = new ModelAndView();

        // 아이디저장 버튼이 on일 경우 쿠키생성
        if ("on".equals((rememberId))) {
            response.addCookie(new Cookie("idcookie", id));
        }

        // memberVO.getId() 또는 memberVO.getPw()가 null 이 아닌 경우
        if (id != null && pw != null) {
            if (loginService.login(id, pw, session)) {

                if (page != null && !(page.equals(""))) {

                    modelAndView.setViewName("redirect:/doc?page=" + page);

                    return modelAndView;

                } else {
                    modelAndView.setViewName("redirect:/doc");
                }

            } else {
                modelAndView.setViewName("/login"); // 경로
                modelAndView.addObject("error", "아이디 또는 비밀번호가 틀렸습니다.");
            }
        }

        return modelAndView;
    }


    @RequestMapping(value = "/logOut", method = RequestMethod.GET)
    public String logOut(HttpSession session) {
        //세션 종료
        session.invalidate();
        return "redirect:/login";
    }


}
