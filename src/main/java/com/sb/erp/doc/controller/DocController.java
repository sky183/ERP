package com.sb.erp.doc.controller;

import com.sb.erp.doc.model.DocVO;
import com.sb.erp.doc.model.MemberVO;
import com.sb.erp.doc.service.DocService;
import com.sb.erp.doc.service.MailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.List;

@Controller
public class DocController {

    @Autowired
    private DocService service;

    @Autowired
    private MailService mailService;

    // doc 서브 페이지 이동시
    @RequestMapping(value = "/doc/{page}", method = RequestMethod.GET)
    public String subPage(@PathVariable("page") String page) {
        return "doc/" + page;
    }

    /*doc 메일에서 타고 왔을때 페이지 이동시*/
    @RequestMapping(value = "/doc", method = RequestMethod.GET)
    public ModelAndView mailPage(@RequestParam(value = "page", required = false) String page) {
        ModelAndView modelAndView = new ModelAndView("doc");

        if (!(page == null || page.equals("")))
            modelAndView.addObject("page", page);


        return modelAndView;
    }

    /*결재라인 지정 팝업창 띄우기*/
    @RequestMapping(value = "/doc/popUp", method = RequestMethod.GET)
    public ModelAndView popUp() {

        ModelAndView modelAndView = new ModelAndView("doc/popUp");

        List<MemberVO> memberVOList = new ArrayList<MemberVO>();

        try {
            memberVOList = service.selectAllMember();
        } catch (Exception e) {
            e.printStackTrace();
        }

        modelAndView.addObject("memberVOList", memberVOList);

        return modelAndView;
    }

    /*docMain 이동시*/
    @RequestMapping(value = "/doc/docMain", method = RequestMethod.GET)
    public ModelAndView docMain(@RequestParam(value = "memNum", required = false) int memNum) {

        ModelAndView modelAndView = new ModelAndView("doc/docMain");

        List<DocVO> mySignBefore = new ArrayList<DocVO>();
        List<DocVO> mySignAfter = new ArrayList<DocVO>();
        List<DocVO> signBefore = new ArrayList<DocVO>();
        List<DocVO> signAfter = new ArrayList<DocVO>();

        int mySignBeforeCount = 0;
        int mySignAfterCount = 0;
        int signBeforeCount = 0;
        int signAfterCount = 0;
        int todayCount = 0;
        int totalCount = 0;

        try {
            mySignBefore = service.selectMySign(memNum, 0);
            mySignAfter = service.selectMySign(memNum, 1);
            signBefore = service.selectMyDoc(memNum, 0);
            signAfter = service.selectMyDoc(memNum, 1);
            todayCount = service.visitCountTotal();
            totalCount = service.visitCountPre(0);
            mySignBeforeCount = mySignBefore.size();
            mySignAfterCount = mySignAfter.size();
            signBeforeCount = signBefore.size();
            signAfterCount = signAfter.size();
        } catch (Exception e) {
            e.printStackTrace();
        }

        modelAndView.addObject("mySignBeforeCount", mySignBeforeCount);
        modelAndView.addObject("mySignAfterCount", mySignAfterCount);
        modelAndView.addObject("signBeforeCount", signBeforeCount);
        modelAndView.addObject("signAfterCount", signAfterCount);
        modelAndView.addObject("todayCount", todayCount);
        modelAndView.addObject("totalCount", totalCount);

        return modelAndView;

    }

    // 내가 결재할 차례 문서 리스트 조회
    @RequestMapping(value = "/doc/selectMySign", method = RequestMethod.GET)
    public ModelAndView selectMySign(@RequestParam(value = "page", required = true) String page,
                                     @RequestParam(value = "memNum", required = true) int memNum,
                                     @RequestParam(value = "finish", required = true) int finish) {

        ModelAndView modelAndView = new ModelAndView();

        modelAndView.setViewName("doc/" + page);

        List<DocVO> docVOList = new ArrayList<DocVO>();
        int docCount = 0;

        try {
            docVOList = service.selectMySign(memNum, finish);
            docCount = docVOList.size();
        } catch (Exception e) {
            e.printStackTrace();
        }

        modelAndView.addObject("docVOList", docVOList);
        modelAndView.addObject("docCount", docCount);

        return modelAndView;

    }

    //    내가 올린 문서 리스트 조회
    @RequestMapping(value = "/doc/selectMyDoc", method = RequestMethod.GET)
    public ModelAndView selectMyDoc(@RequestParam(value = "page", required = true) String page,
                                    @RequestParam(value = "memNum", required = true) int memNum,
                                    @RequestParam(value = "finish", required = true) int finish) {

        ModelAndView modelAndView = new ModelAndView();

        modelAndView.setViewName("doc/" + page);

        List<DocVO> docVOList = new ArrayList<DocVO>();
        int docCount = 0;

        try {
            docVOList = service.selectMyDoc(memNum, finish);
            docCount = docVOList.size();
        } catch (Exception e) {
            e.printStackTrace();
        }

        modelAndView.addObject("docVOList", docVOList);
        modelAndView.addObject("docCount", docCount);

        return modelAndView;
    }

