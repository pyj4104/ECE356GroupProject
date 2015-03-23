/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ece356;

/**
 *
 * @author yeounjunpark
 */
public class DoctorDBAO
{
    private int docLicenseDuration;
    private double docAvgRating; 
    private String docFirstName, docMiddleInitial, docLastName, docPostalCode, 
                   docGender, docSpec, docReviewKeywords, docStreet, docProvince,
                   docCity;
    private boolean docReviewedByPatientFriend;
    
    public DoctorDBAO(String first_name, String middle_init, String last_name, 
                  String postal_code, int licensed_since, double avgRating, 
                  String specialization, String gender, String street, 
                  String keywords, String province, String city,
                  boolean reviewedByFriend)  
    {
        this.docFirstName = first_name;
        this.docMiddleInitial = middle_init;
        this.docLastName = last_name;
        this.docPostalCode = postal_code;
        this.docLicenseDuration = licensed_since;
        this.docAvgRating = avgRating;
        this.docSpec = specialization;
        this.docGender = gender; 
        this.docStreet = street;
        this.docReviewKeywords = keywords;
        this.docProvince = province;
        this.docCity = city;
        this.docReviewedByPatientFriend = reviewedByFriend;
    }
    
    public String get_FirstName()
    {
        return this.docFirstName;
    }
    
    public String get_MiddleInitial()
    {
        return this.docMiddleInitial;
    } 

    public String get_LastName()
    {
        return this.docLastName;
    }
    
    public String get_Street()
    {
        return this.docStreet;
    }
    
    public String get_PostalCode()
    {
        return this.docPostalCode;
    }
    
    public String get_Specialization()
    {
        return this.docSpec;
    }
   
    public String get_Gender()
    {
        return this.docGender;
    }

    public int get_LicenseDuration()
    {
        return this.docLicenseDuration;
    }
    
    public double get_AvgRating()
    {
        return this.docAvgRating;
    }
    
    public String get_ReviewKeywords()
    {
        return this.docReviewKeywords;
    }

    public boolean get_IsReviewedByPatientFriend()
    {
        return this.docReviewedByPatientFriend;
    }
    
    public String get_Province() {
        return this.docProvince;
    }
    
    public String get_City() {
        return this.docCity;
    }
}
