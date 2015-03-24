/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ece356;

import java.text.ParseException;
import java.util.Date;
import java.text.SimpleDateFormat;
/**
 *
 * @author suvignes
 */
public class Review {
    private String patient_alias;
    private String doctor_alias;
    private double star_rating;
    private String comments;
    private Date review_date;
    private SimpleDateFormat ft = 
      new SimpleDateFormat ("yyyy-MM-dd hh:mm:ss.SSS");
    
    public Review(String patient_alias, String doctor_alias, double rating, String comms, Date revDate) {
        this.patient_alias = patient_alias;
        this.doctor_alias = doctor_alias;
        this.star_rating = rating;
        this.comments = comms;
        this.review_date = revDate;
    }
    
    public Review(String patient_alias, String doctor_alias, double rating, String comms, String revDate) throws ParseException {
        this.patient_alias = patient_alias;
        this.doctor_alias = doctor_alias;
        this.star_rating = rating;
        this.comments = comms;
        this.review_date = ft.parse(revDate);
    }
    
    public String get_DoctorAlias() {
        return this.doctor_alias;
    }
    
    public String get_PatientAlias() {
        return this.patient_alias;
    }
    
    public double get_Rating() {
        return this.star_rating;
    }
    
    public String get_Comments() {
        return this.comments;
    }
    
    public Date get_Review_Date() {
        return this.review_date;
    }
    
    @Override public String toString() {
        return this.review_date + " " + this.star_rating;
    }
}
