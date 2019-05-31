package com.sb.erp.doc.dao;

import com.sb.erp.doc.model.DocVO;
import com.sb.erp.doc.model.MemberVO;
import org.apache.ibatis.annotations.Param;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public interface DocDao {

    //	총 방문자수
    int visitCountTotal();

    //	오늘의 방문자수(interval에 1을 넣으면 어제 일자)
    int visitCountPre(int interval);

    //	오늘 날짜 방문 최초 등록
    public int visitToday();

    //  방문자수 카운트
    public int visitCount();

    // 회원 정보 가져오기(로그인)
    MemberVO selectById(String id);

    // 내가 결재할 차례 문서 조회 finish = 1 로 하면 결재 완료된 문서 조회
    ArrayList<DocVO> selectMySign(int memNum, @Param("finish") int finish);

    // 내가 올린 문서 조회 finish = 1 로 하면 결재 완료된 문서 조회
    ArrayList<DocVO> selectMyDoc(int memNum, @Param("finish") int finish);

    // 문서번호로 결재 문서 상세 조회
    DocVO selectDocDetail(int docNum);

    // 모든 멤버 조회
    ArrayList<MemberVO> selectAllMember();

    // 특정 멤버 조회
    MemberVO selectMember(String name);

    // 회원번호로 조회
    MemberVO selectByMemNum(int memNum);

    // 문서 등록 - 기안자가 1명일 경우에는 level을 1로 등록한다. signMem의 레벨이 1 이상이 안되면 자바 코드에서 사전에 등록
    // 거부할것
    void insertDoc(DocVO docVO);

    // 결재자 등록 - 기안자가 1명일 경우에는 level을 1만 등록한다. - 없는 문서 번호일 경우 익셉션을 발생시키니 꼭 try
    // catch문을 적용하자
    void insertSign(DocVO docVO);

    // 문서 level 업데이트
    void updateLevel(@Param("docArray") List<Object> docArray);

    // 결재자가 1명일 경우 기존 결재자를 level 1로 올림
    void updateSignLevel();

    // 문서 삭제(기안 취소)
    void deleteDoc(@Param("docArray") List<Object> docArray);

    // 회원 탈퇴(모든 결재 및 문서 삭제)
    void deleteMember(int memNum);

    // 결재자 삭제 -
    void deleteSignMem(int docNum, int memNum);
}
