package com.sb.erp.doc.model;

public class DocVO {

    private int docNum;
    private String name;
    private int memNum;
    private String title;
    private String content;
    private String selection;
    private String startDate;
    private String endDate;
    private String sign1;
    private String sign2;
    private int signMem1;
    private int signMem2;
    private int level;

    public int getDocNum() {
        return docNum;
    }

    public void setDocNum(int docNum) {
        this.docNum = docNum;
    }

    public String getName() {
        return name;
    }

    public int getMemNum() {
        return memNum;
    }

    public void setMemNum(int memNum) {
        this.memNum = memNum;
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

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getSelection() {
        return selection;
    }

    public void setSelection(String selection) {
        this.selection = selection;
    }

    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    public String getSign1() {
        return sign1;
    }

    public void setSign1(String sign1) {
        this.sign1 = sign1;
    }

    public String getSign2() {
        return sign2;
    }

    public void setSign2(String sign2) { this.sign2 = sign2; }

    public int getSignMem1() { return signMem1;  }

    public void setSignMem1(int signMem1) { this.signMem1 = signMem1; }

    public int getSignMem2() { return signMem2; }

    public void setSignMem2(int signMem2) { this.signMem2 = signMem2; }

    public int getLevel() {
        return level;
    }

    public void setLevel(int level) {
        this.level = level;
    }

    @Override
    public String toString() {
        return "DocVO{" +
                "docNum=" + docNum +
                ", name='" + name + '\'' +
                ", memNum=" + memNum +
                ", title='" + title + '\'' +
                ", content='" + content + '\'' +
                ", selection='" + selection + '\'' +
                ", startDate='" + startDate + '\'' +
                ", endDate='" + endDate + '\'' +
                ", sign1='" + sign1 + '\'' +
                ", sign2='" + sign2 + '\'' +
                ", signMem1=" + signMem1 +
                ", signMem2=" + signMem2 +
                ", level=" + level +
                '}';
    }
}
