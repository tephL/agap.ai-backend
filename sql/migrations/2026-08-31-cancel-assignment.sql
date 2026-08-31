-- Allow assignments to be cancelled (e.g. dispatcher revokes dispatch)
ALTER TABLE assignment
  DROP CONSTRAINT IF EXISTS assignment_status_check,
  ADD CONSTRAINT assignment_status_check
    CHECK (status IN ('pending', 'dispatched', 'cancelled', 'resolved'));
