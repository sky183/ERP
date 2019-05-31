package com.sb.erp.stastics.model;

public class VisitStVO {
    private int dayCount;
    private int totalCount;

    public int getDayCount() {
        return dayCount;
    }

    public void setDayCount(int dayCount) {
        this.dayCount = dayCount;
    }

    public int getTotalCount() {
        return totalCount;
    }

    public void setTotalCount(int totalCount) {
        this.totalCount = totalCount;
    }

    @Override
    public String toString() {
        return "VisitStVO{" +
                "dayCount=" + dayCount +
                ", totalCount=" + totalCount +
                '}';
    }
}
