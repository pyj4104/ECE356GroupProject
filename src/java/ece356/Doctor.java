/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ece356;

import java.util.ArrayList;

/**
 *
 * @author yeounjunpark
 */
public class Doctor
{
    private int licensed_since, num_review;
    private double average_rating;
    private String alias, first_name, last_name, middle_initial, gender, email;
    private ArrayList<String> specializations;
    private ArrayList<WorkAddress> work_addresses;
    private ArrayList<Review> reviews;
    
    public Doctor()
    {
    }
    
    public Doctor(String alias, String gen, int license_since, int review_num,
            String firstName, String lastName, String middleInit, ArrayList<WorkAddress> wAddrs,
            ArrayList<String> specs, double avg_rate, ArrayList<Review> reviews)
    {
        this.alias = alias;
        this.gender = gen;
        this.licensed_since = license_since;
        this.num_review = review_num;
        this.first_name = firstName;
        this.last_name = lastName;
        this.middle_initial = middleInit;
        this.work_addresses = wAddrs;
        this.specializations = specs;
        this.average_rating = avg_rate;
        this.reviews = reviews;
    }

    
    public Doctor(String gen, int license_since, int review_num,
            String firstNom, String lastNom, String middleInit, String st,
            String post, String descrip, int avg_rate, String mail)
    {
        this.gender = gen;
        this.licensed_since = license_since;
        this.num_review = review_num;
        this.first_name = firstNom;
        this.last_name = lastNom;
        this.middle_initial = middleInit;
        this.average_rating = avg_rate;
        this.email = mail;
    }
    
    public String get_Alias()
    {
        return this.alias;
    }
    
    public String get_Email()
    {
        return this.email;
    }
    
    public String get_Name()
    {
        return this.first_name + " " + this.middle_initial + " " +
                this.last_name;
    }
    
    public String get_Gender()
    {
        return this.gender;
    }
    
    public ArrayList<WorkAddress> get_Addresses()
    {
        return this.work_addresses;
    }
    
    public ArrayList<String> get_Specializations()
    {
        return this.specializations;
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
    
    public ArrayList<Review> get_Reviews() {
        return this.reviews;
    }
}
