package Helper;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import java.sql.Connection;

/**
 * OPTIMIZED Config using HikariCP connection pool.
 *
 * BEFORE: new DriverManager.getConnection() on EVERY request = 200-800ms cold TCP each time.
 * AFTER:  pool of warm, reusable connections = 1-5ms per borrow.
 *
 * Pool is initialized ONCE (static block) for the whole app lifetime.
 */
public class Config {

    private static final HikariDataSource pool;

    static {
        HikariConfig cfg = new HikariConfig();

        String url  = System.getenv("DB_URL");
        String user = System.getenv("DB_USER");
        String pass = System.getenv("DB_PASSWORD");

        // Append performance params if not already in URL
        if (url != null && !url.contains("useSSL")) {
            url += (url.contains("?") ? "&" : "?")
                 + "useSSL=false"
                 + "&allowPublicKeyRetrieval=true"
                 + "&serverTimezone=UTC"
                 + "&cachePrepStmts=true"
                 + "&prepStmtCacheSize=250"
                 + "&prepStmtCacheSqlLimit=2048"
                 + "&useServerPrepStmts=true"
                 + "&rewriteBatchedStatements=true";
        }

        cfg.setJdbcUrl(url);
        cfg.setUsername(user);
        cfg.setPassword(pass);
        cfg.setDriverClassName("com.mysql.cj.jdbc.Driver");

        // Pool sizing - tuned for Render free tier (limited CPU/RAM)
        cfg.setMaximumPoolSize(10);          // max 10 simultaneous DB connections
        cfg.setMinimumIdle(2);              // keep 2 warm at all times
        cfg.setIdleTimeout(300000);         // 5 min idle before closing extra connections
        cfg.setConnectionTimeout(10000);    // 10s to get a connection before failing
        cfg.setMaxLifetime(1800000);        // recycle connections every 30 min (avoids stale)
        cfg.setKeepaliveTime(60000);        // ping DB every 60s to prevent firewall drops

        // Fast health-check query
        cfg.setConnectionTestQuery("SELECT 1");
        cfg.setPoolName("Study4DiplomaPool");

        pool = new HikariDataSource(cfg);
        System.out.println("✅ HikariCP connection pool initialized");
    }

    /**
     * Borrow a connection from the pool.
     * IMPORTANT: callers MUST close() the connection after use so it returns to pool.
     * Use try-with-resources: try (Connection con = new Config().getConnection()) { ... }
     */
    public Connection getConnection() {
        try {
            return pool.getConnection();
        } catch (Exception e) {
            System.out.println("DB connection error: " + e);
            return null;
        }
    }
}
