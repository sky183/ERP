package com.sb.erp.doc.service;

import com.sb.erp.doc.dao.DocDao;
import com.sb.erp.doc.model.DocVO;
import com.sb.erp.doc.model.MemberVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Repository
public class DocService {

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;

    private DocDao dao;

    // 총 방문자수
    @Transactional
    public int visitCountTotal() {
        dao = sqlSessionTemplate.getMapper(DocDao.class);

        int visitCountTotal = dao.visitCountTotal();

        return visitCountTotal;

    }
    // 오늘의 방문자수
    @Transactional
    public int visitCountPre(int interval) {
        dao = sqlSessionTemplate.getMapper(DocDao.class);

        int visitCount = dao.visitCountPre(interval);

        return visitCount;

    }

    // 내가 결재할 차례 문서 리스트 조회
    @Transactional
    public ArrayList<DocVO> selectMySign(int memNum, int finish) {
        dao = sqlSessionTemplate.getMapper(DocDao.class);

        ArrayList<DocVO> docList = dao.selectMySign(memNum, finish);

        return docList;

    }

    //    내가 올린 문서 리스트 조회
    @Transactional
    public ArrayList<DocVO> selectMyDoc(int memNum, int finish) {
        dao = sqlSessionTemplate.getMapper(DocDao.class);

        ArrayList<DocVO> docList = dao.selectMyDoc(memNum, finish);

        return docList;
    }

    //    문서번호로 결재 문서 상세 조회
    @Transactional
    public DocVO selectDocDetail(int docNum) {
        dao = sqlSessionTemplate.getMapper(DocDao.class);

        DocVO docVO = dao.selectDocDetail(docNum);

        return docVO;
    }

    //    모든 멤버 조회
    @Transactional
    public ArrayList<MemberVO> selectAllMember() {

        dao = sqlSessionTemplate.getMapper(DocDao.class);

        ArrayList<MemberVO> memberList = dao.selectAllMember();

        return memberList;
    }

    //    특정 멤버 조회
    @Transactional
    public MemberVO selectMember(String name) {
        dao = sqlSessionTemplate.getMapper(DocDao.class);

        MemberVO memberVO = dao.selectMember(name);

        return memberVO;
    }

    //    회원번호로 조회
    @Transactional
    public MemberVO selectByMemNum(int memNum) {
        dao = sqlSessionTemplate.getMapper(DocDao.class);

        MemberVO memberVO = dao.selectByMemNum(memNum);

        return memberVO;
    }


    // 문서 등록
    @Transactional
    public void insertDoc(DocVO docVO) {

        dao = sqlSessionTemplate.getMapper(DocDao.class);
        // 결재를 위해서는 doc에 등록을 하고 sign을 등록한다.
        dao.insertDoc(docVO);

    }

    @Transactional
    public void insertSign(DocVO docVO) {
        dao = sqlSessionTemplate.getMapper(DocDao.class);
        // 결재자 등록 - 기안자가 1명일 경우에는 level을 1만 등록한다. - 없는 문서 번호일 경우 익셉션을 발생시키니 꼭 try catch문을 적용하자
        dao.insertSign(docVO);
    }


    //    문서 level 업데이트(결재)
    @Transactional
    public void updateLevel(List<Object> docArray) {
        dao = sqlSessionTemplate.getMapper(DocDao.class);
        dao.updateLevel(docArray);
    }

    //    결재자가 1명일 경우 기존 결재자를 level 1로 올림 - 결재자 삭제했거나 회원이 탈퇴했을때
    @Transactional
    public void updateSignLevel() {
        dao = sqlSessionTemplate.getMapper(DocDao.class);
        dao.updateSignLevel();
    }

    //  문서 삭제(결재 취소)
    @Transactional
    public void deleteDoc(List<Object> docArray) {
        dao = sqlSessionTemplate.getMapper(DocDao.class);
        dao.deleteDoc(docArray);
    }

    //    회원 탈퇴(모든 결재 및 문서 삭제)
    @Transactional
    public void deleteMember(int memNum) {
        dao = sqlSessionTemplate.getMapper(DocDao.class);
        dao.deleteMember(memNum);
        //    결재자가 1명일 경우 기존 결재자를 level 1로 올림 - 결재자 삭제했거나 회원이 탈퇴했을때
        dao.updateSignLevel();
    }

    //    결재자 삭제
    @Transactional
    public void deleteSignMem(int docNum, int memNum) {
        dao = sqlSessionTemplate.getMapper(DocDao.class);
        dao.deleteSignMem(docNum, memNum);
        //    결재자가 1명일 경우 기존 결재자를 level 1로 올림 - 결재자 삭제했거나 회원이 탈퇴했을때
        dao.updateSignLevel();
    }


}
