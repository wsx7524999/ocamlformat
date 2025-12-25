-- OCamlFormat Project Metadata Database Schema
-- This schema stores metadata about the OCamlFormat project including
-- version information, usage statistics, and configuration tracking

-- Create table for version tracking
CREATE TABLE IF NOT EXISTS ocamlformat_versions (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    version_number VARCHAR(20) NOT NULL UNIQUE,
    release_date DATE,
    is_stable BOOLEAN DEFAULT 0,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create table for tracking format configurations
CREATE TABLE IF NOT EXISTS format_configurations (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    config_name VARCHAR(100) NOT NULL,
    profile VARCHAR(50),
    margin INTEGER,
    version_constraint VARCHAR(20),
    project_name VARCHAR(200),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create table for tracking formatting statistics
CREATE TABLE IF NOT EXISTS format_statistics (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    file_path VARCHAR(500),
    original_lines INTEGER,
    formatted_lines INTEGER,
    format_time_ms INTEGER,
    ocamlformat_version VARCHAR(20),
    formatted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create table for issue tracking and feedback
CREATE TABLE IF NOT EXISTS user_feedback (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    feedback_type VARCHAR(50),
    issue_number INTEGER,
    description TEXT,
    status VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert sample version data (update with current versions as needed)
-- These are example values for demonstration purposes
INSERT INTO ocamlformat_versions (version_number, release_date, is_stable, description)
VALUES 
    ('0.26.2', '2024-03-15', 1, 'Stable release with improved formatting'),
    ('0.26.1', '2024-02-10', 1, 'Bug fix release'),
    ('0.26.0', '2024-01-20', 1, 'Major feature update');

-- Create indexes for performance
CREATE INDEX IF NOT EXISTS idx_version_number ON ocamlformat_versions(version_number);
CREATE INDEX IF NOT EXISTS idx_format_config_project ON format_configurations(project_name);
CREATE INDEX IF NOT EXISTS idx_format_stats_version ON format_statistics(ocamlformat_version);
CREATE INDEX IF NOT EXISTS idx_feedback_status ON user_feedback(status);

-- Create view for active configurations
CREATE VIEW IF NOT EXISTS active_configurations AS
SELECT 
    fc.config_name,
    fc.profile,
    fc.margin,
    fc.version_constraint,
    fc.project_name,
    fc.created_at
FROM format_configurations fc
ORDER BY fc.created_at DESC;

-- Create view for formatting statistics summary
CREATE VIEW IF NOT EXISTS format_stats_summary AS
SELECT 
    ocamlformat_version,
    COUNT(*) as total_files_formatted,
    AVG(format_time_ms) as avg_format_time,
    SUM(formatted_lines - original_lines) as total_lines_changed
FROM format_statistics
GROUP BY ocamlformat_version;
