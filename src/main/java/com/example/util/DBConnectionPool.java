package com.example.util;

import org.apache.commons.dbcp2.BasicDataSource;

import javax.sql.DataSource;

public class DBConnectionPool {
    private static final BasicDataSource ds = new BasicDataSource();

    static {
        ds.setUrl("jdbc:mysql://localhost:3306/cms_db");
        ds.setDriverClassName("com.mysql.cj.jdbc.Driver");
        ds.setUsername("root");
        ds.setPassword("mysql");
        ds.setMinIdle(5);
        ds.setMaxTotal(10);
        ds.setMaxOpenPreparedStatements(100);
    }

    public static DataSource getDataSource() {
        return ds;
    }

    private DBConnectionPool() { }
}
