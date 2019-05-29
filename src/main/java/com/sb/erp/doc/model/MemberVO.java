package com.sb.erp.doc.model;

public class MemberVO {

    int memNum;
    String id;
    String pw;
    String name;
    String title;
    int titleNum;
    String email;

    public int getMemNum() {
        return memNum;
    }

    public void setMemNum(int memNum) {
        this.memNum = memNum;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPw() {
        return pw;
    }

    public void setPw(String pw) {
        this.pw = pw;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public int getTitleNum() {
        return titleNum;
    }

    public void setTitleNum(int titleNum) {
        this.titleNum = titleNum;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    @Override
    public String toString() {
        return "MemberVO{" +
                "memNum=" + memNum +
                ", id='" + id + '\'' +
                ", pw='" + pw + '\'' +
                ", name='" + name + '\'' +
                ", title='" + title + '\'' +
                ", titleNum=" + titleNum +
                ", email='" + email + '\'' +
                '}';
    }
}
