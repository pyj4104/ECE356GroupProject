/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ece356;

/**
 *
 * @author suvignes
 */
public class WorkAddress {
    private String province, city, street, postal_code;
    
    public WorkAddress(String prov, String city, String str, String pc) {
        this.province = prov;
        this.city = city;
        this.street = str;
        this.postal_code = pc;
    }
    
    public WorkAddress() {}
    
    public String get_Province() {
        return this.province;
    }
    
    public String get_City() {
        return this.city;
    }
        
    public String get_Street() {
        return this.street;
    }
            
    public String get_Postal_Code() {
        return this.postal_code;
    }
    
    public String get_Address() {
        String address = "";
        if (!this.street.isEmpty())
        {
            address += (this.street);
        }
        if (!this.postal_code.isEmpty())
        {
            address += (", " + this.postal_code);
        }
        if (!this.city.isEmpty())
        {
            address += (", " + this.city);
        }
        if (!this.province.isEmpty())
        {
            address += (", " + this.province);
        }
        return address;
    }
    
    @Override public String toString() {
        return get_Address();
    }
}
