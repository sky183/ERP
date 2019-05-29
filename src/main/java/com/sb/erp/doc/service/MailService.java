package com.sb.erp.doc.service;

import com.sb.erp.doc.model.MemberVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Component;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

@Component
public class MailService {

    @Autowired
    private JavaMailSender mailSender;

    /*HTML형식 Mail 보내기*/
    public void mailSendHtml(MemberVO myMem, MemberVO memberVO) {

        MimeMessage message1 = mailSender.createMimeMessage();

        int memNum = memberVO.getMemNum();

        try {
            message1.setSubject(memberVO.getName() +"님! "+ myMem.getName() + " 님의 상신 문서가 도착하였습니다.", "utf-8");
            String htmlStr =
                    "<a href=\"http://localhost/ERP/login?page=sign&memNum="+ memNum +"\">사이트로 이동하시려면 클릭하세요</a>";

            message1.setText(htmlStr, "utf-8", "html");

            message1.addRecipient(MimeMessage.RecipientType.TO, new InternetAddress(memberVO.getEmail()));

            mailSender.send(message1);
        } catch (MessagingException e) {
            e.printStackTrace();
        }

    }
}
