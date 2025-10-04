BEGIN;

ALTER TABLE work_orders
    ADD COLUMN opening_date DATE DEFAULT CURRENT_DATE,
    ADD COLUMN task_start_date DATE,
    ADD COLUMN task_end_date DATE;

UPDATE work_orders
SET opening_date = created_at::date
WHERE opening_date IS NULL;

UPDATE work_orders
SET task_start_date = scheduled_date
WHERE scheduled_date IS NOT NULL;

UPDATE work_orders
SET task_end_date = scheduled_date
WHERE scheduled_date IS NOT NULL;

ALTER TABLE work_orders
    DROP COLUMN scheduled_date;

ALTER TABLE work_orders
    ALTER COLUMN opening_date SET NOT NULL;

COMMIT;
