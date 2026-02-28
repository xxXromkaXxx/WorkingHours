CREATE TABLE IF NOT EXISTS users (
    chatid BIGINT PRIMARY KEY,
    username TEXT,
    reminder_hour INTEGER,
    reminder_minute INTEGER,
    timezone TEXT DEFAULT 'Europe/Warsaw'
);

CREATE TABLE IF NOT EXISTS work_types (
    work_id BIGSERIAL PRIMARY KEY,
    chatid BIGINT NOT NULL REFERENCES users(chatid) ON DELETE CASCADE,
    work_name TEXT NOT NULL,
    CONSTRAINT work_types_chatid_work_name_key UNIQUE (chatid, work_name)
);

CREATE TABLE IF NOT EXISTS work_hours (
    id BIGSERIAL PRIMARY KEY,
    chatid BIGINT NOT NULL REFERENCES users(chatid) ON DELETE CASCADE,
    work_id BIGINT NOT NULL REFERENCES work_types(work_id) ON DELETE CASCADE,
    month INTEGER NOT NULL CHECK (month BETWEEN 1 AND 12),
    work_data JSONB NOT NULL DEFAULT '{}'::jsonb,
    CONSTRAINT work_hours_chatid_work_id_month_key UNIQUE (chatid, work_id, month)
);

CREATE INDEX IF NOT EXISTS idx_work_types_chatid ON work_types(chatid);
CREATE INDEX IF NOT EXISTS idx_work_hours_chatid_month ON work_hours(chatid, month);