    //    모든 멤버 조회
    @RequestMapping(value = "/doc/memberList", method = RequestMethod.GET)
    @ResponseBody
    public ModelAndView memberList() {
        ModelAndView modelAndView = new ModelAndView();

        List<MemberVO> memberVOList = new ArrayList<MemberVO>();

        try {
            memberVOList = service.selectAllMember();
        } catch (Exception e) {
            e.printStackTrace();
        }

        modelAndView.addObject("memberVOList", memberVOList);

        return modelAndView;
    }


    //    특정 멤버 조회
    @RequestMapping(value = "/doc/selectMember", method = RequestMethod.GET)
    @ResponseBody
    public MemberVO selectMember(@RequestParam(value = "name") String name) {

        MemberVO memberVO = new MemberVO();
        try {
            memberVO = service.selectMember(name);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return memberVO;

    }


    //문서번호로 결재 문서 상세 조회
    @RequestMapping(value = "/doc/selectDocDetail", method = RequestMethod.GET)
    public ModelAndView selectDocDetail(@RequestParam(value = "docNum", required = true) int docNum) {

        ModelAndView modelAndView = new ModelAndView();

        DocVO docVO = service.selectDocDetail(docNum);

        try {
            docVO = service.selectDocDetail(docNum);
        } catch (Exception e) {
            e.printStackTrace();
        }

        modelAndView.addObject("docVO", docVO);

        return modelAndView;
    }

    // 문서 등록
    @RequestMapping(value = "/doc/insertDoc", method = RequestMethod.POST)
    @ResponseBody
    public String insertDoc(DocVO docVO) {

        ModelAndView modelAndView = new ModelAndView();

        modelAndView.setViewName("");

        MemberVO myMem = service.selectByMemNum(docVO.getMemNum());
        MemberVO mem1 = service.selectMember(docVO.getSign1());
        MemberVO mem2 = null;
        try {
            mem2 = service.selectMember(docVO.getSign2());

            if (mem1.getTitleNum() > 0 && mem2.getTitleNum() > 0) {
                try {
                    service.insertDoc(docVO);
                    service.insertSign(docVO);
                    mailService.mailSendHtml(myMem, mem1);
                    mailService.mailSendHtml(myMem, mem2);
                    return "등록 완료!";
                } catch (Exception e) {
                    e.printStackTrace();
                    return "등록 실패! 값이 누락되었습니다!";
                }
            } else {
                return "등록 실패! 결재 승인자는 관리자급 이상으로 해야합니다.";
            }

        } catch (Exception e) {
            if (mem1.getTitleNum() > 0) {
                try {
                    service.insertDoc(docVO);
                    service.insertSign(docVO);
                    mailService.mailSendHtml(myMem, mem1);
                    return "등록 완료!";
                } catch (Exception ex) {
                    ex.printStackTrace();
                    return "등록 실패! 값이 누락되었습니다!";
                }
            } else {
                return "등록 실패! 결재 승인자는 관리자급 이상으로 해야합니다.";
            }
        }


    }


    // 결재할 문서 level 업데이트 - 결재
    @RequestMapping(value = "/doc/updateLevel", method = RequestMethod.POST)
    @ResponseBody
    public String updateLevel(@RequestBody List<Object> docArray) {

        try {
            service.updateLevel(docArray);
            System.out.println(docArray);
            return "결재 완료!";
        } catch (Exception e) {
            e.printStackTrace();
            return "결재 실패!";
        }
    }

    // 결재자가 1명일 경우 기존 결재자를 level 1로 올림
    @RequestMapping(value = "/doc/updateSignLevel", method = RequestMethod.GET)
    @ResponseBody
    public String updateSignLevel() {

        try {
            service.updateSignLevel();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "완료!";
    }

    // 문서 삭제(결재 취소)
    @RequestMapping(value = "/doc/deleteDoc", method = RequestMethod.POST)
    @ResponseBody
    public String deleteDoc(@RequestBody List<Object> docArray) {

        try {
            service.deleteDoc(docArray);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "삭제 완료!";
    }

    //    회원 탈퇴(모든 결재 및 문서 삭제)
    @RequestMapping(value = "/doc/deleteMember", method = RequestMethod.GET)
    @ResponseBody
    public String deleteMember(@RequestParam("docNum ") int docNum) {

        try {
            service.deleteMember(docNum);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "탈퇴 완료!";
    }

    //    결재자 삭제
    @RequestMapping(value = "/doc/deleteSignMem", method = RequestMethod.GET)
    @ResponseBody
    public String deleteSignMem(@RequestParam("docNum ") int docNum, @RequestParam("memNum ") int memNum) {

        try {
            service.deleteSignMem(docNum, memNum);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "결재 완료!";
    }
}
