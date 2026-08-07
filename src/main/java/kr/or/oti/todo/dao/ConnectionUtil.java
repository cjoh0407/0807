package kr.or.oti.todo.dao;

import java.sql.Connection;
import java.sql.SQLException;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

public enum ConnectionUtil {
	INSTANCE;
	
	private HikariDataSource ds;
	
	ConnectionUtil() {
		HikariConfig config = new HikariConfig();
		config.setDriverClassName("org.mariadb.jdbc.Driver");
		config.setJdbcUrl("jdbc:mariadb://localhost:23306/kosa_db");
		config.setUsername("root");
		config.setPassword("kosa1004");
		
		ds = new HikariDataSource(config);
	}
	
	public Connection getConnection() throws SQLException {
		return ds.getConnection();
	}
}
