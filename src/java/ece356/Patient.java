/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ece356;

import java.util.HashMap;

/**
 *
 * @author Nirmal
 */
public class Patient {
    final private String strFirstName;
    final private String strLastName;
    final private String strMiddleInitial;
    final private String strAlias;
    final private String strProvince;
    final private String strCity;
    final private String strEmail;
    final private int nReviews;
    final private String strLastReviewDate;
    HashMap hmFriends;
    
    public Patient(String strFirstName, String strLastName, String strMiddleInitial, 
                    String strAlias, String strProvince, String strCity,
                    String strEmail) {
        this.strFirstName = strFirstName;
        this.strLastName = strLastName;
        this.strMiddleInitial = strMiddleInitial;
        this.strAlias = strAlias;
        this.strProvince = strProvince;
        this.strCity = strCity;
        this.strEmail = strEmail;
        this.nReviews = 0;
        this.strLastReviewDate = "";
    }
    
    public Patient(String strFirstName, String strLastName, String strMiddleInitial, 
                    String strAlias, String strProvince, String strCity,
                    String strEmail, int nReviews, String strLastReviewDate,
                    HashMap hmFriends) {
        this.strFirstName = strFirstName;
        this.strLastName = strLastName;
        this.strMiddleInitial = strMiddleInitial;
        this.strAlias = strAlias;
        this.strProvince = strProvince;
        this.strCity = strCity;
        this.strEmail = strEmail;
        this.nReviews = nReviews;
        this.strLastReviewDate = strLastReviewDate;
        this.hmFriends = hmFriends;
    }
    
    public String getFirstName() {
        return strFirstName;
    }
    
    public String getLastName() {
        return strLastName;
    }
    
    public String getMiddleInitial() {
        return strMiddleInitial;
    }
    
    public String getFullName() {
        StringBuilder bufName = new StringBuilder();
        bufName.append(strFirstName);
        bufName.append(" ");
        
        if (!strMiddleInitial.isEmpty()) {
            bufName.append(strMiddleInitial);
            bufName.append(" ");
        }
        
        bufName.append(strLastName);
        
        return bufName.toString();
    }
    
    public String getAlias() {
        return strAlias;
    }
    
    public String getCity() {
        return strCity;
    }
    
    public String getProvince() {
        return strProvince;
    }
    
    public String getFullAddress() {
        StringBuilder bufAddr = new StringBuilder();
        bufAddr.append(strProvince);
        bufAddr.append(" ");
        bufAddr.append(strCity);
        
        return bufAddr.toString();
    }
    
    public String getEmail () {
        return strEmail;
    }
    
    public String getLastReviewDate() {
        return strLastReviewDate;
    }
    
    public int getNumberOfReviews() {
        return nReviews;
    }
    
    public HashMap getFriends() {
        return hmFriends;
    }
}
