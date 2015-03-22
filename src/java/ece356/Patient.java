/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ece356;

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
        StringBuffer bufName = new StringBuffer();
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
        StringBuffer bufAddr = new StringBuffer();
        bufAddr.append(strProvince);
        bufAddr.append(" ");
        bufAddr.append(strCity);
        
        return bufAddr.toString();
    }
    
    public String getEmail () {
        return strEmail;
    }
}
