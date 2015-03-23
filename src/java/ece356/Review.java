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
    private double star_rating;
    private String comments;
    private Date review_date;
    private SimpleDateFormat ft = 
      new SimpleDateFormat ("yyyy-MM-dd hh:mm:ss.SSS");
    
    public Review(double rating, String comms, Date revDate) {
        this.star_rating = rating;
        this.comments = comms;
        this.review_date = revDate;
    }
    
    public Review(double rating, String comms, String revDate) throws ParseException {
        this.star_rating = rating;
        this.comments = comms;
        this.review_date = ft.parse(revDate);
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
