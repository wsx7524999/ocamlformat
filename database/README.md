# Database Files

This directory contains SQL schema files for OCamlFormat project metadata tracking.

## Files

### project_metadata.sql
A SQLite database schema for tracking:
- OCamlFormat version releases and stability information
- Format configurations used across different projects
- Formatting statistics (performance, line changes)
- User feedback and issue tracking

## Usage

### Creating the Database
```bash
sqlite3 ocamlformat_metadata.db < project_metadata.sql
```

### Querying Version Information
```sql
SELECT * FROM ocamlformat_versions WHERE is_stable = 1;
```

### Checking Formatting Statistics
```sql
SELECT * FROM format_stats_summary;
```

### Viewing Active Configurations
```sql
SELECT * FROM active_configurations LIMIT 10;
```

## Purpose

This database schema is designed to help projects track their OCamlFormat usage, including:
- Version adoption across different projects
- Performance metrics over time
- Configuration patterns and best practices
- Community feedback and issues

## Integration

The schema can be integrated with CI/CD pipelines to automatically track formatting operations, performance metrics, and configuration changes across your OCaml projects.

## Notes

- The schema uses SQLite syntax and is compatible with SQLite 3.x
- Sample data is included for demonstration purposes
- Views are provided for common queries
- Indexes are created for optimal query performance
