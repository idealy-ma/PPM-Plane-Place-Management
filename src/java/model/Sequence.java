/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import bdd.object.BddObject;
import java.sql.Connection;
import java.util.ArrayList;

/**
 *
 * @author i.m.a
 */
public final class Sequence extends BddObject{
    private String sequenceName;
    private int value;

    public Sequence() {
    }
    
    public Sequence(String sequenceName) {
        this.setSequenceName(sequenceName);
    }
    
    public String getSequenceName() {
        return sequenceName;
    }

    public void setSequenceName(String sequenceName) {
        this.sequenceName = sequenceName;
    }

    public int getValue() {
        return value;
    }

    public void setValue(int value) {
        this.value = value;
    }
    
    public int nextVal(Connection c) throws Exception {
        String sql = "SELECT cast(nextval('"+this.getSequenceName()+"') as int4) value";
        Sequence s = (Sequence) this.executeResultedQuery(c, sql, new ArrayList<>()).get(0);
        return s.getValue();
    }
}
