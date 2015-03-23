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
public class Doctor
{
    private int licensed_since, num_review;
    private double average_rating;
    private String first_name, last_name, middle_initial, street, postal_code,
            description, gender, comments;
    
    public Doctor(String gen, int license_since, int review_num,
            String firstName, String lastName, String middleInit, String st,
            String post, String descrip, double avg_rate, String comms)
    {
        this.gender = gen;
        this.licensed_since = license_since;
        this.num_review = review_num;
        this.first_name = firstName;
        this.last_name = lastName;
        this.middle_initial = middleInit;
        this.street = st;
        this.description = descrip;
        this.average_rating = avg_rate;
        this.postal_code = post;
        this.comments = comms;
    }
    
    public String get_Name()
    {
        return this.first_name + " " + this.last_name + " " +
                this.middle_initial;
    }
    
    public String get_Gender()
    {
        return this.gender;
    }
    
    public String get_Address()
    {
        return this.street + " " + this.postal_code;
    }
    
    public String get_Description()
    {
        return this.description;
    }
    
    public int get_Licensed_Since()
    {
        return this.licensed_since;
    }
    
    public double get_Avg_Rating()
    {
        return this.average_rating;
    }
    
    public int get_Num_Review()
    {
        return this.num_review;
    }
}
